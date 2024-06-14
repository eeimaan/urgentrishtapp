
import 'package:flutter/material.dart';
import 'package:urgentrishtapp/constants/constants.dart';
import 'package:urgentrishtapp/db_service/chat_db_services.dart';
import 'package:urgentrishtapp/models/chat_models/chat_all_participants_model.dart';
import 'package:urgentrishtapp/utils/app_utils.dart';
import 'package:urgentrishtapp/widgets/chat_components/custom_builder_list_tile.dart';
import 'package:urgentrishtapp/widgets/widgets.dart';

class ChatMainScreen extends StatefulWidget {
  const ChatMainScreen({Key? key}) : super(key: key);

  @override
  State<ChatMainScreen> createState() => _ChatMainScreenState();
}

class _ChatMainScreenState extends State<ChatMainScreen> {
  late Stream<List<ChatParticipantsModel>> _stream;
  late ValueNotifier<String> searchProvider;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchProvider = ValueNotifier<String>('');
    searchController.addListener(() {
      searchProvider.value = searchController.text;
    });

    _stream = ChatDBServices.fetchIndividualChatUsers(isConnected: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
       automaticallyImplyLeading: true,
        title: const Text(
          'Chat',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: FontConstants.xlarge, fontWeight: FontWeight.w500),
        ),
      ),
     
      floatingActionButton: InkWell(
        onTap: () {
          Navigator.popAndPushNamed(
              context, AppRoutes.allParticipantsUserScreen);
        },
        child: Container(
          width: 56,
          height: 56,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: ColorConstants.pink,
          ),
          child: const Padding(
              padding: EdgeInsets.all(15), child: Icon(Icons.chat)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextFieldWidget(
              hintText: 'Search users here',
              controller: searchController,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.black, width: 0.3),
              ),
              suffixIcon: const Icon(
                Icons.search,
              ),
              obscureText: false,
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              flex: 8,
              child: ValueListenableBuilder<String>(
                valueListenable: searchProvider,
                builder: (context, searchQuery, child) {
                  return StreamBuilder<List<ChatParticipantsModel>>(
                    stream: _stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<ChatParticipantsModel> users = snapshot.data!;
                        List<ChatParticipantsModel> filteredUsers =
                            users.where((user) {
                          return user.name!
                              .toLowerCase()
                              .contains(searchQuery.toLowerCase());
                        }).toList();
                        return filteredUsers.isEmpty
                            ? const Center(
                                child: Text('No results found'),
                              )
                            : ListView.separated(
                                itemCount: filteredUsers.length,
                                itemBuilder: (context, index) {
                                  ChatParticipantsModel userData =
                                      filteredUsers[index];
                                  return InkWell(
                                    onTap: () {
                                      Navigator.pushReplacementNamed(context,
                                          AppRoutes.individualMessagesScreen,
                                          arguments: userData);
                                    },
                                    child: ChatTile(
                                      type: userData.chatMsg?.type,
                                      trailing: Column(
                                        children: [
                                          Text(
                                            formatDateForChatTile(
                                              timestamp: userData.chatMsg?.time,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                      isOnline: true,
                                      imagePath: userData.imageURL,
                                      title: userData.name,
                                      msg: '${userData.chatMsg?.message}',
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const Divider(
                                    height: 20,
                                    thickness: 0.4,
                                    endIndent: 1,
                                    indent: 1,
                                  );
                                },
                              );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
