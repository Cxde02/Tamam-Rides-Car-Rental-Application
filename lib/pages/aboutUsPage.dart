// ignore_for_file: use_key_in_widget_constructors

import 'package:drop_shadow/drop_shadow.dart';
import 'package:flutter/material.dart';
import 'package:homescreen/pages/ContactUsPage.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class AboutUs extends StatelessWidget {
  DateTime?
      currentBackPressTime; // Track the time of the last back button press

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
            content: Center(
              child: Text(
                'Tap again to exit',
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),
              ),
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
        body: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.only(top: 37),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                ///***If you have exported images you must have to copy those images in assets/images directory.
                DropShadow(
                  offset: Offset(0, 0),
                  blurRadius: 5,
                  child: Shimmer.fromColors(
                    enabled: false,
                    baseColor: Theme.of(context)
                        .bottomNavigationBarTheme
                        .backgroundColor!,
                    highlightColor: Theme.of(context).primaryColor,
                    child: Image(
                      image: AssetImage("assets/images/S2.png"),
                      //height: 140,
                      width: 120,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Text(
                    "Welcome to TAMAM RIDES!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Montserrat',
                      fontSize: 20,
                      //color: Color(0xff000000),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 14, 20, 0),
                  child: Text(
                    "We are committed to providing you, our precious clients, with a convenient and reliable way to rent cars for your travel needs",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      //letterSpacing: 1.5,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'Montserrat',
                      fontSize: 15,
                      //color: Color(0xff000000),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 16, 20, 0),
                  child: Text(
                    "Our mission is to deliver exceptional car rental services that exceed customer expectations",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      //letterSpacing: 1.5,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'Montserrat',
                      fontSize: 15,
                      //color: Color(0xff000000),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: Text(
                      "Our Values",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        //letterSpacing: 1.5,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Montserrat',
                        fontSize: 15,
                        //color: Color(0xff000000),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 8, 20, 0),
                    child: Text(
                      "🔹 Customer satisfaction is our top priority",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        //letterSpacing: 1.5,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Montserrat',
                        fontSize: 15,
                        //color: Color(0xff000000),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 3, 20, 0),
                    child: Text(
                      "🔹 We offer a wide selection of vehicles",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        //letterSpacing: 1.5,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Montserrat',
                        fontSize: 15,
                        //color: Color(0xff000000),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 3, 20, 0),
                    child: Text(
                      "🔹 We provide transparent pricing",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        //letterSpacing: 1.5,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Montserrat',
                        fontSize: 15,
                        //color: Color(0xff000000),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 3, 20, 0),
                    child: Text(
                      "🔹 We offer secured transactions",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        //letterSpacing: 1.5,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Montserrat',
                        fontSize: 15,
                        //color: Color(0xff000000),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 3, 20, 0),
                    child: Text(
                      "🔹 We offer face to face interactions",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        //letterSpacing: 1.5,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Montserrat',
                        fontSize: 15,
                        //color: Color(0xff000000),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 16, 20, 0),
                    child: Text(
                      "Our Contact information",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        //letterSpacing: 1.5,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Montserrat',
                        fontSize: 15,
                        //color: Color(0xff000000),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 9, 20, 0),
                    child: Text(
                      "Fixed Line: +230 4385962",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        //letterSpacing: 1.5,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'barlow',
                        fontSize: 16,
                        //color: Color(0xff000000),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                    child: Text(
                      "Phone Number 1: +230 59220603",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        //letterSpacing: 1.5,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'barlow',
                        fontSize: 16,
                        //color: Color(0xff000000),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                    child: Text(
                      "Phone Number 2: +230 58185377",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        //letterSpacing: 1.5,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'barlow',
                        fontSize: 16,
                        //color: Color(0xff000000),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                    child: Text(
                      "Phone Number 3: +230 54841871",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        //letterSpacing: 1.5,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'barlow',
                        fontSize: 16,
                        //color: Color(0xff000000),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                    child: Text(
                      "Email: info@tamamrides.mu",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        //letterSpacing: 1.5,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'barlow',
                        fontSize: 16,
                        //color: Color(0xff000000),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          //fit: BoxFit.fill,
                          image: AssetImage('assets/images/vid.png'))),
                  //child: Image.asset('assets/images/vid.png')
                ),
                SizedBox(
                  height: 8,
                ),
                InkWell(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ContactUs(),
                    ),
                  ),
                  child: Text(
                    'Having some queries? Contact Us',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        letterSpacing: 1,
                        decoration: TextDecoration.underline,
                        decorationThickness: 0.3,
                        color: Theme.of(context)
                            .bottomNavigationBarTheme
                            .backgroundColor),
                  ),
                )

                /*Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: MaterialButton(
                    onPressed: () {},
                    color: Color(0xff3a57e8),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26.0),
                    ),
                    padding: EdgeInsets.all(1),
                    child: Text(
                      "ADD FIRST PRODUCT",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    textColor: Color(0xffffffff),
                    height: 5,
                    minWidth: MediaQuery.of(context).size.width * 0.6,
                  ),
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
