import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AnalyzeImage extends StatefulWidget {

  String basicText;
  String visitText;
  String url;
  String label;

  AnalyzeImage({
    required this.basicText,
    required this.visitText,
    required this.url,
    required this.label,
  });

  @override
  _AnalyzeImageState createState() => _AnalyzeImageState();
}

class _AnalyzeImageState extends State<AnalyzeImage> {
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFFE6EEE7),
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
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Interpreted Label:",
                  style: GoogleFonts.poppins(
                    color: Color(0xFF13552C),
                    fontSize: 18
                  )
                ),
                Text(
                    "Jeans",
                    style: GoogleFonts.poppins(
                      color: Color(0xFF13552C),
                      fontSize: 18
                    ),
                ),
              ],
            ),
            SvgPicture.asset(
              "assets/images/hand_tree.svg",
              width: width*0.6,
            ),
            Container(
              width: width*0.9,
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: Colors.transparent,
              ),
              child: SingleChildScrollView(
                child: Text(
                  widget.basicText,
                  style: GoogleFonts.poppins(
                    color: Color(0xFF13552C),
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () async{
                await launch(widget.url);
              },
              child: Container(
                width: width*0.78,
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: Color(0xFF13552C),
                ),
                child: SingleChildScrollView(
                  child: Row(
                    children: [
                      Container(
                        width: width*0.6,
                        child: Text(
                          widget.visitText,
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: Color(0xFFE6EEE7),
                        size: 30,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
