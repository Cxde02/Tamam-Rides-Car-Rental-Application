import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homescreen/pages/DETAILFAVSC.dart';
import 'package:provider/provider.dart';

import 'FavouritesProvider.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final favorites = favoritesProvider.favorites;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 50, left: 20),
                  child: Container(
                    height: size.width * 0.1,
                    width: size.width * 0.1,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          offset: Offset(2, 2),
                          blurRadius: 2,
                        ),
                      ],
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Icon(CupertinoIcons.back),
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(top: 60),
                child: Text(
                  'Favourites',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                      letterSpacing: 1.5),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final car = favorites[index];

                return ListTile(
                  leading: Image.asset(car.imageUrl),
                  title: Text(
                    car.name,
                    style: TextStyle(fontFamily: 'Montserrat'),
                  ),
                  subtitle: Text(
                    car.model,
                    style: TextStyle(fontFamily: 'Barlow'),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_circle),
                    color: Colors.red,
                    onPressed: () {
                      // Call the removeFavorite function to remove the car from favorites
                      favoritesProvider.removeFromFavorites(car);

                      // You might also want to show a snackbar or provide feedback
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: Duration(seconds: 1),
                          content: Text(
                            '${car.name + ' ' + car.model} removed from favourites.',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Barlow',
                                letterSpacing: 0.5),
                          ),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Theme.of(context)
                              .bottomNavigationBarTheme
                              .backgroundColor!
                              .withOpacity(0.7),
                        ),
                      );
                    },
                  ),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailFavSc(
                          name: car.name,
                          model: car.model,
                          brand: car.brand,
                          imageUrl: car.imageUrl,
                          imageUrl1: car.imageUrl1,
                          imageUrl2: car.imageUrl2,
                          description: car.description,
                          speed: car.speed,
                          seats: car.seats,
                          engine: car.engine,
                          price: car.price,
                          priceW: car.priceW,
                          priceM: car.priceM,
                          trans: car.trans,
                          fuel: car.fuel,
                          cc: car.cc,
                          color1: car.color1,
                          color2: car.color2,
                          color3: car.color3,
                          location: car.location,
                          stars: car.stars,
                          cars: [],
                          color: '',
                          date: '',
                          mileage: '',
                          coord1: car.coord1,
                          coord2: car.coord2,
                          chooseC1: car.chooseC1,
                          chooseC2: car.chooseC2,
                          chooseC3: car.chooseC3),
                    ),
                  ),
                  // ... Display other details of the car
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
