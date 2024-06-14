import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:urgentrishtapp/db_service/chat_db_services.dart';
import 'package:urgentrishtapp/widgets/chat_components/custom_builder_list_tile.dart';
import 'package:urgentrishtapp/widgets/widgets.dart';
import '../../../constants/constants.dart';
import '../../models/chat_models/chat_all_participants_model.dart';

class AllParticipantsUser extends StatefulWidget {
  const AllParticipantsUser({Key? key}) : super(key: key);

  @override
  State<AllParticipantsUser> createState() => _AllParticipantsUserState();
}

class _AllParticipantsUserState extends State<AllParticipantsUser> {
  TextEditingController searchController = TextEditingController();
  late Stream<List<ChatParticipantsModel>> _stream;
  late ValueNotifier<String> searchProvider;

  @override
  void initState() {
    super.initState();
    searchProvider = ValueNotifier<String>('');
    searchController.addListener(() {
      searchProvider.value = searchController.text;
    });
    _stream = ChatDBServices.fetchIndividualChatUsers(isConnected: false);
  }

  @override
  Widget build(BuildContext context) {
   
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        Future.delayed(Duration.zero, () {
          if (mounted) {
            Navigator.of(context)
                .pushReplacementNamed(AppRoutes.chatMainScreen);
          }
        });
      },
      child: Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
            ),
            onPressed: () {
              Future.delayed(Duration.zero, () {
                if (mounted) {
                  Navigator.of(context)
                      .pushReplacementNamed(AppRoutes.chatMainScreen);
                }
              });
            },
          ),
          title: const Text(
            "All Users",
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView(
            children: [
              TextFieldWidget(
                controller: searchController,
                hintText: 'Search',
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
              ValueListenableBuilder<String>(
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
                                child: Text('No users found'),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: filteredUsers.length,
                                itemBuilder: (context, index) {
                                  ChatParticipantsModel participants =
                                      filteredUsers[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: InkWell(
                                      onTap: () {
                                        log('....................  user list .................');
                                        Navigator.pushReplacementNamed(context,
                                            AppRoutes.individualMessagesScreen,
                                            arguments: participants);
                                      },
                                      child: ParticipantUserTile(
                                        actionTitle: 'Messages',
                                        imagePath: participants.imageURL!,
                                        titleText: participants.name!,
                                      ),
                                    ),
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
            ],
          ),
        ),
      ),
    );
  }
}
