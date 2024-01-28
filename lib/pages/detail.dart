// ignore_for_file: library_private_types_in_public_api, unused_field

import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:homescreen/Components/fadeanimation.dart';
import 'package:homescreen/pages/constant.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/car.dart';
import '../data/car2.dart';
import 'CheckoutScreen.dart';
import 'books.dart';

class DetailScreen extends StatefulWidget {
  final List<Car> cars;
  //final Book book;

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

  const DetailScreen(
      {Key? key,
      required this.cars,
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
      required this.chooseC3
      //required this.book,
      })
      : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  List<Book> books = allBooks;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final userCollection = FirebaseFirestore.instance.collection("Users");
  User? get currentUser => _firebaseAuth.currentUser;

  final Location _locationService = Location();
  GoogleMapController? _mapController;
  LocationData? _currentLocation;

  // Step 2: Create a Set to hold the markers
  Set<Marker> _markers = {};

  Set<Polyline> _polylines = {};

  void _initializeLocationService() async {
    bool serviceEnabled = await _locationService.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _locationService.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    PermissionStatus permissionGranted = await _locationService.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _locationService.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    // Fetch the current location after obtaining permission
    if (permissionGranted == PermissionStatus.granted) {
      _currentLocation = await _locationService.getLocation();
    }
  }

  // Method to draw a line from the target location to my location

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  void initState() {
    super.initState();
    _initializeLocationService();

    // Show InfoWindow for the "currentLocation" marker after a short delay
    /*Timer(const Duration(milliseconds: 1000), () {
      _mapController?.showMarkerInfoWindow(const MarkerId("currentLocation"));
    });*/

    // Initialize and add the marker when the screen loads
    _markers.add(
      Marker(
        markerId: const MarkerId("currentLocation"),
        position: LatLng(widget.coord1, widget.coord2),
        icon: BitmapDescriptor.defaultMarkerWithHue(110),
        infoWindow: InfoWindow(title: widget.location),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final initialCameraPosition = _currentLocation != null
        ? CameraPosition(
            target: LatLng(
              _currentLocation!.latitude ?? 0.0,
              _currentLocation!.longitude ?? 0.0,
            ),
            zoom: 14,
          )
        : CameraPosition(
            target: LatLng(widget.coord1, widget.coord2),
            zoom: 17,
          );

    return Scaffold(
      floatingActionButton: FadeAnimation(
        delay: 1.1,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              elevation: 10,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Stack(
                      children: [
                        BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: Container(
                            color: Colors.transparent,
                          ),
                        ),
                        AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 20,
                          icon: Icon(
                            Icons.perm_contact_cal,
                            color: Theme.of(context)
                                .bottomNavigationBarTheme
                                .backgroundColor,
                            size: 30,
                          ),
                          shadowColor: Theme.of(context)
                              .bottomNavigationBarTheme
                              .backgroundColor,
                          backgroundColor: Theme.of(context)
                              .scaffoldBackgroundColor
                              .withOpacity(0.7),
                          title: const Text(
                            'Please select a Phone Number',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 18.2,
                                fontWeight: FontWeight.bold),
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              InkWell(
                                radius: null,
                                borderRadius: BorderRadius.circular(5),
                                splashColor: Colors.greenAccent.shade400,
                                onTap: () async {
                                  Uri phoneno = Uri.parse('tel:59220603');
                                  if (await launchUrl(phoneno)) {
                                    //dialer opened
                                  } else {
                                    //dailer is not opened
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .bottomNavigationBarTheme
                                        .backgroundColor,
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        spreadRadius: 2,
                                        blurRadius: 15,
                                        offset: Offset(0, 15),
                                      ),
                                    ],
                                  ),
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  padding: EdgeInsets.all(15),
                                  //color: Colors.blue,
                                  child: Center(
                                    child: Text(
                                      '+230 59220603 - Ruhomaun Ahmad',
                                      style: TextStyle(
                                          fontFamily: 'Barlow',
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                radius: null,
                                borderRadius: BorderRadius.circular(5),
                                splashColor: Colors.greenAccent.shade400,
                                onTap: () async {
                                  Uri phoneno = Uri.parse('tel:58185377');
                                  if (await launchUrl(phoneno)) {
                                    //dialer opened
                                  } else {
                                    //dailer is not opened
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .bottomNavigationBarTheme
                                        .backgroundColor,
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        spreadRadius: 2,
                                        blurRadius: 15,
                                        offset: Offset(0, 15),
                                      ),
                                    ],
                                  ),
                                  margin: EdgeInsets.symmetric(vertical: 8),
                                  padding: EdgeInsets.all(15),
                                  //color: Colors.blue,
                                  child: Center(
                                    child: Text(
                                      '+230 58185377 - Kissoon Divesh',
                                      style: TextStyle(
                                          fontFamily: 'Barlow',
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                radius: null,
                                borderRadius: BorderRadius.circular(5),
                                splashColor: Colors.greenAccent.shade400,
                                onTap: () async {
                                  Uri phoneno = Uri.parse('tel:54841871');
                                  if (await launchUrl(phoneno)) {
                                    //dialer opened
                                  } else {
                                    //dailer is not opened
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .bottomNavigationBarTheme
                                        .backgroundColor,
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        spreadRadius: 2,
                                        blurRadius: 15,
                                        offset: Offset(0, 15),
                                      ),
                                    ],
                                  ),
                                  margin: EdgeInsets.only(top: 8),
                                  padding: EdgeInsets.all(15),
                                  //color: Colors.blue,
                                  child: Center(
                                    child: Text(
                                      '+230 54841871 - Unmole Peshal',
                                      style: TextStyle(
                                          fontFamily: 'Barlow',
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          actions: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: ElevatedButton.icon(
                                icon: Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  size: 15,
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                ),
                                label: Text(
                                  'Back',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                );
              },
              child: Icon(CupertinoIcons.phone),
              backgroundColor: Theme.of(context)
                  .bottomNavigationBarTheme
                  .backgroundColor, // Set your desired FAB background color
            ),
          ),
        ),
      ),
      //backgroundColor: Color(0xFF003265),
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection("Users")
              .doc(currentUser?.email)
              .snapshots(),
          builder: (context, snapshot) {
            return SafeArea(
              child: Stack(
                children: [
                  ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 20, 16, 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
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
                                      color: Colors.transparent,
                                      offset: Offset(2, 2),
                                      blurRadius: 2,
                                    ),
                                  ],
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                    child: Icon(
                                  CupertinoIcons.back,
                                  color: Colors.transparent,
                                )),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                  height: size.width * 0.1,
                                  width: size.width * 0.15,
                                  decoration: BoxDecoration(
                                    /* boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black.withOpacity(
                                                      0.5), // Shadow color
                                                  spreadRadius: 1, // Spread radius
                                                  blurRadius: 5, // Blur radius
                                                  offset: Offset(0,
                                                      4), // Offset in x and y direction
                                                ),
                                              ],*/
                                    color: Colors.grey.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      children: [
                                        Image.asset('assets/images/star2.png'),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          widget.stars,
                                          style:
                                              TextStyle(fontFamily: 'Barlow'),
                                        ),
                                      ],
                                    ),
                                  ) /*Image.asset(
                                              'assets/images/active-saved.png'),*/
                                  ),
                            ),
                          ],
                        ),
                      ),
                      FadeAnimation(
                        delay: 0.2,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                  child: Image.asset(
                                    widget.brand,
                                    scale: 5,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(widget.name + " " + widget.model,
                                  style: kCarTitle),
                              Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 0)),
                              Shimmer.fromColors(
                                period: const Duration(milliseconds: 3000),

                                //period: Duration(milliseconds: 2000),
                                baseColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                highlightColor: Theme.of(context)
                                    .bottomNavigationBarTheme
                                    .backgroundColor!,
                                child: Text(
                                  'Swipe for more >>',
                                  style: kBrand.copyWith(fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(padding: const EdgeInsets.fromLTRB(0, 0, 0, 7)),
                      FadeAnimation(
                        delay: 0.5,
                        child: Center(
                            child: Stack(
                          children: [
                            CarouselSlider(
                              items: [
                                Container(
                                  margin: EdgeInsets.all(2.0),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(widget.imageUrl),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(2.0),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(widget.imageUrl1),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(2.0),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(widget.imageUrl2),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ],
                              options: CarouselOptions(
                                height: 300.0,
                                enlargeCenterPage: true,
                                autoPlay: true,
                                aspectRatio: 16 / 9,
                                autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                                enableInfiniteScroll: true,
                                autoPlayAnimationDuration: Duration(seconds: 5),
                                autoPlayInterval: Duration(seconds: 3),
                                viewportFraction: 0.9,
                              ),
                            ),
                          ],
                        )
                            /*child: Hero(
                        tag: widget.imageUrl,
                        child: Image.asset(widget.imageUrl),
                      ),*/
                            ),
                      ),
                      FadeAnimation(
                        delay: 0.8,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 49, 16, 32),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Description', style: kSectionTitle),
                              const SizedBox(height: 10),
                              Text(
                                widget.description,
                                textAlign: TextAlign.justify,
                                style: kBrand.copyWith(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      FadeAnimation(
                        delay: 1.1,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Specs', style: kSectionTitle),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset('assets/images/speed.png'),
                                      const SizedBox(height: 3),
                                      /*Text(
                                    'Top Speed',
                                    style: kBrand.copyWith(
                                        fontSize: 12, fontWeight: FontWeight.w300),
                                  ),*/
                                      Text(widget.speed, style: kBrand),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Max. Speed',
                                        style: kBrand.copyWith(
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset('assets/images/seat.png'),
                                      const SizedBox(height: 3),
                                      Text(widget.seats, style: kBrand),
                                      const SizedBox(height: 3),
                                      Text(
                                        'Seats',
                                        style: kBrand.copyWith(
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset('assets/images/engine.png'),
                                      const SizedBox(height: 3),
                                      Text(
                                        widget.engine,
                                        style: kBrand.copyWith(),
                                      ),
                                      const SizedBox(height: 3),
                                      Text(
                                        'Engine',
                                        style: kBrand.copyWith(
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                          'assets/images/transmission.png'),
                                      const SizedBox(height: 3),
                                      Text(widget.trans, style: kBrand),
                                      const SizedBox(height: 3),
                                      Text(
                                        'Gearbox',
                                        style: kBrand.copyWith(
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset('assets/images/fuel.png'),
                                      const SizedBox(height: 3),
                                      Text(widget.fuel, style: kBrand),
                                      const SizedBox(height: 3),
                                      Text(
                                        'Fuel',
                                        style: kBrand.copyWith(
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset('assets/images/cc.png'),
                                      const SizedBox(height: 3),
                                      Text(widget.cc, style: kBrand),
                                      const SizedBox(height: 3),
                                      Center(
                                        child: Text(
                                          'C.C',
                                          style: kBrand.copyWith(
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      FadeAnimation(
                        delay: 0.2,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 5, 16, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Colors available',
                                  style: kSectionTitle),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      widget.color1,
                                      scale: 13,
                                    ),
                                    const SizedBox(width: 30),
                                    Image.asset(
                                      widget.color2,
                                      scale: 13,
                                    ),
                                    const SizedBox(width: 30),
                                    Image.asset(
                                      widget.color3,
                                      scale: 13,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      FadeAnimation(
                        delay: 0.5,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                            15,
                            0,
                            0,
                            15,
                          ),
                          child: Text('Pick Up Location', style: kSectionTitle),
                        ),
                      ),
                      FadeAnimation(
                        delay: 0.5,
                        child: GestureDetector(
                          onTap: () {
                            MapsLauncher.launchQuery(widget.location);
                          },
                          child: Center(
                            child: Stack(
                              children: [
                                Container(
                                  width: size.width * 0.93,
                                  height: size.height * 0.3,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Stack(
                                      children: [
                                        GoogleMap(
                                          mapToolbarEnabled: true,
                                          compassEnabled: true,
                                          onMapCreated: _onMapCreated,
                                          initialCameraPosition:
                                              initialCameraPosition,
                                          myLocationEnabled: true,
                                          myLocationButtonEnabled: false,
                                          markers: _markers,
                                          polylines: _polylines,
                                          mapType: MapType.normal,
                                        ),
                                        Align(
                                          alignment: Alignment.bottomLeft,
                                          child: GestureDetector(
                                            onTap: () {
                                              MapsLauncher.launchQuery(
                                                  widget.location);
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .bottomNavigationBarTheme
                                                    .backgroundColor,
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(10),
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black26,
                                                    blurRadius: 2,
                                                    offset: Offset(3, -3),
                                                  ),
                                                ],
                                              ),
                                              child: Shimmer.fromColors(
                                                baseColor: Colors.white,
                                                highlightColor: Colors.grey,
                                                child: Text(
                                                  'Click here to open',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'Barlow',
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 7, left: 7, right: 7),
                                          child: Align(
                                            alignment: Alignment.topCenter,
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 5, 10, 5),
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .bottomNavigationBarTheme
                                                    .backgroundColor!
                                                    .withOpacity(0.7),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(5),
                                                ),
                                              ),
                                              child: Text(
                                                widget.location,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Barlow',
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      FadeAnimation(
                        delay: 0.8,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 15, 16, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Prices', style: kSectionTitle),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: size.height * 0.1,
                                    width: size.width * 0.28,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: kShadeColor.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            'Rs ' +
                                                widget.price.toStringAsFixed(0),
                                            style: kPrice),
                                        const SizedBox(height: 2),
                                        Text(
                                          '/day',
                                          style: kRate.copyWith(
                                            fontWeight: FontWeight.w500,
                                            //color: kTextColor.withOpacity(0.6),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: size.height * 0.1,
                                    width: size.width * 0.28,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: kShadeColor.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            'Rs ' +
                                                widget.priceW
                                                    .toStringAsFixed(0),
                                            style: kPrice),
                                        const SizedBox(height: 2),
                                        Text(
                                          '/week',
                                          style: kRate.copyWith(
                                            fontWeight: FontWeight.w500,
                                            //color: kTextColor.withOpacity(0.6),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: size.height * 0.1,
                                    width: size.width * 0.28,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: kShadeColor.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            'Rs ' +
                                                widget.priceM
                                                    .toStringAsFixed(0),
                                            style: kPrice),
                                        const SizedBox(height: 2),
                                        Text(
                                          '/month',
                                          style: kRate.copyWith(
                                            fontWeight: FontWeight.w500,
                                            //color: kTextColor.withOpacity(0.6),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 100),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 15),
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
                        child: Center(child: Icon(CupertinoIcons.back)),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: FadeAnimation(
                      delay: 1.4,
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 15,
                              offset:
                                  Offset(0, 10), // horizontal, vertical offset
                            ),
                          ],
                        ),
                        height: 53,
                        width: MediaQuery.of(context).size.width - 32,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 20,
                        ),
                        child: TextButton(
                          onPressed: () {
                            if (snapshot.hasData && snapshot.data!.exists) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => CheckoutScreen(
                                      book: Book(
                                          name: widget.name,
                                          brand: widget.brand,
                                          model: widget.model,
                                          imageUrl: widget.imageUrl,
                                          imageUrl1: widget.imageUrl1,
                                          imageUrl2: widget.imageUrl2,
                                          description: widget.description,
                                          speed: widget.speed,
                                          seats: widget.seats,
                                          engine: widget.engine,
                                          stars: widget.stars,
                                          price: widget.price,
                                          priceW: widget.priceW,
                                          priceM: widget.priceM,
                                          date: widget.date,
                                          mileage: widget.mileage,
                                          color: widget.color,
                                          trans: widget.trans,
                                          fuel: widget.fuel,
                                          cc: widget.cc,
                                          color1: widget.color1,
                                          color2: widget.color2,
                                          color3: widget.color3,
                                          location: widget.location,
                                          coord1: widget.coord1,
                                          coord2: widget.coord2,
                                          chooseC1: widget.chooseC1,
                                          chooseC2: widget.chooseC2,
                                          chooseC3: widget.chooseC3),
                                      car: Car(
                                          name: widget.name,
                                          brand: widget.brand,
                                          model: widget.model,
                                          imageUrl: widget.imageUrl,
                                          imageUrl1: widget.imageUrl1,
                                          imageUrl2: widget.imageUrl2,
                                          description: widget.description,
                                          speed: widget.speed,
                                          seats: widget.seats,
                                          engine: widget.engine,
                                          stars: widget.stars,
                                          price: widget.price,
                                          priceW: widget.priceW,
                                          priceM: widget.priceM,
                                          date: widget.date,
                                          mileage: widget.mileage,
                                          color: widget.color,
                                          trans: widget.trans,
                                          fuel: widget.fuel,
                                          cc: widget.cc,
                                          color1: widget.color1,
                                          color2: widget.color2,
                                          color3: widget.color3,
                                          location: widget.location,
                                          coord1: widget.coord1,
                                          coord2: widget.coord2,
                                          chooseC1: widget.chooseC1,
                                          chooseC2: widget.chooseC2,
                                          chooseC3: widget.chooseC3),
                                      car2: Car2(
                                          name: widget.name,
                                          brand: widget.brand,
                                          model: widget.model,
                                          imageUrl: widget.imageUrl,
                                          imageUrl1: widget.imageUrl1,
                                          imageUrl2: widget.imageUrl2,
                                          description: widget.description,
                                          speed: widget.speed,
                                          seats: widget.seats,
                                          engine: widget.engine,
                                          stars: widget.stars,
                                          price: widget.price,
                                          priceW: widget.priceW,
                                          priceM: widget.priceM,
                                          date: widget.date,
                                          mileage: widget.mileage,
                                          color: widget.color,
                                          trans: widget.trans,
                                          fuel: widget.fuel,
                                          cc: widget.cc,
                                          color1: widget.color1,
                                          color2: widget.color2,
                                          color3: widget.color3,
                                          location: widget.location,
                                          coord1: widget.coord1,
                                          coord2: widget.coord2,
                                          chooseC1: widget.chooseC1,
                                          chooseC2: widget.chooseC2,
                                          chooseC3: widget.chooseC3),
                                      name: widget.name,
                                      brand: widget.brand,
                                      model: widget.model,
                                      imageUrl: widget.imageUrl,
                                      imageUrl1: widget.imageUrl1,
                                      imageUrl2: widget.imageUrl2,
                                      description: widget.description,
                                      speed: widget.speed,
                                      seats: widget.seats,
                                      engine: widget.engine,
                                      stars: widget.stars,
                                      price: widget.price,
                                      priceW: widget.priceW,
                                      priceM: widget.priceM,
                                      date: widget.date,
                                      mileage: widget.mileage,
                                      color: widget.color,
                                      trans: widget.trans,
                                      fuel: widget.fuel,
                                      cc: widget.cc,
                                      color1: widget.color1,
                                      color2: widget.color2,
                                      color3: widget.color3,
                                      location: widget.location,
                                      coord1: widget.coord1,
                                      coord2: widget.coord2,
                                      chooseC1: widget.chooseC1,
                                      chooseC2: widget.chooseC2,
                                      chooseC3: widget.chooseC3),
                                ),
                              );
                            } else {
                              // Show the login needed popup dialog
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    elevation: 20,
                                    shadowColor: Theme.of(context)
                                        .bottomNavigationBarTheme
                                        .backgroundColor,
                                    title: Row(
                                      children: [
                                        Icon(
                                          CupertinoIcons
                                              .exclamationmark_triangle_fill,
                                          color: Colors
                                              .redAccent, // Customize the icon color
                                        ),
                                        SizedBox(
                                            width:
                                                8), // Add some spacing between icon and text
                                        Text(
                                          "Login Needed",
                                          style: TextStyle(
                                              fontFamily: 'Montserrat'),
                                        ),
                                      ],
                                    ),
                                    content: Text(
                                        "You need to log in to continue.",
                                        style: TextStyle(fontFamily: 'Barlow')),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("OK",
                                            style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                color: Theme.of(context)
                                                    .bottomNavigationBarTheme
                                                    .backgroundColor)),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          /*onPressed: () async {
                        Uri phoneno = Uri.parse('tel:+97798345348734');
                        if (await launchUrl(phoneno)) {
                          //dialer opened
                        } else {
                          //dailer is not opened
                        }
                      },*/
                          child: const Text('Rent This Car'),
                          style: TextButton.styleFrom(
                            primary: kTextColor,
                            backgroundColor: kPrimaryColor,
                            textStyle: kPrice,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  /*void _openGoogleMaps() async {
    // The URL scheme for opening Google Maps
    final String googleMapsUrl = 'https://www.google.com/maps';

    await canLaunch(googleMapsUrl);
    await launch(googleMapsUrl);
  }*/
}
