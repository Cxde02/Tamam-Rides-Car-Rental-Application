import 'package:homescreen/pages/widget_tree.dart';
//import 'package:loginandsignup/Pages/profilepage.dart';
import 'auth.dart';
import 'package:flutter/material.dart';
import 'loginorsignup.dart';

class WidgetTree2 extends StatefulWidget {
  const WidgetTree2({Key? key}) : super(key: key);

  @override
  State<WidgetTree2> createState() => _WidgetTree2State();
}

class _WidgetTree2State extends State<WidgetTree2> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return /*const ProfilePage()*/ LoginorSignUpPage();
        } else {
          return Builder(builder: (context) {
            return WidgetTree();
          });
        }
      },
    );
  }
}
