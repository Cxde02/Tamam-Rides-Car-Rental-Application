import 'package:drop_shadow/drop_shadow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shimmer/shimmer.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUs createState() => _ContactUs();
}

class _ContactUs extends State<ContactUs> {
  final TextEditingController _textField1Controller = TextEditingController();
  final TextEditingController _textField2Controller = TextEditingController();
  final TextEditingController _textField3Controller = TextEditingController();

  bool _isButtonEnabled = false;

  @override
  void dispose() {
    _textField1Controller.dispose();
    _textField2Controller.dispose();
    _textField3Controller.dispose();

    super.dispose();
  }

  void _validateInput() {
    final textField1Text = _textField1Controller.text;
    final textField2Text = _textField2Controller.text;
    final textField3Text = _textField3Controller.text;

    setState(() {
      _isButtonEnabled = textField1Text.isNotEmpty &&
          textField2Text.isNotEmpty &&
          textField3Text.isNotEmpty;
    });

    if (_isButtonEnabled) {
      // Perform the desired action
      print('Button Pressed');
    } else {
      // Display an alert or prompt to fill in all fields
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please fill in all fields.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      /*appBar: AppBar(
        backgroundColor:
            Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      ),*/
      //backgroundColor: Color(0xfff3f3f3),
      body: Stack(
        alignment: Alignment.topLeft,
        children: [
          ///***If you have exported images you must have to copy those images in assets/images directory.
          Container(
            decoration: BoxDecoration(
                color:
                    Theme.of(context).bottomNavigationBarTheme.backgroundColor),
            height: MediaQuery.of(context).size.height * 0.35000000000000003,
            width: MediaQuery.of(context).size.width,
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                margin: EdgeInsets.all(0),
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                height: MediaQuery.of(context).size.height * 0.25,
                decoration: BoxDecoration(
                  color: Color(0x00ffffff),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.zero,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              height: size.width * 0.1,
                              width: size.width * 0.1,
                              margin: const EdgeInsets.fromLTRB(0, 20, 0, 18),
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
                                //child: Image.asset('assets/images/back-arrow.png'),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: DropShadow(
                                offset: Offset(0, 0),
                                blurRadius: 5,
                                child: Shimmer.fromColors(
                                  //enabled: false,
                                  baseColor: Theme.of(context)
                                      .bottomNavigationBarTheme
                                      .backgroundColor!,
                                  highlightColor: Colors.white,
                                  child: Image(
                                    image: AssetImage("assets/images/S2.png"),
                                    //height: 140,
                                    width: 80,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        /*Icon(
                          Icons.arrow_back,
                          color: Color(0xffffffff),
                          size: 24,
                        ),*/
                        Padding(
                          padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                          child: Text(
                            "Contact us",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                              fontSize: 20,
                              fontFamily: 'Montserrat',
                              letterSpacing: 1,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.fromLTRB(16, 0, 16, 70),
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.75,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        offset: Offset(2, 15),
                        blurRadius: 20,
                      ),
                    ],
                    color: Theme.of(context).scaffoldBackgroundColor,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(30.0),
                    border: Border.all(color: Color(0x4d9e9e9e), width: 1),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                          child: TextField(
                            controller: _textField1Controller,
                            textCapitalization: TextCapitalization.words,
                            //controller: TextEditingController(text: "Jon Snow"),
                            obscureText: false,
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              color: Color(0xff000000),
                            ),
                            decoration: InputDecoration(
                              disabledBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0),
                                borderSide: BorderSide(
                                    color: Color(0xff000000), width: 1),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0),
                                borderSide: BorderSide(
                                    color: Color(0xff000000), width: 1),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0),
                                borderSide: BorderSide(
                                    color: Color(0xff000000), width: 1),
                              ),
                              labelText: "Name",
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Barlow',
                                letterSpacing: 1,
                                fontStyle: FontStyle.normal,
                                fontSize: 16,
                                color: Theme.of(context)
                                    .bottomNavigationBarTheme
                                    .backgroundColor,
                              ),
                              //filled: true,
                              fillColor: Color(0xffffffff),
                              isDense: false,
                              contentPadding: EdgeInsets.all(0),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                          child: TextField(
                            controller: _textField2Controller,

                            keyboardType: TextInputType.phone,
                            //controller: TextEditingController(
                            //text: "jonsnow@gmail.com"),
                            obscureText: false,
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 16,
                              color: Color(0xff000000),
                            ),
                            decoration: InputDecoration(
                              disabledBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0),
                                borderSide: BorderSide(
                                    color: Color(0xff000000), width: 1),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0),
                                borderSide: BorderSide(
                                    color: Color(0xff000000), width: 1),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0),
                                borderSide: BorderSide(
                                    color: Color(0xff000000), width: 1),
                              ),
                              labelText: "Phone Number",
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: 'BArlow',
                                letterSpacing: 1,
                                fontStyle: FontStyle.normal,
                                fontSize: 16,
                                color: Theme.of(context)
                                    .bottomNavigationBarTheme
                                    .backgroundColor,
                              ),
                              //filled: true,
                              fillColor: Color(0xffffffff),
                              isDense: false,
                              contentPadding: EdgeInsets.all(0),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                          child: TextField(
                            controller: _textField3Controller,

                            keyboardType: TextInputType.emailAddress,
                            //controller: TextEditingController(
                            //text: "jonsnow@gmail.com"),
                            obscureText: false,
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 16,
                              color: Color(0xff000000),
                            ),
                            decoration: InputDecoration(
                              disabledBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0),
                                borderSide: BorderSide(
                                    color: Color(0xff000000), width: 1),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0),
                                borderSide: BorderSide(
                                    color: Color(0xff000000), width: 1),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0),
                                borderSide: BorderSide(
                                    color: Color(0xff000000), width: 1),
                              ),
                              labelText: "Email",
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: 'BArlow',
                                letterSpacing: 1,
                                fontStyle: FontStyle.normal,
                                fontSize: 16,
                                color: Theme.of(context)
                                    .bottomNavigationBarTheme
                                    .backgroundColor,
                              ),
                              //filled: true,
                              fillColor: Color(0xffffffff),
                              isDense: false,
                              contentPadding: EdgeInsets.all(0),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                          child: TextField(
                            controller: TextEditingController(text: " "),
                            obscureText: false,
                            textAlign: TextAlign.start,
                            maxLines: 7,
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 15,
                              color: Color(0xff000000),
                            ),
                            decoration: InputDecoration(
                              disabledBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0),
                                borderSide: BorderSide(
                                    color: Color(0xff000000), width: 1),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0),
                                borderSide: BorderSide(
                                    color: Color(0xff000000), width: 1),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0),
                                borderSide: BorderSide(
                                    color: Color(0xff000000), width: 1),
                              ),
                              labelText: "Message",
                              labelStyle: TextStyle(
                                fontFamily: 'Barlow',
                                letterSpacing: 1,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.normal,
                                fontSize: 16,
                                color: Theme.of(context)
                                    .bottomNavigationBarTheme
                                    .backgroundColor,
                              ),
                              //filled: true,
                              fillColor: Color(0xffffffff),
                              isDense: false,
                              contentPadding: EdgeInsets.all(0),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                          child: MaterialButton(
                            onPressed: () {
                              _isButtonEnabled ? _validateInput : false;
                              Fluttertoast.showToast(
                                msg: 'Message received!',
                                gravity: ToastGravity.BOTTOM,
                              );
                              Navigator.pop(context);
                            },
                            color: Theme.of(context)
                                .bottomNavigationBarTheme
                                .backgroundColor,
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            padding: EdgeInsets.all(16),
                            child: Text(
                              "SEND MESSAGE",
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Montserrat',
                                letterSpacing: 1,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                            textColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            height: 50,
                            minWidth: MediaQuery.of(context).size.width,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
