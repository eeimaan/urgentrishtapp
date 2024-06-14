import 'package:flutter/material.dart';

class PasswordIconToggleProvider extends ChangeNotifier {
  bool _isVisible = false;

  bool get isVisible => _isVisible;

  void toggleVisibility() {
    _isVisible = !_isVisible;
    notifyListeners();
  }
   bool _isNewVisible = false;

  bool get isNewVisible => _isNewVisible;

  void toggleNewVisibility() {
    _isNewVisible = !_isNewVisible;
    notifyListeners();
  }
}
