import 'package:flutter/material.dart';
import 'package:homescreen/main.dart';
import 'package:homescreen/pages/loginorsignup.dart';
import 'package:lottie/lottie.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Align(
              alignment: Alignment(0, 0.13),
              child: Container(
                height: 170,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    scale: 1.4,
                    opacity: 0.1,
                    image: AssetImage('assets/images/S2.png'),
                    //fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
          //PushReplacement so that it doesn't return to previous screen
          GestureDetector(
            onTap: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => MyHomePage())),
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 55, right: 25),
                child: Text(
                  'SKIP',
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      color: Theme.of(context)
                          .bottomNavigationBarTheme
                          .backgroundColor),
                ),
              ),
            ),
          ),
          Stack(
            children: [
              Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 150, left: 25, right: 25),
                      child: Text(
                        'Rev Up Your Search For The Perfect Car',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Ailerons',
                            fontSize: 25,
                            letterSpacing: -2,
                            color: Colors.black.withOpacity(1)),
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment(0, -0.34),
                child: Container(
                  height: 150,
                  width: 350,
                  //decoration: BoxDecoration(color: Colors.amber),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(55, 15, 55, 15),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(
                              5, 8, 5, 8), // Adjust padding as needed
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .bottomNavigationBarTheme
                                .backgroundColor!
                                .withOpacity(0.1), // Background color
                            borderRadius: BorderRadius.circular(
                                8), // Adjust the radius as needed
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: RichText(
                              textAlign: TextAlign.left,
                              text: TextSpan(
                                text: '✔ Premium Selection',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(
                              5, 8, 5, 8), // Adjust padding as needed
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .bottomNavigationBarTheme
                                .backgroundColor!
                                .withOpacity(0.1), // Background color
                            borderRadius: BorderRadius.circular(
                                8), // Adjust the radius as needed
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: RichText(
                              textAlign: TextAlign.justify,
                              text: TextSpan(
                                text: '✔ Secure Transactions',
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(
                              5, 8, 5, 8), // Adjust padding as needed
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .bottomNavigationBarTheme
                                .backgroundColor!
                                .withOpacity(0.1), // Background color
                            borderRadius: BorderRadius.circular(
                                8), // Adjust the radius as needed
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: RichText(
                              textAlign: TextAlign.justify,
                              text: TextSpan(
                                text: '✔ Open Communication',
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.black),
                              ),
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

          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              height: 250,
              width: 419,
              child: Lottie.asset(
                "assets/images/93387-car-insurance-offers-loading-page.json",
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.fitWidth,
                repeat: true,
                animate: true,
              ),
            ),
          ),
          /*Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: InkWell(
                onTap: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignUpPage())),
                child: Container(
                  width: 150,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Theme.of(context)
                          .bottomNavigationBarTheme
                          .backgroundColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                      child: Text(
                    'Register',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        letterSpacing: 1,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  )),
                ),
              ),
            ),
          ),*/
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: InkWell(
                onTap: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) => LoginorSignUpPage())),
                child: Container(
                  width: 180,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Theme.of(context)
                          .bottomNavigationBarTheme
                          .backgroundColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                      child: Text(
                    'Let\'s Go ➜',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
