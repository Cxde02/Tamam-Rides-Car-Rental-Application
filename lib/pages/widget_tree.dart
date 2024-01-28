import 'package:homescreen/main.dart';

//import 'package:loginandsignup/Pages/profilepage.dart';
import 'auth.dart';
import 'package:flutter/material.dart';
import 'loginorsignup.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return /*const ProfilePage()*/ MyHomePage();
        } else {
          return Builder(builder: (context) {
            return const LoginorSignUpPage();
          });
        }
      },
    );
  }
}
