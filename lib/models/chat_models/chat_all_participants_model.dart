import 'chat_messages_model.dart';

class ChatParticipantsModel {
  String? name;
  String? imageURL;
  String? userUID;
  ChatMessagesModel? chatMsg;

  ChatParticipantsModel({this.name, this.imageURL, this.userUID, this.chatMsg});

  factory ChatParticipantsModel.fromMapAllParticipants(
      {required Map<String, dynamic> data, required String userUID}) {
    return ChatParticipantsModel(
        name: data['name'] ?? '',
        imageURL: data['image_url'] ?? '',
        userUID: userUID);
  }

  factory ChatParticipantsModel.fromMapConnectedParticipants(
      {required Map<String, dynamic> data,
      required String userUID,
      required ChatMessagesModel chatMsg}) {
    return ChatParticipantsModel(
        name: data['name'] ?? '',
        chatMsg: chatMsg,
        imageURL: data['image_url'] ?? '',
        userUID: userUID);
  }
}
