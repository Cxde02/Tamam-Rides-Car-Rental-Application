// ignore_for_file: unused_field

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();

  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class _EditProfilePageState extends State<EditProfilePage> {
// A variable to store the selected image
  XFile? _image;

  late String _text;

  // A function to pick an image from the camera or gallery
  Future<void> _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      setState(() {
        _image = image;
      });
    } catch (e) {
      print(e);
    }
  }

  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _phoneNumber;
  late String _email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xFF2E8970),
      /*appBar: AppBar(
        elevation: 0,
        title: Text(
          'Edit Profile',
          style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
              fontSize: 22,
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
        centerTitle: true,
        backgroundColor: Color(0xFF003265),
      ),*/
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(0, 50, 0, 13),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                margin: const EdgeInsets.fromLTRB(16, 0, 0, 15),
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
                                  child: Icon(CupertinoIcons.back),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(70, 0, 0, 15),
                          child: Text(
                            "My Profile",
                            //textAlign: TextAlign.end,
                            overflow: TextOverflow.clip,
                            style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 30,
                                color: Color(0xffffffff),
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
                      ],
                    ),
                    Center(
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black
                                      .withOpacity(0.8), // Shadow color
                                  spreadRadius: 1, // Spread radius
                                  blurRadius: 5, // Blur radius
                                  offset: Offset(
                                      0, 2), // Offset in the x and y directions
                                ),
                              ],
                            ),
                            child: CircleAvatar(
                              radius: 70,
                              backgroundImage: _image != null
                                  ? FileImage(File(_image!.path))
                                  : AssetImage('assets/images/default.png')
                                      as ImageProvider,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 14, 0, 0),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Customer's Name",
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 22,
                                  color: Color(0xffffffff),
                                ),
                              ),
                            ),
                          ),
                          Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 2)),
                          ElevatedButton.icon(
                            onPressed: () => _pickImage(ImageSource.gallery),
                            icon: Icon(Icons.camera_alt),
                            label: Text(
                              'Change Profile Picture',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold),
                            ),
                            style: ElevatedButton.styleFrom(
                              elevation: 5,
                              //primary: Color(0xFF003265),
                              onPrimary: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              padding: EdgeInsets.all(15),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                //margin: EdgeInsets.all(0),
                //padding: EdgeInsets.all(0),

                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.45,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 4), // horizontal, vertical offset
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(70),
                    bottomRight: Radius.circular(70),
                  ),
                  color: Theme.of(context)
                      .bottomNavigationBarTheme
                      .backgroundColor,
                  /*gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.cyan,
                      Colors.white,
                    ],
                  ),*/
                  shape: BoxShape.rectangle,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(12, 20, 0, 0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Account Info",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.clip,
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        fontSize: 22,
                        //color: Colors.white,
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
                ),
              ),
              /*Padding(
                padding: EdgeInsets.fromLTRB(12, 10, 0, 0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Surname",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),*/
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 8, 10, 3),
                    child: TextField(
                      keyboardType: TextInputType.name,
                      maxLines: 1,
                      onChanged: (value) {
                        setState(() {
                          _text = value;
                        });
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(
                                color: Color(0xFF003265), width: 1.5)),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Color(0xFF003265),
                        ),
                        hintText: 'Name',
                        hintStyle: TextStyle(color: Color(0xFF003265)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 8, 10, 3),
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      maxLines: 1,
                      onChanged: (value) {
                        setState(() {
                          _text = value;
                        });
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(
                                color: Color(0xFF003265), width: 1.5)),
                        prefixIcon: Icon(
                          Icons.phone,
                          color: Color(0xFF003265),
                        ),
                        hintText: 'Phone Number',
                        hintStyle: TextStyle(color: Color(0xFF003265)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 8, 10, 3),
                    child: TextField(
                      keyboardType: TextInputType.streetAddress,
                      maxLines: 1,
                      onChanged: (value) {
                        setState(() {
                          _text = value;
                        });
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(
                                color: Color(0xFF003265), width: 1.5)),
                        prefixIcon: Icon(
                          Icons.location_on,
                          color: Color(0xFF003265),
                        ),
                        hintText: 'Address',
                        hintStyle: TextStyle(color: Color(0xFF003265)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 8, 10, 3),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      maxLines: 1,
                      onChanged: (value) {
                        setState(() {
                          _text = value;
                        });
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(
                                color: Color(0xFF003265), width: 1.5)),
                        prefixIcon: Icon(
                          Icons.pin,
                          color: Color(0xFF003265),
                        ),
                        hintText: 'Age',
                        hintStyle: TextStyle(color: Color(0xFF003265)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 8, 10, 3),
                    child: TextField(
                      obscureText: true,
                      maxLines: 1,
                      onChanged: (value) {
                        setState(() {
                          _text = value;
                        });
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(
                                color: Color(0xFF003265), width: 1.5)),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Color(0xFF003265),
                        ),
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Color(0xFF003265)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                ],
              )

              /*Padding(
                padding: EdgeInsets.fromLTRB(12, 10, 0, 0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Phone Number",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
                child: TextField(
                  keyboardType: TextInputType.phone,
                  maxLines: null,
                  onChanged: (value) {
                    setState(() {
                      _text = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter your Phone Number...',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),*/
            ],
          ),
          /*child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Enter your name',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _name = value!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Enter your phone number',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _phoneNumber = value!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Enter your email address',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email address';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _email = value!;
                  },
                ),
                SizedBox(height: 16.0),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        // Save the data to the server or database
                        // Navigate back to the profile page
                        Navigator.pop(context);
                      }
                    },
                    child: Text('Save'),
                  ),
                ),
              ],
            ),
          ),*/
        ),
      ),
    );
  }
}
