import 'package:flutter/material.dart';

class MaritalStatusProvider extends ChangeNotifier {
  late TextEditingController controller = TextEditingController();


  void initController(TextEditingController controller) {
    this.controller = controller;
  }

  void updateMaritalStatus(String newStatus) {
    controller.text = newStatus;
    notifyListeners();
  }
}

