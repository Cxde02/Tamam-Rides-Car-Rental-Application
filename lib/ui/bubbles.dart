import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:homescreen/main.dart';

class DashBubble extends StatelessWidget {
  const DashBubble({Key? key, required this.message}) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    Widget textBubble = Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
        child: BubbleNormal(
          textStyle: TextStyle(
              color: Colors.black, fontFamily: 'Barlow', fontSize: 16),
          text: message,
          isSender: false,
          color: Color.fromARGB(255, 255, 255, 255),
          tail: true,
        ),
      ),
    );

    Widget text = Row(children: [
      CircleAvatar(
        radius: 20, // Adjust the radius according to your preference
        backgroundImage:
            AssetImage('assets/images/Screenshot 2023-05-31 210931.png'),
      ),
      textBubble,
    ]);

    return text;
  }
}

// ignore: must_be_immutable
class UserBubble extends StatelessWidget {
  UserBubble({Key? key, required this.message, required this.userImage})
      : super(key: key);

  final String message;
  final String userImage;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final userCollection = FirebaseFirestore.instance.collection("Users");
  User? get currentUser => _firebaseAuth.currentUser;

  File? _image;

  @override
  Widget build(BuildContext context) {
    Widget textBubble = Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
        child: BubbleNormal(
          textStyle: TextStyle(
              color: Colors.white, fontFamily: 'Barlow', fontSize: 16),
          //seen: true,
          text: message,
          isSender: true,
          color: Theme.of(context).bottomNavigationBarTheme.backgroundColor!,
          tail: true,
        ),
      ),
    );

    Widget text = StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection("Users")
          .doc(currentUser?.email)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.exists) {
          final userData = snapshot.data?.data() as Map<String, dynamic>;

          return Row(
            children: [
              textBubble, // Assuming you have defined textBubble somewhere
              SizedBox(
                width: 50,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Theme.of(context)
                        .bottomNavigationBarTheme
                        .backgroundColor,
                    backgroundImage: _image != null
                        ? FileImage(_image!) // Display the selected image
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
              ),
            ],
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading indicator while waiting for data
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          // If snapshot doesn't exist, show a dialog
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 20,
                shadowColor:
                    Theme.of(context).bottomNavigationBarTheme.backgroundColor,
                title: Row(
                  children: [
                    Icon(
                      CupertinoIcons.exclamationmark_triangle_fill,
                      color: Colors.redAccent, // Customize the icon color
                    ),
                    SizedBox(
                        width: 8), // Add some spacing between icon and text
                    Text(
                      "Login Needed",
                      style: TextStyle(fontFamily: 'Montserrat'),
                    ),
                  ],
                ),
                content: Text("You need to log in to continue.",
                    style: TextStyle(fontFamily: 'Barlow')),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MyHomePage(), // Replace MyHomePage with the actual home screen widget
                        ),
                      );
                    },
                    child: Text("OK"),
                  ),
                ],
              ),
            );
          });

          return const Center(child: Text(''));
        }
      },
    );

    return text;
  }
}
