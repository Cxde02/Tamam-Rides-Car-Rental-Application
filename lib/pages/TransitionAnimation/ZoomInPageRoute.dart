import 'package:flutter/material.dart';
import 'package:homescreen/pages/EditProfilePage.dart';

class ZoomInPageRoute extends PageRouteBuilder {
  final Widget enterPage;

  ZoomInPageRoute(
      {required this.enterPage,
      required EditProfilePage Function(dynamic context) builder})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => enterPage,
          transitionDuration: Duration(milliseconds: 550),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final begin = 0.0;
            final end = 1.0;
            final curve = Curves.ease;

            final tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return ScaleTransition(
              scale: animation.drive(tween),
              child: child,
            );
          },
        );
}
