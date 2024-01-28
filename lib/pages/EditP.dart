import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:homescreen/Components/text_box.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:homescreen/main.dart';

class EditP extends StatefulWidget {
  const EditP({Key? key}) : super(key: key);

  @override
  State<EditP> createState() => EditPPageState();
}

class EditPPageState extends State<EditP> {
  final userCollection = FirebaseFirestore.instance.collection("Users");
  final picker = ImagePicker();
  File? _image;

  Future<void> editField(String field) async {
    String newValue = "";

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        //surfaceTintColor: Colors.amber,
        //contentTextStyle: TextStyle(color: Colors.amber),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        icon: Icon(CupertinoIcons.pencil_ellipsis_rectangle,
            color: Theme.of(context).bottomNavigationBarTheme.backgroundColor),
        elevation: 15,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          "Edit $field",
          style: TextStyle(
              letterSpacing: 1,
              fontFamily: 'Montserrat',
              color:
                  Theme.of(context).bottomNavigationBarTheme.backgroundColor),
        ),
        content: TextField(
          autofocus: true,
          style: TextStyle(
              letterSpacing: 1,
              fontFamily: 'Barlow',
              color:
                  Theme.of(context).bottomNavigationBarTheme.backgroundColor),
          decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context)
                        .bottomNavigationBarTheme
                        .backgroundColor!), // Change focused line color
              ),
              hintText: "Enter new $field",
              hintStyle: TextStyle(
                  color: Theme.of(context)
                      .bottomNavigationBarTheme
                      .backgroundColor)),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    fontFamily: 'Montserrat',
                    color: Theme.of(context)
                        .bottomNavigationBarTheme
                        .backgroundColor),
              )),
          TextButton(
              onPressed: () => Navigator.of(context).pop(newValue),
              child: Text(
                'Save',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    fontFamily: 'Montserrat',
                    color: Theme.of(context)
                        .bottomNavigationBarTheme
                        .backgroundColor),
              ))
        ],
      ),
    );

    if (newValue.trim().length > 0) {
      await userCollection.doc(currentUser!.email).update({field: newValue});
    }
  }

  Future<void> _getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        // Save the image path in Firestore
        userCollection
            .doc(currentUser!.email)
            .update({'profilePicture': pickedFile.path});
      });
    }
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? get currentUser => _firebaseAuth.currentUser;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        // Navigate back to the home screen when the back button is pressed
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => MyHomePage(),
          ),
        );
        return true;
      },
      child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          /*appBar: AppBar(
            title: const Text("Edit Profile Page"),
            backgroundColor: Colors.grey[900],
          ),*/
          body: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("Users")
                  .doc(currentUser!.email)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final userData =
                      snapshot.data!.data() as Map<String, dynamic>;

                  return ListView(
                    children: [
                      Row(
                        children: [
                          TextButton(
                            onPressed: () =>
                                Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => MyHomePage(),
                              ),
                            ),
                            child: Align(
                              alignment: AlignmentDirectional.topStart,
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
                                child: Center(
                                    child: Icon(
                                  CupertinoIcons.back,
                                  color: Theme.of(context)
                                      .bottomNavigationBarTheme
                                      .backgroundColor,
                                )),
                              ),
                            ),
                          ),
                          Text('')
                        ],
                      ),
                      SizedBox(
                        height: 150,
                        width: 1150,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Display the selected image or a placeholder if none
                            SizedBox(
                              height: 150,
                              width: 1150,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  // Display the selected image or a placeholder if none
                                  CircleAvatar(
                                    radius: 80,
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
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                      ),
                      //const Icon(Icons.person_2, size: 72),

                      Padding(padding: EdgeInsets.all(0)),
                      Center(
                          child: Text(
                        userData['username'],
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1),
                      )),
                      Padding(padding: EdgeInsets.all(05)),

                      Row(
                        children: [
                          SizedBox(
                            width: 115,
                          ),
                          ElevatedButton.icon(
                            onPressed: () => _getImageFromGallery(),
                            icon: const Icon(
                              Icons.camera_alt,
                              size: 17,
                            ),
                            label: const Text(
                              'Change Profile Picture',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold),
                            ),
                            style: ElevatedButton.styleFrom(
                              elevation: 5,
                              //primary: Color(0xFF003265),
                              onPrimary: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              padding: EdgeInsets.all(9),
                            ),
                          ),
                          /*ElevatedButton(
                            onPressed: _getImageFromGallery,
                            child: Text('Add Profile Picture'),
                          ),*/
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0, top: 10),
                        child: Text(
                          'My Details',
                          style:
                              TextStyle(fontFamily: 'Montserrat', fontSize: 17),
                        ),
                      ),
                      MyTextBox(
                        text: userData['username'],
                        sectionName: 'Username',
                        onPressed: () => editField('username'),
                      ),
                      MyTextBox(
                        text: userData['PhoneNumber'],
                        sectionName: 'Phone Number',
                        onPressed: () => editField('PhoneNumber'),
                      ),
                      MyTextBox(
                        text: userData['Age'],
                        sectionName: 'Age',
                        onPressed: () => editField('Age'),
                      ),
                      MyTextBox(
                        text: userData['Address'],
                        sectionName: 'Address',
                        onPressed: () => editField('Address'),
                      ),

                      /* SizedBox(
                        height: 150,
                        width: 1150,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Display the selected image or a placeholder if none
                            CircleAvatar(
                              radius: 70,
                              backgroundColor: Colors.transparent,
                              backgroundImage: _image != null
                                  ? FileImage(
                                      _image!) // Display the selected image
                                  : (userData['profilePicture'] != null
                                      ? AssetImage(userData['profilePicture'])
                                          as ImageProvider<Object>
                                      : AssetImage('assets/images/default.png')
                                          as ImageProvider<Object>),
                            )
                          ],
                        ),
                      ),*/

                      // Display the saved profile picture
                    ],
                  );
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Error'));
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              })),
    );
  }
}
