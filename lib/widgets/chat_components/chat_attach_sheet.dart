import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urgentrishtapp/constants/constants.dart';
import 'package:urgentrishtapp/db_service/auth.dart';
import 'package:urgentrishtapp/db_service/chat_db_services.dart';
import '../../models/chat_models/chat_all_participants_model.dart';
import '../../models/chat_models/chat_messages_model.dart';
import '../../providers/chat_providers/chat_file_provider.dart';
import '../../utils/utils.dart';

class ChatAttachSheet extends StatelessWidget {
  final ChatParticipantsModel? userdata;

  const ChatAttachSheet({
    super.key,
    this.userdata,
  });

  @override
  Widget build(BuildContext context) {
    var chatFileProvider =
        Provider.of<ChatFileProvider>(context, listen: false);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: const Icon(
            Icons.camera,
            color: ColorConstants.orange,
          ),
          title: const Text('Take a Picture'),
          onTap: () {
            AppImagePicker.getImageFromCamera().then((filePath) {
              if (filePath == null) return;
              chatFileProvider.setFilePath = filePath;
              chatFileProvider.setFileType = 'image';
              ChatDBServices.uploadChatFile(
                      file: filePath, chatFileProvider: chatFileProvider)
                  .then((imageURL) {
                if (imageURL == '') return;
                ChatMessagesModel dataMsg = ChatMessagesModel(
                    type: chatFileProvider.getFileType,
                    fileURL: imageURL,
                    userIDSender: DbAuthService.getCurrentUser!.uid,
                    userIDReceiver: '${userdata?.userUID}');
                chatFileProvider.setFilePath = '';

                ChatDBServices.sendIndividualMessages(message: dataMsg);
              });
            });
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.image,
            color: ColorConstants.orange,
          ),
          title: const Text('Pick an Image'),
          onTap: () {
            AppImagePicker.getImageFromGallery().then((filePath) {
              if (filePath == null) return;
              chatFileProvider.setFilePath = filePath;
              chatFileProvider.setFileType = 'image';
              ChatDBServices.uploadChatFile(
                      file: filePath, chatFileProvider: chatFileProvider)
                  .then((imageURL) {
                if (imageURL == '') return;
                ChatMessagesModel dataMsg = ChatMessagesModel(
                    type: chatFileProvider.getFileType,
                    fileURL: imageURL,
                    userIDSender: DbAuthService.getCurrentUser!.uid,
                    userIDReceiver: '${userdata?.userUID}');
                chatFileProvider.setFilePath = '';

                ChatDBServices.sendIndividualMessages(message: dataMsg);
              });
            });
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
