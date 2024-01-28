import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homescreen/main.dart';
import 'package:homescreen/pages/EditP.dart';
import 'package:homescreen/pages/favscreen.dart';
import 'package:homescreen/pages/helpAndSupportPage.dart';
import 'package:homescreen/pages/loginorsignup.dart';
import 'package:homescreen/pages/recentlysearched.dart';
import 'package:homescreen/pages/termsAndConditionsPage.dart';
import 'package:homescreen/pages/theme_provider.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();

  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        themeProvider.toggleTheme(); // Set the themeMode to dark
        return Scaffold(
            // Your dark mode page content
            );
      },
    );
  }
}

class _ProfilePageState extends State<Profile> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final userCollection = FirebaseFirestore.instance.collection("Users");
  // A variable to store the selected image
  File? _image;

  int currentPage = MyHomePageState().getCurrentPage;
  DateTime?
      currentBackPressTime; // Track the time of the last back button press

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginorSignUpPage()));
  }

  // A function to pick an image from the camera or gallery
  /*Future<void> _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      setState(() {
        _image = image;
      });
    } catch (e) {
      print(e);
    }
  }*/

  User? get currentUser => _firebaseAuth.currentUser;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
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
        //backgroundColor: Color(0xffffffff),
        /*appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Color(0x00ffffff),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          title: Text(
            "My Profile",
            style: GoogleFonts.montserrat(
              textStyle: const TextStyle(
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
                fontSize: 28,
                color: Color(0xFF2E8970),
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
          ),
        ),*/

        body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection("Users")
              .doc(currentUser?.email)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!.exists) {
              final userData = snapshot.data?.data() as Map<String, dynamic>;

              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 50, 0, 13),
                      child: Text(
                        "My Profile",
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 30,
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
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(
                            height: 155,
                            width: 1155,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                // Display the selected image or a placeholder if none
                                Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.5),
                                        blurRadius: 10,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                    shape: BoxShape.circle,
                                  ),
                                  child: CircleAvatar(
                                    radius: 73,
                                    backgroundColor: Theme.of(context)
                                        .bottomNavigationBarTheme
                                        .backgroundColor,
                                    backgroundImage: _image != null
                                        ? FileImage(
                                            _image!) // Display the selected image
                                        : (userData['profilePicture'] != null
                                                ? (userData['profilePicture']
                                                        .startsWith('/data/'))
                                                    ? FileImage(File(userData[
                                                        'profilePicture'])) // Load local file
                                                    : AssetImage(
                                                        'assets/images/default.png') // Load asset reference
                                                : NetworkImage(userData[
                                                    'profilePicture']) // Fallback image
                                            ) as ImageProvider<Object>,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          /*const Icon(
                      Icons.camera_alt,
                      color: Color(0xff76E595),
                      size: 20,
                    ),*/

                          Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 2)),
                          Text(
                            userData['username'],
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              letterSpacing: 1,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                              fontSize: 18,
                              //color: Color(0xff000000),
                            ),
                          ),
                          Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 2)),
                          /*ElevatedButton.icon(
                      onPressed: () => _pickImage(ImageSource.gallery),
                      icon: Icon(Icons.camera_alt),
                      label: Text('Change Profile Picture'),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF4760E3),
                        onPrimary: Color(0xff76E595),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        padding: EdgeInsets.all(9),
                      ),
                    ),*/

                          //Directionality added so that icon relocates at the end of the elevated button
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: ElevatedButton.icon(
                              onPressed: () => Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                      builder: (context) => EditP())),
                              label: const Text(
                                'Edit Profile',
                                style: TextStyle(
                                    letterSpacing: 1,
                                    fontSize: 14,
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                              icon: Icon(
                                Icons.arrow_back_ios_sharp,
                                size: 16,
                                color: Colors.white,
                              ),
                              style: ElevatedButton.styleFrom(
                                elevation: 5,
                                //primary: Color(0xFF4760E3),
                                //onPrimary: Color(0xff76E595),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                padding: EdgeInsets.all(13),
                              ),
                            ),
                          ),
                          Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),

                          Container(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width,
                            ),
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                            height: 40,
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .bottomNavigationBarTheme
                                  .backgroundColor,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.zero,
                            ),
                            child: Text(
                              "CONTENT",
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.normal,
                                fontFamily: 'Montserrat',
                                fontSize: 14,
                                letterSpacing: 1.5,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                          Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),

                          Padding(
                            padding: EdgeInsets.fromLTRB(13, 0, 0, 5),
                            child: InkWell(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FavoritesScreen(),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.all(0),
                                    padding: EdgeInsets.fromLTRB(0, 7, 0, 7),
                                    /*decoration: BoxDecoration(
                                color: Color(0xFF4760E3),
                                shape: BoxShape.circle,
                              ),*/
                                    child: Icon(
                                      Icons.star,
                                      color: Theme.of(context)
                                          .bottomNavigationBarTheme
                                          .backgroundColor,
                                      size: 25,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 16),
                                      child: Text(
                                        "Favourites",
                                        textAlign: TextAlign.start,
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontStyle: FontStyle.normal,
                                          fontFamily: 'Montserrat',
                                          fontSize: 16,
                                          //color: Color(0xff000000),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      color: Theme.of(context)
                                          .bottomNavigationBarTheme
                                          .backgroundColor,
                                      size: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(13, 0, 0, 5),
                            child: InkWell(
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => SearchHistoryPage(),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.all(0),
                                    padding: EdgeInsets.fromLTRB(0, 7, 0, 7),
                                    /*decoration: BoxDecoration(
                                color: Color(0xFF4760E3),
                                shape: BoxShape.circle,
                              ),*/
                                    child: Icon(
                                      Icons.history,
                                      color: Theme.of(context)
                                          .bottomNavigationBarTheme
                                          .backgroundColor,
                                      size: 25,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 16),
                                      child: Text(
                                        "Recently Viewed",
                                        textAlign: TextAlign.start,
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Montserrat',
                                          fontStyle: FontStyle.normal,
                                          fontSize: 16,
                                          //color: Color(0xff000000),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      color: Theme.of(context)
                                          .bottomNavigationBarTheme
                                          .backgroundColor,
                                      size: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width,
                      ),
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                      height: 40,
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .bottomNavigationBarTheme
                            .backgroundColor,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.zero,
                      ),
                      child: Text(
                        "PREFERENCES",
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.normal,
                          fontFamily: 'Montserrat',
                          fontSize: 14,
                          letterSpacing: 1.5,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Icon(
                            Icons.dark_mode_sharp,
                            color: Theme.of(context)
                                .bottomNavigationBarTheme
                                .backgroundColor,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(32, 0, 0, 0),
                          child: Consumer<ThemeProvider>(
                            builder: (context, themeProvider, _) =>
                                SwitchListTile(
                              /*inactiveThumbColor: Theme.of(context)
                                  .bottomNavigationBarTheme
                                  .backgroundColor,*/
                              inactiveThumbImage:
                                  AssetImage('assets/images/sun.png'),
                              activeColor: Theme.of(context)
                                  .bottomNavigationBarTheme
                                  .backgroundColor,
                              activeThumbImage:
                                  AssetImage('assets/images/moon.png'),
                              title: Text(
                                'Dark Mode',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              value: themeProvider.themeMode == ThemeMode.dark,
                              onChanged: (_) => themeProvider.toggleTheme(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => helpAndSupportPage(),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Icon(
                                Icons.support_agent,
                                color: Theme.of(context)
                                    .bottomNavigationBarTheme
                                    .backgroundColor,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Help and Support',
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 15.5,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => TermsAndConditionsPage(),
                        ),
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Icon(
                                Icons.notes,
                                color: Theme.of(context)
                                    .bottomNavigationBarTheme
                                    .backgroundColor,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Terms and Conditions',
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 15.5,
                                    fontWeight: FontWeight.w700),
                              ),
                              /*ElevatedButton(
                                  onPressed: () => Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(
                                          builder: (context) =>
                                              PaymentMethodScreen())),
                                  child: Text("TEST")),*/
                              /*ElevatedButton(
                                  onPressed: () => Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(
                                          builder: (context) =>
                                              CarRentalApp())),
                                  child: Text("TESfeT"))*/
                              /*ElevatedButton(
                                  onPressed: () => ,
                                  child: Text("TESfedfedT"))*/
                            ],
                          ),
                        ),
                      ),
                    ),
                    /* Container(
                      child: ElevatedButton(
                          onPressed: () => signOut(),
                          child: Text('Press to back off')),
                    ),*/
                    GestureDetector(
                      //onTap: () => MyHomePage.homePageKey.currentState?.goToPageTwo(),
                      onTap: () => signOut(),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          alignment: Alignment.center,
                          margin:
                              EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                          padding: EdgeInsets.all(0),
                          width: 150,
                          height: 45,
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .bottomNavigationBarTheme
                                .backgroundColor,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.logout,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                size: 24,
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                                child: Text(
                                  "Sign Out",
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 15.5,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            /*else if (snapshot.hasError)*/ {
              return Scaffold(
                backgroundColor: Color(0xffffffff),
                body: Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        ///***If you have exported images you must have to copy those images in assets/images directory.
                        Lottie.asset(
                          "assets/images/121421-login.json",
                          width: 180,
                          height: 180,
                          fit: BoxFit.cover,
                          repeat: true,
                          animate: true,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                          child: Text(
                            "No account found :-(",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                              fontSize: 20,
                              color: Color(0xff000000),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                          child: Text(
                            "Please login to access this section",
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 14,
                              color: Color(0xff727272),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                          child: MaterialButton(
                            onPressed: () => signOut(),
                            color: Theme.of(context)
                                .bottomNavigationBarTheme
                                .backgroundColor,
                            elevation: 15,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            padding: EdgeInsets.all(16),
                            child: Text(
                              "Login Now",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Montserrat",
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                            textColor: Color(0xffffffff),
                            height: 45,
                            minWidth: MediaQuery.of(context).size.width * 0.45,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
