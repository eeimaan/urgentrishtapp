import 'package:flutter/foundation.dart';

class SearchProvider extends ChangeNotifier {
  String _searchText = '';

  String get searchText => _searchText;

  set searchText(String value) {
    _searchText = value;
    notifyListeners();
  }

  void resetSearch() {
    _searchText = '';

    notifyListeners();
  }
}
