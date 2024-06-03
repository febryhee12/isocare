import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:isocare/controllers/auth_controller.dart';
import 'package:isocare/screens/home/home.dart';
import 'package:isocare/screens/login/login.dart';

import '../config.dart';

class Root extends StatelessWidget {
  Root({Key? key}) : super(key: key);

  final auth = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    Config().init(context);

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        title: Center(
          child: Image.asset(
            'assets/logo.png',
            fit: BoxFit.contain,
            height: 32,
          ),
        ),
        backgroundColor: kBackgroundColor,
      ),
      body: GetBuilder<AuthController>(
        builder: (_) {
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Config.screenWidth! * 0.04,
              ),
              child: _.isLoggedIn.value ? const Home() : const Login(),
            ),
          );
        },
      ),
    );
  }
}
