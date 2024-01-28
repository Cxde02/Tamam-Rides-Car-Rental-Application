// ignore_for_file: unused_local_variable, unused_field

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homescreen/Components/fadeanimation.dart';
import 'package:homescreen/pages/pickUpLocationAndTime.dart';
import 'package:homescreen/theme/app_colors.dart';
import 'package:shimmer/shimmer.dart';
import 'package:slide_switcher/slide_switcher.dart';

import '../data/car.dart';
import '../data/car2.dart';
import 'books.dart';

class CheckoutScreen extends StatefulWidget {
  final Car car;
  final Car2 car2;
  final Book book;

  final String name;
  final String model;
  final String brand;
  final String imageUrl;
  final String imageUrl1;
  final String imageUrl2;

  final String description;
  final String speed;
  final String seats;
  final String engine;
  final double price;
  final double priceW;
  final double priceM;

  final String trans;
  final String fuel;
  final String cc;
  final String color1;
  final String color2;
  final String color3;
  final String location;
  final String stars;

  final String date;
  final String mileage;
  final String color;

  final double coord1;
  final double coord2;

  final String chooseC1;
  final String chooseC2;
  final String chooseC3;

  CheckoutScreen(
      {Key? key,
      required this.car,
      required this.car2,
      required this.name,
      required this.model,
      required this.brand,
      required this.imageUrl,
      required this.imageUrl1,
      required this.imageUrl2,
      required this.description,
      required this.speed,
      required this.seats,
      required this.engine,
      required this.price,
      required this.priceW,
      required this.priceM,
      required this.trans,
      required this.fuel,
      required this.cc,
      required this.color1,
      required this.color2,
      required this.color3,
      required this.location,
      required this.stars,
      required this.date,
      required this.mileage,
      required this.color,
      required this.coord1,
      required this.coord2,
      required this.chooseC1,
      required this.chooseC2,
      required this.chooseC3,
      required this.book})
      : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _counter = 1;
  String _selectedOption = 'day';
  double _basePrice = 10.0;
  double _totalPrice = 0;

  bool _childSeatSelected = false;

  String _selectedColor = 'color0'; // Default color option

  void _toggleChildSeat(bool value) {
    setState(() {
      _childSeatSelected = value;
      _updatePrice(); // Update the total price based on the child seat selection
    });
  }

  void _selectColor(String color) {
    setState(() {
      _selectedColor = color;
    });
  }

  @override
  void initState() {
    super.initState();
    // Set the initial total price to widget.car2.price when the page is first seen
    _totalPrice = widget.car2.price;
  }

  void _updatePrice() {
    double basePrice = 0.0;

    if (_selectedOption == 'day') {
      basePrice = widget.car2.price;
    } else if (_selectedOption == 'week') {
      basePrice = widget.car2.priceW;
    } else if (_selectedOption == 'month') {
      basePrice = widget.car2.priceM;
    }

    double childSeatCost = _childSeatSelected ? 250.0 : 0.0;

    setState(() {
      _totalPrice = (basePrice * _counter) + childSeatCost;
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      _updatePrice();
    });
  }

  void _decrementCounter() {
    if (_counter > 1) {
      setState(() {
        _counter--;
        _updatePrice();
      });
    }
  }

  void _selectOption(String option) {
    setState(() {
      _selectedOption = option;
      _updatePrice();
    });
  }

  void _proceedToPayment(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentConfirmationScreen(
          totalAmount: _totalPrice,
          selectedOption: _selectedOption,
          counter: _counter,
          car2: widget.car2,
          book: widget.book,
          car: widget.car,
          selectedColor: _selectedColor, // Pass the selected color here
          selectedColorImage: getImagePathForColor(_selectedColor),
          childSeatSelected:
              _childSeatSelected, // Pass the selected color image path
        ),
      ),
    );
  }

  String getImagePathForColor(String color) {
    // Implement a function to map color names to image paths
    // For example:
    if (color == 'color1') {
      return widget.color1;
    } else if (color == 'color2') {
      return widget.color2;
    } else if (color == 'color3') {
      return widget.color3;
    } else if (color == 'colorO') {
      return 'Original Color';
    }
    return ''; // Return a default image path or handle errors
  }

  String _getImagePathForSelectedColor() {
    switch (_selectedColor) {
      case 'color1':
        return widget.chooseC1;
      case 'color2':
        return widget.chooseC2;
      case 'color3':
        return widget.chooseC3;
      default:
        return widget.imageUrl; // Return a default image path or handle errors
    }
  }

  void _showPaymentConfirmation(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => FractionallySizedBox(
        heightFactor:
            0.4, // Adjust this value to control the height of the bottom sheet
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          child: PaymentConfirmationScreen(
            totalAmount: _totalPrice,
            selectedOption: _selectedOption,
            counter: _counter,
            car2: widget.car2,
            book: widget.book,
            car: widget.car,
            selectedColor: _selectedColor, // Pass the selected color here
            selectedColorImage: getImagePathForColor(_selectedColor),
            childSeatSelected:
                _childSeatSelected, // Pass the selected color image path
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      /*appBar: AppBar(
        title: Text('Checkout'),
      ),*/
      body: Stack(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 50, 16, 10),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
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
                    child: Center(child: Icon(CupertinoIcons.back)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 60, 16, 15),
                child: Text(
                  'Checkout',
                  style: TextStyle(fontFamily: 'montserrat', fontSize: 23),
                ),
              ),
            ],
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 80,
                ),
                FadeAnimation(
                  delay: 0.1,
                  child: Container(
                      width: 100,
                      height: 50,
                      child:
                          Image.asset(widget.car2.brand, fit: BoxFit.contain)),
                ),
                FadeAnimation(
                  delay: 0.2,
                  child: AnimatedContainer(
                    curve: Curves.easeOut,
                    duration: Duration(seconds: 2),
                    width: 290,
                    height: 165,
                    child: Image.asset(
                      _getImagePathForSelectedColor(), // Get the selected color image path
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                FadeAnimation(
                  delay: 0.2,
                  child: Text(
                    widget.car.name + ' ' + widget.car2.model,
                    style: TextStyle(
                        fontFamily: 'Barlow',
                        fontSize: 23,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 8),
                FadeAnimation(
                  delay: 0.3,
                  child: Text(
                    'Choose your preferred paint',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 22.5,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                SizedBox(height: 9),
                FadeAnimation(
                  delay: 0.3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => _selectColor('color0'),
                        child: Container(
                          child: Text(
                            'Original Color',
                            style: TextStyle(fontFamily: 'Barlow'),
                            textAlign: TextAlign.center,
                          ),
                          width: 70,
                          height: 40,
                          decoration: BoxDecoration(
                            /*image: DecorationImage(
                              image: AssetImage(widget.color2),
                              fit: BoxFit.cover,
                            ),*/
                            border: _selectedColor == 'color0'
                                ? Border.all(
                                    color: AppColors.cardBgColor, width: 2.5)
                                : Border.all(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    width: 2.5),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 14,
                      ),
                      GestureDetector(
                        onTap: () => _selectColor('color1'),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(widget.color1),
                              fit: BoxFit.cover,
                            ),
                            border: _selectedColor == 'color1'
                                ? Border.all(
                                    color: AppColors.cardBgColor, width: 5)
                                : null,
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      GestureDetector(
                        onTap: () => _selectColor('color2'),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(widget.color2),
                              fit: BoxFit.cover,
                            ),
                            border: _selectedColor == 'color2'
                                ? Border.all(
                                    color: AppColors.cardBgColor, width: 5)
                                : null,
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      GestureDetector(
                        onTap: () => _selectColor('color3'),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(widget.color3),
                              fit: BoxFit.cover,
                            ),
                            border: _selectedColor == 'color3'
                                ? Border.all(
                                    color: AppColors.cardBgColor, width: 5)
                                : null,
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 11),
                FadeAnimation(
                  delay: 0.4,
                  child: Text(
                    'Choose your subscription',
                    style: TextStyle(fontFamily: 'montserrat', fontSize: 23),
                  ),
                ),
                SizedBox(height: 15),
                FadeAnimation(
                  delay: 0.4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OptionContainer(
                        label: 'Day',
                        price: widget.car2.price,
                        isSelected: _selectedOption == 'day',
                        onTap: () => _selectOption('day'),
                      ),
                      SizedBox(width: 16),
                      OptionContainer(
                        label: 'Week',
                        price: widget.car2.priceW,
                        isSelected: _selectedOption == 'week',
                        onTap: () => _selectOption('week'),
                      ),
                      SizedBox(width: 16),
                      OptionContainer(
                        label: 'Month',
                        price: widget.car2.priceM,
                        isSelected: _selectedOption == 'month',
                        onTap: () => _selectOption('month'),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                /*RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Barlow',
                      //color: Colors.black, // Default color for the whole text
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Selected Option: ',
                        style: TextStyle(
                            color: Theme.of(context)
                                .bottomNavigationBarTheme
                                .backgroundColor),
                        // Color for the static part of the text
                      ),
                      TextSpan(
                        text: _selectedOption.toUpperCase(),
                        style: TextStyle(
                            color: Theme.of(context)
                                .bottomNavigationBarTheme
                                .backgroundColor), // Color for the selected option
                      ),
                    ],
                  ),
                ),*/
                SizedBox(
                  height: 5,
                ),
                FadeAnimation(
                  delay: 0.5,
                  child: Text(
                    'Choose your number of $_selectedOption' + 's',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Barlow'),
                  ),
                ),
                SizedBox(height: 17),
                FadeAnimation(
                  delay: 0.5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: _decrementCounter,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context)
                                .bottomNavigationBarTheme
                                .backgroundColor, // Icon background color
                          ),
                          child: Icon(
                            Icons.remove,
                            size: 24,
                            color: Colors.white, // Icon color
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      AnimatedContainer(
                        curve: Curves.easeOut,
                        duration:
                            Duration(milliseconds: 300), // Animation duration
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .primaryColor, // Background color for the counter
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '$_counter',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Barlow'),
                        ),
                      ),
                      SizedBox(width: 16),
                      GestureDetector(
                        onTap: _incrementCounter,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context)
                                .bottomNavigationBarTheme
                                .backgroundColor,
                          ),
                          child: Icon(
                            Icons.add,
                            size: 24,
                            color: Colors.white, // Icon color
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 17),
                FadeAnimation(
                  delay: 0.6,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Add Child Seat (Rs 250)',
                          style: TextStyle(
                              fontSize: 17.5,
                              fontFamily: 'Barlow',
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        width: 10,
                      ),
                      SlideSwitcher(
                        containerColor: Theme.of(context).primaryColor,
                        slidersColors: [
                          Theme.of(context)
                              .bottomNavigationBarTheme
                              .backgroundColor!
                        ],
                        children: [
                          Text('No',
                              style: TextStyle(
                                fontFamily: 'Barlow',
                                color: _childSeatSelected ? null : Colors.white,
                              )),
                          Text(
                            'Yes',
                            style: TextStyle(
                              fontFamily: 'Barlow',
                              color: _childSeatSelected ? Colors.white : null,
                            ),
                          ),
                        ],
                        onSelect: (index) {
                          // Use index to handle selection (0 for 'Yes', 1 for 'No')
                          if (index == 0) {
                            _toggleChildSeat(
                                false); // Call your method to enable child seat
                          } else {
                            _toggleChildSeat(
                                true); // Call your method to disable child seat
                          }
                        },
                        containerHeight: 25,
                        containerWight: 75, // Set initial selected index
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 17),
                FadeAnimation(
                  delay: 0.7,
                  child: Text(
                    'Total Price: Rs ${(_totalPrice).toStringAsFixed(0)}',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        letterSpacing: 0.5,
                        color: Theme.of(context)
                            .bottomNavigationBarTheme
                            .backgroundColor),
                  ),
                ),
                SizedBox(height: 15),
                FadeAnimation(
                  delay: 0.8,
                  child: ElevatedButton(
                    onPressed: () {
                      _showPaymentConfirmation(context);
                    },
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 5, // Add elevation to give a floating effect
                      primary: Theme.of(context)
                          .bottomNavigationBarTheme
                          .backgroundColor, // Background color
                      onPrimary: Theme.of(context).primaryColor, // Text color
                    ),
                    child: Text('Proceed', style: TextStyle(fontSize: 20)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OptionContainer extends StatelessWidget {
  final String label;
  final double price;
  final bool isSelected;
  final VoidCallback onTap;

  OptionContainer({
    required this.label,
    required this.price,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    bool isOptionSelected = true;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).bottomNavigationBarTheme.backgroundColor
              : Colors.grey[200],
          borderRadius: BorderRadius.circular(16),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Theme.of(context)
                        .bottomNavigationBarTheme
                        .backgroundColor!
                        .withOpacity(0.5),
                    blurRadius: 5,
                    spreadRadius: 2,
                  )
                ]
              : null,
        ),
        child: Column(
          children: [
            isSelected
                ? Shimmer.fromColors(
                    baseColor: Colors.white,
                    highlightColor: Colors.grey[400]!,
                    child: Text(
                      label,
                      style: TextStyle(
                        fontSize: 20,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Barlow',
                        color: Colors.white,
                      ),
                    ),
                  )
                : Text(
                    label,
                    style: TextStyle(
                      fontSize: 20,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Barlow',
                      color: Colors.black,
                    ),
                  ),
            SizedBox(height: 8),
            isSelected
                ? Shimmer.fromColors(
                    baseColor: Colors.white,
                    highlightColor: Colors.grey[400]!,
                    child: Text(
                      '\Rs ${price.toStringAsFixed(0)}',
                      style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  )
                : Text(
                    '\Rs ${price.toStringAsFixed(0)}',
                    style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class PaymentConfirmationScreen extends StatelessWidget {
  final Car2 car2;
  final Car car;
  final Book book;
  final double totalAmount;
  final String selectedOption;
  final int counter;
  final String selectedColor;
  final String selectedColorImage;
  final bool childSeatSelected;

  const PaymentConfirmationScreen({
    Key? key,
    required this.car2,
    required this.car,
    required this.book,
    required this.totalAmount,
    required this.selectedOption,
    required this.counter,
    required this.selectedColor,
    required this.selectedColorImage,
    required this.childSeatSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      /*appBar: AppBar(
        title: Text('Payment Confirmation'),
      ),*/
      body: Stack(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 10),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  /*child: Container(
                                    height: size.width * 0.1,
                                    width: size.width * 0.1,
                                    decoration: BoxDecoration(
                                      color: kTextColor.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: Image.asset('assets/images/back-arrow.png'),
                                    ),
                                  ),*/
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
                    child: Center(child: Icon(CupertinoIcons.xmark)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(1, 15, 5, 2),
                child: Text(
                  'Confirmation',
                  style: TextStyle(fontFamily: 'Montserrat', fontSize: 22),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(10), // Adjust padding as needed
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2), // Shadow color
                          spreadRadius: 2, // Spread radius
                          blurRadius: 5, // Blur radius
                          offset: Offset(0, 3), // Offset in (x,y) direction
                        ),
                      ],
                      color: Theme.of(context)
                          .primaryColor, // Set your desired background color
                      borderRadius: BorderRadius.circular(
                          10), // Add border radius for rounded corners
                    ),
                    child: Text(
                      'Total Amount: \Rs ${totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.3,
                        fontFamily: 'Barlow',
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment
                        .center, // Center the elements horizontally
                    children: [
                      Text(
                        'Selected Color: ',
                        style: TextStyle(
                          fontSize: 19,
                          fontFamily: 'Barlow',
                        ),
                      ),
                      if (selectedColorImage.isNotEmpty)
                        Image.asset(
                          selectedColorImage,
                          height: 30,
                          width: 30,
                        )
                      else
                        Text(
                          'Original Color', // Display this text when no image is selected
                          style: TextStyle(
                            fontSize: 17.5,
                            fontFamily: 'Barlow',
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Subscription type: ${selectedOption.toUpperCase()}',
                    style: TextStyle(fontSize: 19, fontFamily: 'Barlow'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Number of ${selectedOption}s: $counter',
                    style: TextStyle(fontSize: 19, fontFamily: 'Barlow'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    childSeatSelected ? 'Child Seat: Yes' : 'Child Seat: No',
                    style: TextStyle(fontSize: 19, fontFamily: 'Barlow'),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(height: 15),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CarRentalApp(
                            book: Book(
                                name: book.name,
                                brand: book.brand,
                                model: book.model,
                                imageUrl: book.imageUrl,
                                imageUrl1: book.imageUrl1,
                                imageUrl2: book.imageUrl2,
                                description: book.description,
                                speed: book.speed,
                                seats: book.seats,
                                engine: book.engine,
                                stars: book.stars,
                                price: book.price,
                                priceW: book.priceW,
                                priceM: book.priceM,
                                date: book.date,
                                mileage: book.mileage,
                                color: book.color,
                                trans: book.trans,
                                fuel: book.fuel,
                                cc: book.cc,
                                color1: book.color1,
                                color2: book.color2,
                                color3: book.color3,
                                location: book.location,
                                coord1: book.coord1,
                                coord2: book.coord2,
                                chooseC1: book.chooseC1,
                                chooseC2: book.chooseC2,
                                chooseC3: book.chooseC3),
                            car: Car(
                                name: car.name,
                                brand: car.brand,
                                model: car.model,
                                imageUrl: car.imageUrl,
                                imageUrl1: car.imageUrl1,
                                imageUrl2: car.imageUrl2,
                                description: car.description,
                                speed: car.speed,
                                seats: car.seats,
                                engine: car.engine,
                                stars: car.stars,
                                price: car.price,
                                priceW: car.priceW,
                                priceM: car.priceM,
                                date: car.date,
                                mileage: car.mileage,
                                color: car.color,
                                trans: car.trans,
                                fuel: car.fuel,
                                cc: car.cc,
                                color1: car.color1,
                                color2: car.color2,
                                color3: car.color3,
                                location: car.location,
                                coord1: car.coord1,
                                coord2: car.coord2,
                                chooseC1: car.chooseC1,
                                chooseC2: car.chooseC2,
                                chooseC3: car.chooseC3),
                            car2: Car2(
                                name: car2.name,
                                brand: car2.brand,
                                model: car2.model,
                                imageUrl: car2.imageUrl,
                                imageUrl1: car2.imageUrl1,
                                imageUrl2: car2.imageUrl2,
                                description: car2.description,
                                speed: car2.speed,
                                seats: car2.seats,
                                engine: car2.engine,
                                stars: car2.stars,
                                price: car2.price,
                                priceW: car2.priceW,
                                priceM: car2.priceM,
                                date: car2.date,
                                mileage: car2.mileage,
                                color: car2.color,
                                trans: car2.trans,
                                fuel: car2.fuel,
                                cc: car2.cc,
                                color1: car2.color1,
                                color2: car2.color2,
                                color3: car2.color3,
                                location: car2.location,
                                coord1: car2.coord1,
                                coord2: car2.coord2,
                                chooseC1: car.chooseC1,
                                chooseC2: car.chooseC2,
                                chooseC3: car.chooseC3),
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 11),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 5, // Add elevation to give a floating effect
                      primary: Theme.of(context)
                          .bottomNavigationBarTheme
                          .backgroundColor, // Background color
                      onPrimary: Theme.of(context).primaryColor, // Text color
                    ),
                    icon: Icon(
                      CupertinoIcons.arrow_right_circle_fill,
                      size: 28,
                    ),
                    label: Text(
                      'Confirm',
                      style: TextStyle(fontSize: 20, fontFamily: 'Barlow'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
