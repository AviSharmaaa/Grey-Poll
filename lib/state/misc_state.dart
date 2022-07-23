import 'package:flutter/cupertino.dart';

class MiscState extends ChangeNotifier {
  int _currentIndex = 0;

  int get getCurrentIndex => _currentIndex;

  set setCurrentIndex(value) {
    _currentIndex = value;
    notifyListeners();
  }
}
