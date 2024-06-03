// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:google_fonts/google_fonts.dart';

class UIText {
  final labelMasuk = "Masuk".obs;

  final labelDaftar = "Daftar".obs;

  final labelTagline =
      "Mulai konsulatasi masalah kesehatan anda bersama kami".obs;

  final username = "Username".obs;

  final password = "Password".obs;

  final repassword = "Konfirmasi Password".obs;

  final descMendaftar = "Mendaftar untuk memulai konsultasi".obs;

  final namaLengkap = "Nama Lengkap".obs;

  final email = "Email".obs;

  final phoneNumber = "Nomor Telephone".obs;

  final clientID = "2";

  final clientSecret = "7NPO7Il1oqX7whp9SN3pa30zZzfO7k9AtfHbkPhQ";

  final pass = "Password";

  final level = "3";

  final source = "VM";

  final bannerHighlight = "Info Terkini".obs;

  final news = "Berita Terbaru".obs;

  final seeAll = "Lihat Semua".obs;
}

class UIImage {
  final imageUrl = "assets/images/logo.png".obs;
  final dummyUserUrl = "assets/images/dummy_user.png".obs;
}

class UIColor {
  UIColor._();
  static const Color primary = Color(0xffC52F8E);
  static const Color primarySoft = Color(0xffF8D2E3);

  static const Color mateWhite = Color(0xFFF2F2F2);

  static const Color cDark50 = Color(0xFF6B6B6B);
  static const Color cDark70 = Color(0xFF3A3A3A);
  static const Color cDark80 = Color(0xFF202020);

  static const Color cGrey = Color(0xFFF0F0F0);
  static const Color cGrey50 = Color(0xFF6B6B6B);
  static const Color cGreyBase = Color(0xfff5f5f7);
  static const Color placeImageHolder = Color(0xFF686868);

  static const Color cMessageTheme = Color(0xffD2D3E3);
  static const Color countdown = Color(0xffF04933);
  static const Color placeHolder = Color(0xFFBBBBBB);
}

class Txt extends StatelessWidget {
  final String? text;
  final TextStyle? textStyle;

  const Txt(
    this.text,
    this.textStyle,
  );

  @override
  Widget build(BuildContext context) {
    return Text(
      "$text",
      style: GoogleFonts.sourceSansPro(
        textStyle: textStyle,
      ),
    );
  }
}
