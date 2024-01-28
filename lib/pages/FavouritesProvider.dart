import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/car.dart';

class FavoritesProvider extends ChangeNotifier {
  List<Car> _favorites = [];
  late SharedPreferences _prefs;

  List<Car> get favorites => _favorites;

  bool isBookmarked(Car itemId) {
    return _favorites.contains(itemId);
  }

  final List<Car> _favoriteCars = [];

  bool isCarFavorite(Car carId) {
    return _favoriteCars.contains(carId);
  }

  FavoritesProvider() {
    initializePrefs();
    retrieveBookmarkedState();
  }

  Future<void> initializePrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> retrieveBookmarkedState() async {
    final List<String> bookmarkedIds =
        _prefs.getStringList('bookmarkedIds') ?? [];

    // Retrieve the bookmarked items using the ids
    _favorites =
        _favorites.where((car) => bookmarkedIds.contains(car.cc)).toList();

    notifyListeners();
  }

  void saveBookmarkedState() {
    final bookmarkedIds = favorites.map((item) => item.cc).toList();
    _prefs.setStringList('bookmarkedIds', bookmarkedIds);
  }

  void addToFavorites(Car car) {
    if (!_favorites.any((c) => c.cc == car.cc)) {
      _favorites.add(car);
      notifyListeners();
    }
  }

  void removeFromFavorites(Car car) {
    _favorites.remove(car);
    notifyListeners();
  }

  bool isItemBookmarked(Car car) {
    return favorites.contains(car);
  }
}
