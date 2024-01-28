import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homescreen/main.dart';
import 'package:lottie/lottie.dart';
import 'auth.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
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
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MyHomePage()));
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

      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MyHomePage()));

      FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.email)
          .set({
        'username': _controllerEmail.text.split('@')[0],
        'PhoneNumber': '',
        'Age': '',
        'Address': '',
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
    return Text(errorMessage == '' ? '' : '$errorMessage');
  }

  Widget _submitButton() {
    return TextButton(
        onPressed: isLogin
            ? createUserWithEmailAndPassword
            : signInWithEmailAndPassword,
        child: Container(
          height: 50,
          width: 150,
          //padding: const EdgeInsets.all(25),
          margin: const EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
              color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
              borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: Text(isLogin ? 'Register' : 'Login',
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
            ? 'Already a member?' '' 'Login Here'
            : 'Not a member?' ' ' 'Register here',
        style: TextStyle(
            fontFamily: 'Montserrat',
            color: Theme.of(context).bottomNavigationBarTheme.backgroundColor),
      ),
    );
  }

  Widget _text() {
    return Text(
      isLogin ? 'REGISTER A NEW ACCOUNT' : 'LOGIN TO YOUR ACCOUNT',
      style:
          TextStyle(fontFamily: 'Montserrat', letterSpacing: 1, fontSize: 21),
    );
  }

  Widget _lottie() {
    return Lottie.asset(
      isLogin
          ? "assets/images/77323-profile-lock.json"
          : "assets/images/76732-locked-icon.json",
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      fit: BoxFit.cover,
      repeat: true,
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
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
  }
}
