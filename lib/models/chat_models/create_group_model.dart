import 'package:urgentrishtapp/models/chat_models/chat_messages_model.dart';


class CreateGroupModel {
  String? groupName = '';
  String? time = '';
  String? groupID = '';
  List<dynamic>? groupParticipants = [];
  ChatMessagesModel? chatMsg;

  CreateGroupModel(
      {this.groupName,
      this.time,
      this.groupParticipants,
      this.groupID,
      this.chatMsg});

  Map<String, dynamic> toMap() {
    return {
      'group_name': groupName,
      'time': time,
      'group_participants': groupParticipants,
    };
  }

  factory CreateGroupModel.fromMapwithMsg({
    required Map<String, dynamic> data,
    required String groupID,
    required ChatMessagesModel chatMessagesModel,
  }) {
    return CreateGroupModel(
        chatMsg: chatMessagesModel,
        groupID: groupID,
        groupName: data['group_name'] ?? '',
        time: data['time'] ?? '',
        groupParticipants: data['group_participants'] ?? []);
  }

  factory CreateGroupModel.fromMapWithOutMsg({
    required Map<String, dynamic> data,
    required String groupID,
  }) {
    return CreateGroupModel(
        groupID: groupID,
        groupName: data['group_name'] ?? '',
        time: data['time'] ?? '',
        groupParticipants: data['group_participants'] ?? []);
  }
}
