import 'package:flutter/material.dart';
import '../../models/chat_models/chat_all_participants_model.dart';


class AddParticipantsProvider extends ChangeNotifier {
  final List<ChatParticipantsModel> _addParticipants = [];

  get getAddedParticipants => _addParticipants;

  set setParticipants(ChatParticipantsModel chatParticipantsModel) {
    _addParticipants.add(chatParticipantsModel);
    notifyListeners();
  }

  set removeParticipants(ChatParticipantsModel chatParticipantsModel) {
    _addParticipants.remove(chatParticipantsModel);
    notifyListeners();
  }

  void clear() {
    _addParticipants.clear();
    notifyListeners();
  }
}
