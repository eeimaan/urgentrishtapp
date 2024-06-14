import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:provider/provider.dart';
import 'package:urgentrishtapp/constants/constants.dart';
import 'package:urgentrishtapp/db_service/auth.dart';
import 'package:urgentrishtapp/db_service/chat_db_services.dart';
import 'package:urgentrishtapp/providers/chat_providers/chat_file_provider.dart';
import 'package:urgentrishtapp/utils/app_utils.dart';
import 'package:urgentrishtapp/widgets/chat_components/chat_attach_sheet.dart';
import 'package:urgentrishtapp/widgets/chat_components/chat_messages_tile.dart';
import 'package:urgentrishtapp/widgets/custom_diaplay_image.dart';
import 'package:urgentrishtapp/widgets/textfield_widget.dart';
import '../../models/chat_models/chat_all_participants_model.dart';
import '../../models/chat_models/chat_messages_model.dart';

class IndividualMessagesScreen extends StatefulWidget {
  final ChatParticipantsModel userdata;

  const IndividualMessagesScreen({super.key, required this.userdata});

  @override
  State<IndividualMessagesScreen> createState() =>
      _IndividualMessagesScreenState();
}

class _IndividualMessagesScreenState extends State<IndividualMessagesScreen> {
  TextEditingController msgController = TextEditingController();
  late Stream<List<ChatMessagesModel>> _msgStream;
  bool isUserConnected = false;
  late ChatFileProvider chatFileProvider;
  ValueNotifier<bool> selectedMessageNotifier = ValueNotifier(false);
  List<ChatMessagesModel> selectedMessages = [];

  @override
  void initState() {
    super.initState();
    log('............... ${widget.userdata.name}.............');
    _msgStream = ChatDBServices.getIndividualMessages(
        userIDReceiver: widget.userdata.userUID!);
    chatFileProvider = Provider.of<ChatFileProvider>(context, listen: false);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      chatFileProvider.clear();
    });
  }

  @override
  void dispose() {
    msgController.dispose();
    super.dispose();
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
          titleSpacing: 6,
          leading: GestureDetector(
            onTap: () {
              Future.delayed(Duration.zero, () {
                if (mounted) {
                  Navigator.of(context)
                      .pushReplacementNamed(AppRoutes.chatMainScreen);
                }
              });
            },
            child: const Icon(
              Icons.arrow_back,
            ),
          ),
          title: Row(
            children: [
              Row(
                children: [
                  CustomDisplayImage(imageUrl: '${widget.userdata.imageURL}'),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.userdata.name}',
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
          actions: [
            ValueListenableBuilder<bool>(
              valueListenable: selectedMessageNotifier,
              builder: (context, value, child) {
                return value
                    ? IconButton(
                        onPressed: () {
                          for (var msg in selectedMessages) {
                            ChatDBServices.deleteIndividualMessages(
                                messageId: msg.id!,
                                userIDReceiver: msg.userIDReceiver!,
                                messageType: msg.type!,
                                fileUrl: msg.fileURL);
                          }
                          selectedMessages.clear();
                          selectedMessageNotifier.value = false;
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: ColorConstants.red,
                        ),
                      )
                    : const SizedBox();
              },
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: StreamBuilder(
                stream: _msgStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    isUserConnected = snapshot.data!.isNotEmpty;
                    return GroupedListView<ChatMessagesModel, dynamic>(
                      reverse: true,
                      order: GroupedListOrder.DESC,
                      elements: snapshot.data!,
                      groupBy: (msg) {
                        String date =
                            convertDateTimeToMMMMDY(timestamp: msg.time);
                        return date;
                      },
                      groupSeparatorBuilder: (groupValue) {
                        return Center(
                          child: Text(
                            groupValue,
                          ),
                        );
                      },
                      itemBuilder: (context, msg) => Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 10,
                        ),
                        child: GestureDetector(
                          onLongPress: () {
                            setState(() {
                              if (selectedMessages.contains(msg)) {
                                selectedMessages.remove(msg);
                              } else {
                                selectedMessages.add(msg);
                              }
                              selectedMessageNotifier.value =
                                  selectedMessages.isNotEmpty;
                            });
                          },
                          child: ValueListenableBuilder<bool>(
                            valueListenable: selectedMessageNotifier,
                            builder: (context, value, child) {
                              return Container(
                                width: 350,
                                decoration: ShapeDecoration(
                                  color: selectedMessages.contains(msg)
                                      ? Colors.grey
                                      : Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                child: ChatMessageTile(
                                  msg: msg,
                                  alignment: msg.userIDSender ==
                                         DbAuthService.getCurrentUser!.uid
                                      ? Alignment.topRight
                                      : Alignment.topLeft,
                                  containerColor: Colors.grey,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  } else {
                    return const Center(
                         child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            Consumer<ChatFileProvider>(
                builder: (context, chatFileProvider, child) {
              if (chatFileProvider.getFilePath != '') {
                return Padding(
                    padding: const EdgeInsets.only(bottom: 2.0),
                    child: SizedBox(
                      height: 60,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            SizedBox(
                                height: 50,
                                width: 50,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: chatFileProvider.getFileType == 'image'
                                      ? Image.file(
                                          File(chatFileProvider.getFilePath),
                                          fit: BoxFit.cover,
                                        )
                                      : Container(),
                                )),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: SizedBox(
                                width: MediaQuery.sizeOf(context).width * .55,
                                height: 5,
                                child: LinearProgressIndicator(
                                  minHeight: 10,
                                  borderRadius: BorderRadius.circular(12),
                                  value: chatFileProvider
                                          .getFileUploadingProgress /
                                      100,
                                  backgroundColor: Colors.grey.shade600,
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                    Colors.red,
                                  ),
                                ),
                              ),
                            ),
                            const Spacer(),
                            Text(
                                '${chatFileProvider.getFileUploadingProgress}%')
                          ],
                        ),
                      ),
                    ));
              } else {
                return const SizedBox();
              }
            }),
            Container(
              width: double.infinity,
              color: ColorConstants.orange,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: TextFieldWidget(
                          controller: msgController,
                          fillColor: Colors.white,
                          height: 53,
                          prefixIcon: InkWell(
                              onTap: () {
                                if (chatFileProvider.getFilePath == '') {
                                  showModalBottomSheet(
                                    context: context,
                                    backgroundColor: Colors.white,
                                    builder: (BuildContext context) {
                                      return ChatAttachSheet(
                                        userdata: widget.userdata,
                                      );
                                    },
                                  );
                                }
                              },
                              child: const Icon(Icons.attachment)),
                          hintText: 'Type a message',
                          obscureText: false,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: InkWell(
                        onTap: () {
                          if (msgController.text.isNotEmpty) {
                            if (!isUserConnected) {
                              ChatDBServices.addIndividualConnectionHashCode(
                                  userIDReceiver: widget.userdata.userUID!);
                              log('..................... user is connected ..................');
                            }
                            chatFileProvider.setFileType = 'msg';
                            ChatMessagesModel dataMsg = ChatMessagesModel(
                                type: chatFileProvider.getFileType,
                                message: msgController.text,
                                userIDSender: DbAuthService.getCurrentUser!.uid,
                                userIDReceiver: widget.userdata.userUID);

                            ChatDBServices.sendIndividualMessages(
                                message: dataMsg);
                            msgController.clear();
                          }
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: ShapeDecoration(
                            color: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          child: Container(
                              height: double.infinity,
                              decoration: const BoxDecoration(),
                              child: const Icon(
                                Icons.send,
                                color: Colors.white,
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
