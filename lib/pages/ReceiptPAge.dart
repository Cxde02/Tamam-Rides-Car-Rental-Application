// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../data/car.dart';
import '../data/car2.dart';
import 'books.dart';

class ReceiptScreen extends StatelessWidget {
  final Car car;
  final Car2 car2;
  final Book book;
  String subscriptionType;
  int totalAmount;

  ReceiptScreen(
      {super.key,
      required this.car,
      required this.car2,
      required this.book,
      required this.subscriptionType,
      required this.totalAmount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Receipt'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Car:' + car.name),
            Text('Subscription Type: $subscriptionType'),
            Text('Total Amount: $totalAmount'),
            // You can display more details here if needed
          ],
        ),
      ),
    );
  }
}
