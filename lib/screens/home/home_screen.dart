import 'package:ecoclub/screens/home/tabs/flash_cards.dart';
import 'package:ecoclub/screens/home/tabs/new_post.dart';
import 'package:ecoclub/screens/home/tabs/vision_camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ecoclub/screens/home/tabs/sms_detect.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ecoclub/screens/home/tabs/news_feed.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  Widget returnCurrentScreen(int index) {
    if (currentIndex == 0) {
      return NewsFeed();
    } else if (currentIndex == 1) {
      return VisionCamera();
    } else if (currentIndex == 2) {
      return SmsDetect();
    }
    return FlashCards();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: currentIndex == 0 ? FloatingActionButton(
        backgroundColor: Color(0xFF13552C),
        child: Center(
          child: Icon(
            Icons.add,
            size: 30,
            color: Colors.white,
          ),
        ),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => NewPost()));
        },
      ):  null,
      appBar: AppBar(
        backgroundColor: Color(0xFF13552C),
        title: Text(
          "Eco.Club",
          style: GoogleFonts.poppins(
            color: Color(0xFFE6EEE7),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: (){
              FirebaseAuth.instance.signOut();
            },
            child: Icon(
              Icons.logout,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: returnCurrentScreen(currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        currentIndex: currentIndex,
        unselectedItemColor: Colors.black,
        selectedItemColor: Color(0xFF13552C),
        backgroundColor: Color(0xFF41CD8C),
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.groups,
            ),
            label: "Feed",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.camera,
            ),
            label: "Lens",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_balance_wallet,
            ),
            label: "Pay",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.style,
            ),
            label: "Bits",
          ),
        ],
      ),
    );
  }
}
