import 'package:flutter/material.dart';

import '../data/car.dart';

class CarDetailsPage extends StatelessWidget {
  final Car car;

  CarDetailsPage({required this.car});

  Widget build(BuildContext context) {
    // Implement your CarDetailsPage UI here, using the 'car' object to display the car details.
    return Scaffold(
      appBar: AppBar(title: Text(car.name)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Car Name: ${car.name}'),
            // Display other car details as desired
          ],
        ),
      ),
    );
  }
}
