import 'package:flutter/cupertino.dart';

class ProviderHomePage extends ChangeNotifier {
  String filterName = "Active";
  bool isLoading = false;

  void updateHomeFilter(String filterName) {
    this.filterName = filterName;
    notifyListeners();
  }

  void updateLoading(bool loading) {
    isLoading = loading;
    notifyListeners();
  }
}
