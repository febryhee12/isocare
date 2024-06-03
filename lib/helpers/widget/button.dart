// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonElevated extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  ButtonElevated(
      {this.minSize,
      required this.onPressed,
      required this.label,
      this.cButton,
      required this.wBorder,
      required this.cBorder,
      this.textStyle});

  final Size? minSize;
  final Function() onPressed;
  final Color? cButton;
  final String label;
  final double wBorder;
  final Color cBorder;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: minSize,
            shadowColor: Colors.transparent,
            primary: cButton ?? Colors.blue,
            side: BorderSide(
              width: wBorder,
              color: cBorder,
            )),
        onPressed: onPressed,
        child: Text(
          label,
          style: GoogleFonts.sourceSansPro(
            textStyle: textStyle,
          ),
        ),
      ),
    );
  }
}
