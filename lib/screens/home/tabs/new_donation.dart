import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';


class NewDonation extends StatelessWidget {

  String data;
  NewDonation({required this.data});

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
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.asset(
              "assets/images/tree_swing.svg",
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
                  data,
                  style: GoogleFonts.poppins(
                    color: Color(0xFF13552C),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            GestureDetector(
              onTap: () async{

              },
              child: Container(
                width: width*0.6,
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: Color(0xFF13552C),
                ),
                child: SingleChildScrollView(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Text(
                          "Make Payment",
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
