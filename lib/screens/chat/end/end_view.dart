import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isocare/screens/dashboard/dashboard_view.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../../../../helpers/ui_data.dart';

class EndChatView extends StatefulWidget {
  @override
  State<EndChatView> createState() => _EndChatViewState();
}

class _EndChatViewState extends State<EndChatView> {
  var count = 0;

  @override
  void initState() {
    super.initState();
    showDialog();
  }

  showDialog() {
    Timer.periodic(const Duration(milliseconds: 150), (timer) {
      count++;
      if (count > 25) {
        timer.cancel();
        Get.offAll(DashboardView());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 25.h,
                  width: 25.h,
                  child: Lottie.asset('assets/thank-you.json'),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Txt(
                  'Terima Kasih',
                  TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Txt(
                  'Sudah melakukan konsultasi dengan kami',
                  TextStyle(fontSize: 13.sp, fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
