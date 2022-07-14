import 'package:flutter/material.dart';

class UserController extends ChangeNotifier {
  int selectTitleHouse = 0;

  void updateTitleHouseIndex(int index) {
    selectTitleHouse = index;
    notifyListeners();
  }
}
