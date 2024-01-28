import 'package:flutter/material.dart';
import 'package:homescreen/pages/SearchPage.dart';

class LeftPageRoute extends PageRouteBuilder {
  final Widget enterPage;

  LeftPageRoute({
    required this.enterPage,
    required MyHomePage1 Function(BuildContext context) builder,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => enterPage,
          transitionDuration: Duration(milliseconds: 700),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            Offset begin = Offset(-1.0, 0.0);
            Offset end = Offset.zero;
            Curve curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
}
