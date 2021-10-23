import 'package:ecoclub/models/user_model.dart' as userModel;
import 'package:ecoclub/services/google_auth.dart';
import 'package:ecoclub/services/user_service.dart';
import 'package:ecoclub/widgets/customButton.dart';
import 'package:ecoclub/widgets/customGoogleButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/wallpaper_try.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Eco.Club",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 60,
                fontWeight: FontWeight.bold,
              ),
            ),
            SvgPicture.asset(
              "assets/images/loginScreen.svg",
              width: width*0.7,
            ),
            CustomGoogleButton(
              width: width*0.9,
              text: "Sign In With Google",
              onPressed: () {
                GoogleAuth().googleSignIn();

                var currentUser = FirebaseAuth.instance.currentUser;

                userModel.User newUser = new userModel.User(
                  name: currentUser!.displayName!,
                  profilePicUrl: currentUser.photoURL!,
                  uuid: currentUser.uid,
                );

                UserService().addUser(newUser);
              },
              color: Color(0xFFE6EEE7),
              textColor: Color(0xFF13552C),
            ),
          ],
        ),
      ),
    );
  }
}
