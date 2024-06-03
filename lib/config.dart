import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF009688);
const kSoftColor = Color(0xFF00C9B1);
const kBackgroundColor = Color(0xFFFFFFFF);
const kErrorColor = Color(0xFFFE5350);
const kWarningColor = Color(0xFFFFC107);
const kInfoColor = Color(0xFF7986CB);

class Config {
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static Orientation? orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
    orientation = _mediaQueryData!.orientation;
  }
}
