import 'package:flutter/material.dart';

class SearchHistoryProvider extends ChangeNotifier {
  List<String> searchHistory = [];

  void addToSearchHistory(String query) {
    if (!searchHistory.contains(query)) {
      searchHistory.add(query);
      notifyListeners();
    }
  }

  void clearSearchHistory() {
    searchHistory.clear();
    notifyListeners();
  }
}
