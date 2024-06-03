import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import 'ui_data.dart';

class DialogHelper {
  static void showErrorDialog(
      {String? title = 'Sorry', String? description = 'Something went wrong'}) {
    Get.snackbar(title ?? "", description ?? "",
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.white,
        colorText: UIColor.cDark70,
        boxShadows: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 12,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ]);
  }

  static void showLoading(String message) {
    Get.defaultDialog(
      title: "",
      barrierDismissible: false,
      backgroundColor: Colors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
              height: 18.h,
              width: 18.h,
              child: Lottie.asset('assets/loader.json')),
          Padding(
            padding: EdgeInsets.only(bottom: 2.h),
            child: Txt(
              message,
              TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }

  static void hideLoading() {
    if (Get.isDialogOpen!) Get.back();
  }
}
