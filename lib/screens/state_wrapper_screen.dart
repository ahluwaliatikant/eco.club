import 'package:ecoclub/screens/auth/login_screen.dart';
import 'package:ecoclub/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StateWrapperScreen extends StatefulWidget {
  const StateWrapperScreen({Key? key}) : super(key: key);

  @override
  _StateWrapperScreenState createState() => _StateWrapperScreenState();
}

class _StateWrapperScreenState extends State<StateWrapperScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            print("MY SNAPSHOT DATA");
            print(snapshot.data);
            print(FirebaseAuth.instance.currentUser!.email);
            print(FirebaseAuth.instance.currentUser!.displayName);

            return HomeScreen();
          }
          return LoginScreen();
        });
  }
}
