import 'package:flutter/material.dart';

class BookmarkModel extends ChangeNotifier {
  bool isBookmarked = false;

  void toggleBookmark() {
    isBookmarked = !isBookmarked;
    notifyListeners();
  }
}
