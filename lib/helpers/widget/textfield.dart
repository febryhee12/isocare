// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../ui_data.dart';

// ignore: must_be_immutable
class InputTextField extends StatelessWidget {
  InputTextField({
    this.controller,
    this.focusNode,
    this.borderColor,
    this.hintText,
    this.helpText,
    this.autofocus,
    this.enabled,
    this.readOnly,
    this.obscureText,
    this.suffixIcon,
    this.keyboardType,
    this.inputFormatters,
    this.onSaved,
    this.onChanged,
    this.changeShowPassword,
    this.validator,
    this.maxline,
  });

  // final String? label;
  TextEditingController? controller;
  bool? obscureText;
  Function()? changeShowPassword;
  FocusNode? focusNode;
  String? hintText;
  String? helpText;
  bool? autofocus;
  bool? enabled;
  bool? readOnly;
  Color? borderColor;
  Widget? suffixIcon;
  String? Function(String?)? onSaved;
  TextInputType? keyboardType;
  List<TextInputFormatter>? inputFormatters;
  ValueChanged<String>? onChanged;
  String? Function(String?)? validator;
  int? maxline;

  @override
  Widget build(BuildContext context) {
    return
        // Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Padding(
        //   padding: EdgeInsets.only(bottom: 2.h),
        //   child: Text(
        //     label!,
        //     style: TextStyle(
        //         fontSize: 10.sp,
        //         fontWeight: FontWeight.w400,
        //         color: UIColor.cDark80),
        //   ),
        // ),
        TextFormField(
      onChanged: onChanged,
      controller: controller,
      onSaved: onSaved,
      focusNode: focusNode,
      validator: validator,
      obscureText: obscureText!,
      readOnly: null == readOnly ? false : true,
      autofocus: null == autofocus ? false : true,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      maxLines: maxline ?? 1,
      decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: UIColor.mateWhite,
          labelStyle: GoogleFonts.sourceSansPro(
            textStyle: TextStyle(fontSize: 15.sp),
          ),
          contentPadding:
              EdgeInsets.symmetric(vertical: 2.25.h, horizontal: 2.0.h),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.circular(5.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(5.0),
          ),
          hintText: hintText ?? '',
          helperText: helpText ?? '',
          suffixIcon: suffixIcon,
          enabled: null == enabled ? true : false),
    );
    // ]
    // );
  }
}
