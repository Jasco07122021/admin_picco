import 'package:admin_picco/pages/homes_page/homes_page.dart';
import 'package:admin_picco/pages/setting/setting_page.dart';
import 'package:admin_picco/pages/user_page/user_page.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

class MainController extends ChangeNotifier {
  int indexPage = 0;



  List<Widget> pages = const [
    UserPage(),
    HomesPage(),
    SettingPage(),
  ];

  void changePage(int index) {
    indexPage = index;
    notifyListeners();
  }
}
