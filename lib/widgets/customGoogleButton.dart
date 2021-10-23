import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomGoogleButton extends StatelessWidget {
  CustomGoogleButton({
    required this.width,
    required this.text,
    required this.onPressed,
    required this.color,
    required this.textColor
  });

  final double width;
  final Function onPressed;
  final Color textColor;
  final String text;
  final Color color;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width * 0.8,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
        ),
        child: TextButton(
          onPressed: (){
            onPressed();
          },
          style: TextButton.styleFrom(
            //elevation: 5,
            shadowColor: Colors.black87,
            backgroundColor: color,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: EdgeInsets.symmetric(vertical: 15),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  "assets/images/google_logo.png",
                  height: 30,
                ),
                Text(
                  text,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}