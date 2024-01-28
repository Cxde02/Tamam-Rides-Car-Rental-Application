import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier {
  int currentIndex = 0;

  void navigateToPage(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
