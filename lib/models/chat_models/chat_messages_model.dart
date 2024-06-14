import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessagesModel {
  String? userIDSender;
  String? senderName;
  String? senderImageURL;
  String? id;
  String? userIDReceiver;
  String? message;
  Timestamp? time;
  String? type;
  String? fileURL;

  ChatMessagesModel({
    this.userIDSender,
    this.senderImageURL,
    this.senderName,
    this.userIDReceiver,
    this.message,
    this.time,
    this.type,
    this.id,
    this.fileURL,
  });

  Map<String, dynamic> toIndividualMessagesMap() {
    return {
      'user_id_sender': userIDSender,
      'user_id_receiver': userIDReceiver,
      'message': message,
      'time': FieldValue.serverTimestamp(),
      'type': type,
      'file_url': fileURL,
    };
  }

  Map<String, dynamic> toGroupMessagesMap() {
    return {
      'user_id_sender': userIDSender,
      'message': message,
      'time': FieldValue.serverTimestamp(),
      'type': type,
      'file_url': fileURL,
    };
  }

  factory ChatMessagesModel.fromIndividualMessagesMap(
    String id,
    Map<String, dynamic> map,
  ) {
    return ChatMessagesModel(
      id: id,
      userIDSender: map['user_id_sender'] ?? '',
      userIDReceiver: map['user_id_receiver'] ?? '',
      message: map['message'] ?? '',
      time: map['time'],
      type: map['type'] ?? '',
      fileURL: map['file_url'] ?? '',
    );
  }

  factory ChatMessagesModel.fromGroupMessagesMap(
      {required String id,
      required Map<String, dynamic> messageData,
      Map<String, dynamic>? userProfileData}) {
    if(userProfileData == null) {
      return ChatMessagesModel(
        id: id,
        // senderName: userProfileData['name'] ?? '',
        // senderImageURL: userProfileData['photo_url'] ?? '',
        userIDSender: messageData['user_id_sender'] ?? '',
        message: messageData['message'] ?? '',
        time: messageData['time'],
        type: messageData['type'] ?? '',
        fileURL: messageData['file_url'] ?? '',
      );
    }else{
      return ChatMessagesModel(
        id: id,
        senderName: userProfileData['name'] ?? '',
        senderImageURL: userProfileData['photo_url'] ?? '',
        userIDSender: messageData['user_id_sender'] ?? '',
        message: messageData['message'] ?? '',
        time: messageData['time'],
        type: messageData['type'] ?? '',
        fileURL: messageData['file_url'] ?? '',
      );
    }
  }
}
