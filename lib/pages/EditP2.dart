import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  /*void goToEdit() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const EditProfilePage()));
  }*/

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: double.infinity,
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            const Icon(Icons.person, size: 100),
            const SizedBox(height: 50),
            TextButton(
                onPressed: /*goToEdit*/ null,
                child: Container(
                    height: 70,
                    width: 150,
                    padding: const EdgeInsets.all(25),
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8)),
                    child: const Text('Edit Profile',
                        style: TextStyle(color: Colors.white, fontSize: 16)))),
            const SizedBox(height: 50),
            TextButton(
                onPressed: signOut,
                child: Container(
                    height: 70,
                    width: 150,
                    padding: const EdgeInsets.all(25),
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8)),
                    child: const Text('Sign Out',
                        style: TextStyle(color: Colors.white, fontSize: 16))))
          ]),
    ));
  }
}
