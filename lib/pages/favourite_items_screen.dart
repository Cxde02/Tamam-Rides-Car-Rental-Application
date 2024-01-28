import 'package:flutter/material.dart';
import 'package:homescreen/pages/FavouritesPage.dart';

class FavoriteItemsScreen extends StatelessWidget {
  final List<Item> favoriteItems;

  const FavoriteItemsScreen({required this.favoriteItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Items'),
      ),
      body: ListView.builder(
        itemCount: favoriteItems.length,
        itemBuilder: (context, index) {
          final item = favoriteItems[index];
          return ListTile(
            title: Text(item.name),
            leading: Icon(
              Icons.favorite,
              color: Colors.green,
            ),
          );
        },
      ),
    );
  }
}
