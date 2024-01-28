import 'package:flutter/material.dart';
import 'favourite_items_screen.dart';

void main() {
  runApp(FavoriteApp());
}

class FavoriteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Favorite App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FavoriteScreen(),
    );
  }
}

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen>
    with AutomaticKeepAliveClientMixin {
  List<Item> items = [
    Item(id: '1', name: 'Item 1'),
    Item(id: '2', name: 'Item 2'),
    Item(id: '3', name: 'Item 3'),
    Item(id: '4', name: 'Item 4'),
  ];
  List<Item> favoriteItems = [];

  void removeItem(Item item) {
    setState(() {
      items.remove(item);
      if (item.isFavorite) {
        favoriteItems.remove(item);
      }
    });
  }

  void toggleFavoriteStatus(Item item) {
    setState(() {
      item.isFavorite = !item.isFavorite;
      if (item.isFavorite) {
        favoriteItems.add(item);
      } else {
        favoriteItems.remove(item);
      }
    });
  }

  void navigateToFavorites() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FavoriteItemsScreen(favoriteItems: favoriteItems),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite App'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: navigateToFavorites,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return ListTile(
            title: Text(item.name),
            leading: IconButton(
              icon: Icon(
                item.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: item.isFavorite ? Colors.purple : null,
              ),
              onPressed: () {
                toggleFavoriteStatus(item);
              },
            ),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class Item {
  final String id;
  final String name;
  bool isFavorite;

  Item({required this.id, required this.name, this.isFavorite = false});
}
