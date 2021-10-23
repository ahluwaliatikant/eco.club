import 'package:ecoclub/screens/auth/login_screen.dart';
import 'package:ecoclub/screens/home/home_screen.dart';
import 'package:ecoclub/screens/state_wrapper_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: Color(0xFF13552C),
            ledColor: Colors.white
        )
      ]
  );

  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StateWrapperScreen(),
    );
  }
}

