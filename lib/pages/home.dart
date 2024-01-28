import 'dart:io';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homescreen/Components/fadeanimation.dart';
import 'package:homescreen/data/brand.dart';
import 'package:homescreen/data/car.dart';
import 'package:homescreen/pages/EditP.dart';
import 'package:homescreen/pages/FavouritesProvider.dart';
import 'package:homescreen/pages/SearchPage.dart';
import 'package:homescreen/pages/TransitionAnimation/LeftPageRoute.dart';
import 'package:homescreen/pages/detail.dart';
import 'package:homescreen/pages/rented.dart';
import 'package:homescreen/ui/chat.dart';
import 'package:provider/provider.dart';
import 'package:homescreen/pages/constant.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  DateTime?
      currentBackPressTime; // Track the time of the last back button press

  User? get currentUser => _firebaseAuth.currentUser;
  File? _image;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Brands>(create: (context) => Brands()),
        ChangeNotifierProvider<Cars>(create: (context) => Cars()),
      ],
      child: WillPopScope(
        onWillPop: () async {
          // Check if currentBackPressTime is null or the difference between current time and last back press time is more than 2 seconds (2000 milliseconds).
          if (currentBackPressTime == null ||
              DateTime.now().difference(currentBackPressTime!) >
                  Duration(milliseconds: 2000)) {
            // Show a snackbar to notify the user to tap twice to exit
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor:
                  Theme.of(context).bottomNavigationBarTheme.backgroundColor,
              content: Text(
                'Tap again to exit',
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),
              ),
              duration: Duration(seconds: 2),
            ));

            // Update the currentBackPressTime to the current time
            currentBackPressTime = DateTime.now();

            // Prevent the app from closing on the first back button press
            return false;
          }
          // Allow the app to close when tapped twice within the time window
          return true;
        },
        child: Scaffold(
          floatingActionButton: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("Users")
                  .doc(currentUser?.email)
                  .snapshots(),
              builder: (context, snapshot) {
                return FloatingActionButton(
                  backgroundColor: Theme.of(context)
                      .bottomNavigationBarTheme
                      .backgroundColor,
                  child: Image.asset(
                    'assets/images/robot.png',
                    scale: 2,
                  ),
                  onPressed: () {
                    if (snapshot.hasData && snapshot.data!.exists) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Chat()),
                      );
                    } else {
                      // Show the login needed popup dialog
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 20,
                            shadowColor: Theme.of(context)
                                .bottomNavigationBarTheme
                                .backgroundColor,
                            title: Row(
                              children: [
                                Icon(
                                  CupertinoIcons.exclamationmark_triangle_fill,
                                  color: Colors
                                      .redAccent, // Customize the icon color
                                ),
                                SizedBox(
                                    width:
                                        8), // Add some spacing between icon and text
                                Text(
                                  "Login Needed",
                                  style: TextStyle(fontFamily: 'Montserrat'),
                                ),
                              ],
                            ),
                            content: Text("You need to log in to use chat.",
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
                );
              }),
          body: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection("Users")
                .doc(currentUser?.email)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data!.exists) {
                final userData = snapshot.data?.data() as Map<String, dynamic>;

                return SafeArea(
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: <Widget>[
                      Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.fromLTRB(16, 11, 16, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Browse cars",
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.clip,
                                  style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 32,
                                    ),
                                  ),
                                ),
                                /*const SizedBox(
                                  width: 132,
                                ),*/
                                Row(
                                  children: [
                                    /*Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 11, 0, 0),
                                      child: Text(
                                        userData['username'],
                                        style: TextStyle(fontFamily: 'barlow'),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),*/
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0, right: 0),
                                      child: InkWell(
                                        onTap: () => Navigator.of(context)
                                            .pushReplacement(MaterialPageRoute(
                                                builder: (context) => EditP())),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.3),
                                                spreadRadius: 1,
                                                blurRadius: 5,
                                                offset: Offset(0,
                                                    2), // horizontal, vertical offset
                                              ),
                                            ],
                                            shape: BoxShape.circle,
                                          ),
                                          child: CircleAvatar(
                                            radius: 21,
                                            backgroundColor: Theme.of(context)
                                                .bottomNavigationBarTheme
                                                .backgroundColor,
                                            backgroundImage: _image != null
                                                ? FileImage(
                                                    _image!) // Display the selected image
                                                : (userData['profilePicture'] !=
                                                            null
                                                        ? (userData['profilePicture']
                                                                .startsWith(
                                                                    '/data/'))
                                                            ? FileImage(File(
                                                                userData[
                                                                    'profilePicture'])) // Load local file
                                                            : AssetImage(
                                                                'assets/images/default.png') // Load asset reference
                                                        : NetworkImage(userData[
                                                            'profilePicture']) // Fallback image
                                                    ) as ImageProvider<Object>,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            LeftPageRoute(
                              builder: (context) => MyHomePage1(),
                              enterPage: MyHomePage1(),
                            ),
                          );
                        },
                        child: Container(
                          height: size.height * 0.06,
                          width: size.width,
                          margin: const EdgeInsets.fromLTRB(15, 20, 16, 24),
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset:
                                    Offset(0, 2), // horizontal, vertical offset
                              ),
                            ],
                            //color: lightTheme.primaryColor,
                            borderRadius: BorderRadius.circular(10),
                            //border: Border.all(color: Color(0xFF0A486D), width: 2),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: DefaultTextStyle(
                                  style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 17,
                                      color: Theme.of(context)
                                          .bottomNavigationBarTheme
                                          .backgroundColor,
                                    ),
                                  ),
                                  /*child: Shimmer.fromColors(
                                      period: Duration(seconds: 3),
                                      baseColor: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      highlightColor: Theme.of(context)
                                          .bottomNavigationBarTheme
                                          .backgroundColor!,
                                      child: Text('Looking For Something?...')),*/
                                  child: AnimatedTextKit(
                                    animatedTexts: [
                                      TyperAnimatedText(
                                        'Looking for something?...',
                                        textStyle: TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: Theme.of(context)
                                                .bottomNavigationBarTheme
                                                .backgroundColor),
                                        speed: Duration(milliseconds: 50),
                                      ),
                                    ],
                                    isRepeatingAnimation: true,
                                    repeatForever: true,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Icon(
                                  Icons.search,
                                  color: Theme.of(context)
                                      .bottomNavigationBarTheme
                                      .backgroundColor,
                                ),
                              ),
                              /*Container(
                                margin: EdgeInsets.fromLTRB(100, 0, 0, 0),
                                child: Icon(
                                  Icons.search,
                                  color: Color(0xFF0A486D),
                                ),
                              ),*/
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 13),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Hot Deals',
                              style: kSectionTitle,
                            ),
                            Consumer<Cars>(
                              builder: (context, item, _) => GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => RecentlyRented(
                                        item: item,
                                      ),
                                    ),
                                  );
                                },
                                child: Text(
                                  'More Details ➠',
                                  style: kViewAll.copyWith(
                                    color: Theme.of(context)
                                        .bottomNavigationBarTheme
                                        .backgroundColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Consumer<FavoritesProvider>(
                          builder: (context, favoritesProvider, child) =>
                              Consumer<Cars>(
                                builder: (context, item, _) => SizedBox(
                                  height: size.height * 0.39,
                                  child: ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: item.cars.length,
                                    itemBuilder: (ctx, i) {
                                      /*final favoritesProvider =
                                          Provider.of<FavoritesProvider>(
                                              context);*/

                                      bool isBookmarked = favoritesProvider
                                          .favorites
                                          .contains(item
                                              .cars[i]); // Track bookmark state

                                      /*bool isBookmarked1 = favoritesProvider
                                          .isItemBookmarked(item.cars[i]);*/

                                      return InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailScreen(
                                                name: item.cars[i].name,
                                                model: item.cars[i].model,
                                                brand: item.cars[i].brand,
                                                imageUrl: item.cars[i].imageUrl,
                                                imageUrl1:
                                                    item.cars[i].imageUrl1,
                                                imageUrl2:
                                                    item.cars[i].imageUrl2,
                                                description:
                                                    item.cars[i].description,
                                                speed: item.cars[i].speed,
                                                seats: item.cars[i].seats,
                                                engine: item.cars[i].engine,
                                                price: item.cars[i].price,
                                                priceW: item.cars[i].priceW,
                                                priceM: item.cars[i].priceM,
                                                trans: item.cars[i].trans,
                                                fuel: item.cars[i].fuel,
                                                cc: item.cars[i].cc,
                                                color1: item.cars[i].color1,
                                                color2: item.cars[i].color2,
                                                color3: item.cars[i].color3,
                                                location: item.cars[i].location,
                                                stars: item.cars[i].stars,
                                                cars: [],
                                                color: item.cars[i].color,
                                                date: item.cars[i].date,
                                                mileage: item.cars[i].mileage,
                                                coord1: item.cars[i].coord1,
                                                coord2: item.cars[i].coord2,
                                                chooseC1: item.cars[i].chooseC1,
                                                chooseC2: item.cars[i].chooseC2,
                                                chooseC3: item.cars[i].chooseC3,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 5, 0, 8),
                                          child: Stack(
                                            children: [
                                              Container(
                                                height: size.height * 0.39,
                                                width: size.width * 0.64,
                                                alignment: Alignment.centerLeft,
                                                margin:
                                                    const EdgeInsets.fromLTRB(
                                                        15, 0, 0, 0),
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        12, 16, 0, 0),
                                                decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.3),
                                                      spreadRadius: 1,
                                                      blurRadius: 4,
                                                      offset: Offset(0,
                                                          2), // horizontal, vertical offset
                                                    ),
                                                  ],
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Stack(
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            FadeAnimation(
                                                              delay: 0.1,
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    item.cars[i]
                                                                            .name +
                                                                        '\n' +
                                                                        item.cars[i]
                                                                            .model,
                                                                    style:
                                                                        kBrand,
                                                                  ),
                                                                  const SizedBox(
                                                                      height:
                                                                          4),
                                                                  Row(
                                                                    children: [
                                                                      Image.asset(
                                                                          'assets/images/star2.png'),
                                                                      const SizedBox(
                                                                          width:
                                                                              4),
                                                                      Text(
                                                                        item.cars[i]
                                                                            .stars,
                                                                        style: kRate
                                                                            .apply(),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .fromLTRB(
                                                                      0,
                                                                      0,
                                                                      12,
                                                                      0),
                                                              child: Container(
                                                                height:
                                                                    size.width *
                                                                        0.12,
                                                                width:
                                                                    size.width *
                                                                        0.12,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.6),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),
                                                                child: Center(
                                                                  child:
                                                                      IconButton(
                                                                    icon: Icon(
                                                                      isBookmarked
                                                                          ? Icons
                                                                              .bookmark
                                                                          : Icons
                                                                              .bookmark_add,
                                                                      color: Theme.of(
                                                                              context)
                                                                          .bottomNavigationBarTheme
                                                                          .backgroundColor,
                                                                      size: 27,
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      if (isBookmarked) {
                                                                        favoritesProvider
                                                                            .removeFromFavorites(item.cars[i]);
                                                                        // Show a snackbar indicating that the car has been removed from favorites
                                                                        ScaffoldMessenger.of(context)
                                                                            .showSnackBar(
                                                                          SnackBar(
                                                                            duration:
                                                                                Duration(seconds: 1),
                                                                            content:
                                                                                Text(
                                                                              '${item.cars[i].name + ' ' + item.cars[i].model} removed from favourites.',
                                                                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Barlow', letterSpacing: 0.5),
                                                                            ),
                                                                            behavior:
                                                                                SnackBarBehavior.floating,
                                                                            shape:
                                                                                RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(10),
                                                                            ),
                                                                            backgroundColor:
                                                                                Theme.of(context).bottomNavigationBarTheme.backgroundColor!.withOpacity(0.7),
                                                                          ),
                                                                        );
                                                                      } else {
                                                                        favoritesProvider
                                                                            .addToFavorites(item.cars[i]);
                                                                        // Show a snackbar indicating that the car has been added to favorites
                                                                        ScaffoldMessenger.of(context)
                                                                            .showSnackBar(
                                                                          SnackBar(
                                                                            duration:
                                                                                Duration(seconds: 1),
                                                                            content:
                                                                                Text(
                                                                              '${item.cars[i].name + ' ' + item.cars[i].model} added to favourites.',
                                                                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Barlow', letterSpacing: 0.5),
                                                                            ),
                                                                            behavior:
                                                                                SnackBarBehavior.floating,
                                                                            shape:
                                                                                RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(10),
                                                                            ),
                                                                            backgroundColor:
                                                                                Theme.of(context).bottomNavigationBarTheme.backgroundColor!.withOpacity(0.7),
                                                                          ),
                                                                        );
                                                                      }
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                            height: 1),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  0, 0, 12, 0),
                                                          child: FadeAnimation(
                                                            delay: 0.4,
                                                            child: Center(
                                                              child: Hero(
                                                                tag: item
                                                                    .cars[i]
                                                                    .imageUrl,
                                                                child:
                                                                    Image.asset(
                                                                  fit: BoxFit
                                                                      .scaleDown,
                                                                  item.cars[i]
                                                                      .imageUrl,
                                                                  scale: 1,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 30),
                                                        FadeAnimation(
                                                          delay: 0.7,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Image.asset(
                                                                  'assets/images/cost.png'),
                                                              const SizedBox(
                                                                  width: 8),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    'Rs ' +
                                                                        item.cars[i]
                                                                            .price
                                                                            .toStringAsFixed(0),
                                                                    style:
                                                                        kPrice,
                                                                  ),
                                                                  Text(
                                                                    ' / day',
                                                                    style:
                                                                        kPrice,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  0, 3, 0, 0),
                                                        ),
                                                        FadeAnimation(
                                                          delay: 1.0,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Image.asset(
                                                                  'assets/images/color.png'),
                                                              const SizedBox(
                                                                  width: 8),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    item.cars[i]
                                                                        .color,
                                                                    style:
                                                                        kColor,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      child: Container(
                                                        child: Center(
                                                          child: Text(
                                                            'View',
                                                            style: GoogleFonts
                                                                .barlow(
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              letterSpacing: 1,
                                                            ),
                                                          ),
                                                        ),
                                                        height:
                                                            size.height * 0.055,
                                                        width:
                                                            size.width * 0.24,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10),
                                                            topLeft:
                                                                Radius.circular(
                                                                    10),
                                                          ),
                                                          color: Theme.of(
                                                                  context)
                                                              .bottomNavigationBarTheme
                                                              .backgroundColor,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.5),
                                                              spreadRadius: 1,
                                                              blurRadius: 5,
                                                              offset: Offset(
                                                                  -1, -1),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              )),
                      GestureDetector(
                        onTap: () {
                          /*Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => MyHomePage2(),
                      ),
                    );*/
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 20, 0, 13),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              /*SizedBox(
                          width: 20,
                        ),*/
                              Text(
                                'Our Brands',
                                style: kSectionTitle.copyWith(),
                              ),
                              /*Text(
                          'View all',
                          style: kViewAll.copyWith(
                            color: Theme.of(context)
                                .bottomNavigationBarTheme
                                .backgroundColor,
                          ),
                        ),*/
                            ],
                          ),
                        ),
                      ),
                      Consumer<Brands>(
                        builder: (context, item, _) => SizedBox(
                          height: size.height * 0.195,
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: item.brands.length,
                            itemBuilder: (ctx, i) {
                              return Padding(
                                padding: const EdgeInsets.fromLTRB(0, 5, 0, 9),
                                child: Container(
                                  height: size.height * 0.07,
                                  width: size.width * 0.37,
                                  alignment: Alignment.center,
                                  margin:
                                      const EdgeInsets.fromLTRB(15, 0, 0, 0),
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 18, 0, 11),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                        offset: Offset(0,
                                            2), // horizontal, vertical offset
                                      ),
                                    ],
                                    color: Theme.of(context).primaryColor,
                                    //color: kShadeColor.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(10),
                                    /*border: Border.all(
                                    color: Color(0xFF0a468d), width: 1.5),*/
                                  ),
                                  child: Column(
                                    children: [
                                      FadeAnimation(
                                        delay: 0.1,
                                        child: Image.asset(
                                          item.brands[i].imageUrl,
                                          scale: 2,
                                        ),
                                      ),
                                      const SizedBox(height: 9),
                                      FadeAnimation(
                                        delay: 0.4,
                                        child: Text(
                                          item.brands[i].name,
                                          style: kBrand.copyWith(fontSize: 20),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      /*const Padding(
                  padding: EdgeInsets.fromLTRB(15, 24, 15, 13),
                  child: Text('Top Dealers', style: kSectionTitle),
                                ),
                                Container(
                  width: size.width,
                  height: size.height * 0.1,
                  margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: kShadeColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/kristy.png'),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Kristy's Garage", style: kBrand),
                          const SizedBox(height: 3),
                          Text(
                            "123 Swanston Street, Melbourne VIC",
                            style: kBrand.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                                ),*/
                    ],
                  ),
                );
              }
              /*else if (snapshot.hasError)*/ {}

              return SafeArea(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: <Widget>[
                    InkWell(
                      onTap: () {},
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              height: 50,
                              width: 170,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 25),
                                child: Text(
                                  'Guest (Not logged in)',
                                  style: TextStyle(fontFamily: 'montserrat'),
                                ),
                              ),
                              //decoration: BoxDecoration(color: Colors.red),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(16, 11, 0, 0),
                            child: Row(
                              children: [
                                Text(
                                  "Browse cars",
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.clip,
                                  style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 32,
                                      //color: Color(0xffffffff),
                                      /*shadows: const [
                                    Shadow(
                                      blurRadius: 10.0, // shadow blur
                                      color:
                                          Color.fromARGB(255, 46, 46, 46), // shadow color
                                      offset:
                                          Offset(1.0, 2.0), // how much shadow will be shown
                                    ),
                                  ],*/
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          LeftPageRoute(
                            builder: (context) => MyHomePage1(),
                            enterPage: MyHomePage1(),
                          ),
                        );
                      },
                      child: Container(
                        height: size.height * 0.06,
                        width: size.width,
                        margin: const EdgeInsets.fromLTRB(15, 20, 16, 24),
                        padding: const EdgeInsets.fromLTRB(16, 16, 0, 14),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset:
                                  Offset(0, 2), // horizontal, vertical offset
                            ),
                          ],
                          //color: lightTheme.primaryColor,
                          borderRadius: BorderRadius.circular(10),
                          //border: Border.all(color: Color(0xFF0A486D), width: 2),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: DefaultTextStyle(
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 17,
                                    color: Theme.of(context)
                                        .bottomNavigationBarTheme
                                        .backgroundColor,
                                    /*shadows: [
                                  Shadow(
                                    blurRadius: 3.0, // shadow blur
                                    color: Colors.black, // shadow color
                                    offset: Offset(0.0,
                                        5.0), // how much shadow will be shown
                                  ),
                                ],*/
                                  ),
                                ),
                                child: Shimmer.fromColors(
                                    baseColor: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    highlightColor: Theme.of(context)
                                        .bottomNavigationBarTheme
                                        .backgroundColor!,
                                    child: Text('Looking For Something?...')),
                                /*child: AnimatedTextKit(
                              animatedTexts: [
                                TyperAnimatedText(
                                  'Looking for something?...',
                                  speed: Duration(milliseconds: 150),
                                ),
                              ],
                              isRepeatingAnimation: true,
                              repeatForever: true,
                            ),*/
                              ),
                              /*Text(
                            'Looking for something?...',
                            style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 17,
                                color: Color(0xFF2E8970),
                                shadows: const [
                                  Shadow(
                                    blurRadius: 3.0, // shadow blur
                                    color: Color.fromARGB(
                                        255, 46, 46, 46), // shadow color
                                    offset: Offset(0.0,
                                        2.0), // how much shadow will be shown
                                  ),
                                ],
                              ),
                            ),
                          ),*/
                              //child: Icon(Icons.search),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(100, 0, 0, 0),
                              child: Icon(
                                Icons.search,
                                color: Color(0xFF0A486D),
                              ),
                            ),
                            /*Padding(
                          padding: const EdgeInsets.fromLTRB(113, 0, 0, 0),
                          child: Icon(
                            Icons.search,
                            color: Color(0xFF2E8970),
                          ),
                        ),*/
                          ],
                        ),

                        /*child: TextField(
                      autofocus: false,
                      obscureText: false,
                      /*controller: searchController,*/
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Looking for something?...',
                        hintStyle: kSearchHint,
                        suffixIcon: Icon(Icons.search),
                        suffixIconColor: Color(0xFF2E8970),
                        //icon: Image.asset('assets/images/search.png'),
                      ),
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        color: Color(0xff76E595),
                      ),
                    ),*/
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 13),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Hot Deals',
                            style: kSectionTitle,
                          ),
                          Consumer<Cars>(
                            builder: (context, item, _) => GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => RecentlyRented(
                                      item: item,
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                'More Details ➠',
                                style: kViewAll.copyWith(
                                  color: Theme.of(context)
                                      .bottomNavigationBarTheme
                                      .backgroundColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Consumer<FavoritesProvider>(
                        builder: (context, favoritesProvider, _) =>
                            Consumer<Cars>(
                              builder: (context, item, _) => SizedBox(
                                height: size.height * 0.39,
                                child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: item.cars.length,
                                  itemBuilder: (ctx, i) {
// Track bookmark state

                                    return InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => DetailScreen(
                                              name: item.cars[i].name,
                                              model: item.cars[i].model,
                                              brand: item.cars[i].brand,
                                              imageUrl: item.cars[i].imageUrl,
                                              imageUrl1: item.cars[i].imageUrl1,
                                              imageUrl2: item.cars[i].imageUrl2,
                                              description:
                                                  item.cars[i].description,
                                              speed: item.cars[i].speed,
                                              seats: item.cars[i].seats,
                                              engine: item.cars[i].engine,
                                              price: item.cars[i].price,
                                              priceW: item.cars[i].priceW,
                                              priceM: item.cars[i].priceM,
                                              trans: item.cars[i].trans,
                                              fuel: item.cars[i].fuel,
                                              cc: item.cars[i].cc,
                                              color1: item.cars[i].color1,
                                              color2: item.cars[i].color2,
                                              color3: item.cars[i].color3,
                                              location: item.cars[i].location,
                                              stars: item.cars[i].stars,
                                              cars: [],
                                              color: item.cars[i].color,
                                              date: item.cars[i].date,
                                              mileage: item.cars[i].mileage,
                                              coord1: item.cars[i].coord1,
                                              coord2: item.cars[i].coord2,
                                              chooseC1: item.cars[i].chooseC1,
                                              chooseC2: item.cars[i].chooseC2,
                                              chooseC3: item.cars[i].chooseC3,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 5, 0, 8),
                                        child: Stack(
                                          children: [
                                            Container(
                                              height: size.height * 0.39,
                                              width: size.width * 0.64,
                                              alignment: Alignment.centerLeft,
                                              margin: const EdgeInsets.fromLTRB(
                                                  15, 0, 0, 0),
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      12, 16, 0, 0),
                                              decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.3),
                                                    spreadRadius: 1,
                                                    blurRadius: 4,
                                                    offset: Offset(0,
                                                        2), // horizontal, vertical offset
                                                  ),
                                                ],
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Stack(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          FadeAnimation(
                                                            delay: 0.1,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  item.cars[i]
                                                                          .name +
                                                                      '\n' +
                                                                      item
                                                                          .cars[
                                                                              i]
                                                                          .model,
                                                                  style: kBrand,
                                                                ),
                                                                const SizedBox(
                                                                    height: 4),
                                                                Row(
                                                                  children: [
                                                                    Image.asset(
                                                                        'assets/images/star2.png'),
                                                                    const SizedBox(
                                                                        width:
                                                                            4),
                                                                    Text(
                                                                      item
                                                                          .cars[
                                                                              i]
                                                                          .stars,
                                                                      style: kRate
                                                                          .apply(),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 1),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                0, 0, 12, 0),
                                                        child: FadeAnimation(
                                                          delay: 0.4,
                                                          child: Center(
                                                            child: Hero(
                                                              tag: item.cars[i]
                                                                  .imageUrl,
                                                              child:
                                                                  Image.asset(
                                                                fit: BoxFit
                                                                    .scaleDown,
                                                                item.cars[i]
                                                                    .imageUrl,
                                                                scale: 1,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 30),
                                                      FadeAnimation(
                                                        delay: 0.7,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Image.asset(
                                                                'assets/images/cost.png'),
                                                            const SizedBox(
                                                                width: 8),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  'Rs ' +
                                                                      item
                                                                          .cars[
                                                                              i]
                                                                          .price
                                                                          .toStringAsFixed(
                                                                              0),
                                                                  style: kPrice,
                                                                ),
                                                                Text(
                                                                  ' / day',
                                                                  style: kPrice,
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                0, 3, 0, 0),
                                                      ),
                                                      FadeAnimation(
                                                        delay: 1.0,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Image.asset(
                                                                'assets/images/color.png'),
                                                            const SizedBox(
                                                                width: 8),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  item.cars[i]
                                                                      .color,
                                                                  style: kColor,
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    child: Container(
                                                      child: Center(
                                                        child: Text(
                                                          'View',
                                                          style: GoogleFonts
                                                              .barlow(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            letterSpacing: 1,
                                                          ),
                                                        ),
                                                      ),
                                                      height:
                                                          size.height * 0.055,
                                                      width: size.width * 0.24,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          bottomRight:
                                                              Radius.circular(
                                                                  10),
                                                          topLeft:
                                                              Radius.circular(
                                                                  10),
                                                        ),
                                                        color: Theme.of(context)
                                                            .bottomNavigationBarTheme
                                                            .backgroundColor,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.5),
                                                            spreadRadius: 1,
                                                            blurRadius: 5,
                                                            offset:
                                                                Offset(-1, -1),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            )),
                    GestureDetector(
                      onTap: () {
                        /*Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => MyHomePage2(),
                      ),
                    );*/
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 20, 0, 13),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            /*SizedBox(
                          width: 20,
                        ),*/
                            Text(
                              'Our Brands',
                              style: kSectionTitle.copyWith(),
                            ),
                            /*Text(
                          'View all',
                          style: kViewAll.copyWith(
                            color: Theme.of(context)
                                .bottomNavigationBarTheme
                                .backgroundColor,
                          ),
                        ),*/
                          ],
                        ),
                      ),
                    ),
                    Consumer<Brands>(
                      builder: (context, item, _) => SizedBox(
                        height: size.height * 0.195,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: item.brands.length,
                          itemBuilder: (ctx, i) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(0, 5, 0, 9),
                              child: Container(
                                height: size.height * 0.07,
                                width: size.width * 0.37,
                                alignment: Alignment.center,
                                margin: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                                padding:
                                    const EdgeInsets.fromLTRB(0, 18, 0, 11),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: Offset(
                                          0, 2), // horizontal, vertical offset
                                    ),
                                  ],
                                  color: Theme.of(context).primaryColor,
                                  //color: kShadeColor.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10),
                                  /*border: Border.all(
                                    color: Color(0xFF0a468d), width: 1.5),*/
                                ),
                                child: Column(
                                  children: [
                                    FadeAnimation(
                                      delay: 0.1,
                                      child: Image.asset(
                                        item.brands[i].imageUrl,
                                        scale: 2,
                                      ),
                                    ),
                                    const SizedBox(height: 9),
                                    FadeAnimation(
                                      delay: 0.4,
                                      child: Text(
                                        item.brands[i].name,
                                        style: kBrand.copyWith(fontSize: 20),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
