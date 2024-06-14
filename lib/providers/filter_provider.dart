import 'package:flutter/material.dart';

class FilterProvider extends ChangeNotifier {
  String? gender;
  String? age;
  String? sect;
  String? cast;
  String? qualification;
  String? city;

  void setGender(String? value) {
    gender = value;
    notifyListeners();
  }

  void setAge(String? value) {
    age = value;
    notifyListeners();
  }

  void setSect(String? value) {
    sect = value;
    notifyListeners();
  }

  void setCast(String? value) {
    cast = value;
    notifyListeners();
  }

  void setQualification(String? value) {
    qualification = value;
    notifyListeners();
  }

  void setCity(String? value) {
    city = value;
    notifyListeners();
  }

  void resetFilters() {
    gender = null;
    age = null;
    cast = null;
    sect = null;
    city = null;
    qualification = null;
    notifyListeners();
  }
}
