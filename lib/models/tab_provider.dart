import 'package:flutter/material.dart';

class TabProvider extends ChangeNotifier {
  int selectedIndex = 0;

  void goToTab(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
