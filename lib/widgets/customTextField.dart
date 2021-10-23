import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    required this.myController,
    required this.hint,
    this.maxLines,
  });

  final TextEditingController myController;
  final String hint;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      controller: myController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$hint cannot be blank.';
        }
        return null;
      },
      style: GoogleFonts.poppins(
        textStyle: TextStyle(
          color: Color(0xFF13552C),
          decoration: TextDecoration.none,
        ),
      ),
      cursorColor: Color(0xFF13552C),
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xFFE6EEE7),
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
          BorderSide(color: Color(0xFF13552C),),
          borderRadius: BorderRadius.circular(12.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
          BorderSide(color: Color(0xFF13552C), width: 2.0),
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }
}