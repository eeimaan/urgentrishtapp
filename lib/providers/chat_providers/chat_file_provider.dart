import 'package:flutter/material.dart';

class ChatFileProvider extends ChangeNotifier {
  String _filePath = '';
  String _fileURL = '';
  String _fileType = '';
  int _fileUploadingProgress = 0;

  get getFilePath => _filePath;

  get getFileURL => _fileURL;

  get getFileType => _fileType;

  get getFileUploadingProgress => _fileUploadingProgress;

  set setFilePath(String path) {
    _filePath = path;
    notifyListeners();
  }

  set setFileType(String type) {
    _fileType = type;
    notifyListeners();
  }

  set setFileURL(String url) {
    _fileURL = url;
    notifyListeners();
  }

  set setUploadingProgress(int progress) {
    _fileUploadingProgress = progress;
    notifyListeners();
  }

  void clear() {
    _fileType = '';
    _filePath = '';
    _fileURL = '';
    _fileUploadingProgress = 0;
    notifyListeners();
  }
}
