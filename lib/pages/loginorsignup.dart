import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homescreen/main.dart';
import 'package:homescreen/pages/WelcomeScreen.dart';
import 'package:lottie/lottie.dart';
import 'auth.dart';

class LoginorSignUpPage extends StatefulWidget {
  const LoginorSignUpPage({Key? key}) : super(key: key);

  @override
  State<LoginorSignUpPage> createState() => LoginorSignUpPageState();
}

class LoginorSignUpPageState extends State<LoginorSignUpPage> {
  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: Lottie.asset('assets/images/loading_1.json',
                width: 100,
                height: 100), // You can use any loading indicator widget
          ); // Show loading animation dialog
        },
      );
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pop(context);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => MyHomePage()));
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _controllerEmail.text, password: _controllerPassword.text);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: Lottie.asset('assets/images/loading_1.json',
                width: 100,
                height: 100), // You can use any loading indicator widget
          ); // Show loading animation dialog
        },
      );
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pop(context);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => MyHomePage()));
      });

      FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.email)
          .set({
        'username': _controllerEmail.text.split('@')[0],
        'PhoneNumber': '',
        'Age': '',
        'Address': '',
        'profilePicture': 'assets/images/default.png',
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  // ignore: non_constant_identifier_names
  Widget _EmailField(
    String title,
    TextEditingController controller,
  ) {
    return TextField(
      style: TextStyle(
        fontFamily: 'Barlow',
        fontSize: 17,
        letterSpacing: 0.5,
        fontWeight: FontWeight.w500,
        color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      ),
      cursorColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      keyboardType: TextInputType.emailAddress,
      controller: _controllerEmail,
      obscureText: false,
      decoration: InputDecoration(
        labelText: title,
        labelStyle: TextStyle(fontFamily: 'Montserrat', letterSpacing: 0.6),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Color(0xFF4D9400)),
        ),
        floatingLabelStyle: TextStyle(
            fontFamily: 'Montserrat',
            letterSpacing: 0.6,
            color: Theme.of(context).bottomNavigationBarTheme.backgroundColor),
        suffixIcon: Icon(
          Icons.email,
          color: Theme.of(context)
              .bottomNavigationBarTheme
              .backgroundColor!
              .withOpacity(0.5),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget _PasswordField(
    String title,
    TextEditingController controller,
  ) {
    return TextField(
      style: TextStyle(
        fontSize: 17,
        fontFamily: 'Barlow',
        letterSpacing: 0.5,
        fontWeight: FontWeight.w500,
        color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      ),
      cursorColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      controller: _controllerPassword,
      obscureText: true,
      //obscuringCharacter: '*',
      decoration: InputDecoration(
        labelText: title,
        labelStyle: TextStyle(fontFamily: 'Montserrat', letterSpacing: 0.6),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Color(0xFF4D9400)),
        ),
        floatingLabelStyle: TextStyle(
            fontFamily: 'Montserrat',
            letterSpacing: 0.6,
            color: Theme.of(context).bottomNavigationBarTheme.backgroundColor),
        suffixIcon: Icon(
          Icons.lock,
          color: Theme.of(context)
              .bottomNavigationBarTheme
              .backgroundColor!
              .withOpacity(0.5),
        ),
      ),
    );
  }

  Widget _errorMessage() {
    return Text(
      errorMessage == '' ? '' : '$errorMessage',
      style: TextStyle(fontFamily: 'Montserrat'),
    );
  }

  Widget _submitButton() {
    return TextButton(
        onPressed: isLogin
            ? signInWithEmailAndPassword
            : createUserWithEmailAndPassword,
        child: Container(
          height: 50,
          width: 150,
          //padding: const EdgeInsets.all(25),
          margin: const EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
              color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
              borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: Text(isLogin ? 'Login' : 'Register',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Montserrat',
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.bold,
                    fontSize: 16)),
          ),
        ));
  }

  Widget _loginOrRegisterButton() {
    return TextButton(
      onPressed: () {
        setState(() {
          isLogin = !isLogin;
        });
      },
      child: Text(
        isLogin
            ? 'Not a member?' ' ' ' Register here'
            : 'Already a member?' '' ' Login Here',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
            color: Theme.of(context).bottomNavigationBarTheme.backgroundColor),
      ),
    );
  }

  Widget _text() {
    return Text(
      isLogin ? 'LOGIN TO YOUR ACCOUNT' : 'REGISTER A NEW ACCOUNT',
      style:
          TextStyle(fontFamily: 'Montserrat', letterSpacing: 1, fontSize: 21),
    );
  }

  Widget _lottie() {
    return Lottie.asset(
      isLogin
          ? "assets/images/76732-locked-icon.json"
          : "assets/images/77323-profile-lock.json",
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      fit: BoxFit.cover,
      repeat: true,
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: null,
        builder: (context, snapshot) {
          return WillPopScope(
            onWillPop: () async {
              // Navigate back to the home screen when the back button is pressed
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => WelcomeScreen(),
                ),
              );
              return true;
            },
            child: Scaffold(
              body: SingleChildScrollView(
                child: Container(
                  //height: double.infinity,
                  //width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 70),
                      _text(),
                      const SizedBox(height: 30),
                      Container(
                        height: 220,
                        width: 220,
                        child: _lottie(),
                      ),
                      const SizedBox(height: 30),
                      _EmailField('Email', _controllerEmail),
                      SizedBox(
                        height: 15,
                      ),
                      _PasswordField('Password', _controllerPassword),
                      const SizedBox(height: 25),
                      _errorMessage(),
                      const SizedBox(height: 10),
                      _submitButton(),
                      const SizedBox(height: 50),
                      _loginOrRegisterButton(),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
