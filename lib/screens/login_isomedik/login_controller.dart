import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isocare/screens/dashboard/dashboard_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/helpers/ui_data.dart';
import '/service/base_client.dart';
import '/service/base_controller.dart';
import '/service/base_url.dart';

class LoginController extends GetxController with BaseController {
  final formKey = GlobalKey<FormState>();
  final uiImage = UIImage();
  final uiText = UIText();

  var hidden = true.obs;
  late TextEditingController username;
  late TextEditingController password;

  @override
  void onInit() {
    super.onInit();
    username = TextEditingController();
    password = TextEditingController();
  }

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }

  Future<void> signIn() async {
    if (formKey.currentState!.validate()) {
      var response = await BaseClient().post(
        BaseUrl.baseUrl,
        BaseUrl.token,
        {
          "grant_type": uiText.pass,
          "client_id": uiText.clientID,
          "client_secret": uiText.clientSecret,
          "username": username.text,
          "password": password.text,
          "scope": " "
        },
      ).catchError(handleError);
      print(response);

      if (response == null) {
        Get.snackbar("Sorry", "Wrong Username or Password",
            instantInit: false,
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
        await Future.delayed(
            const Duration(seconds: 3), () => Get.closeAllSnackbars());
      } else {
        var token = await json.decode(response);
        await pageShared(token["access_token"]);
        await dateShared(token["expires_at"]);
      }
    } else {
      return;
    }
  }

  Future<void> dateShared(String expDate) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("expDate", expDate);
  }

  Future<void> pageShared(String token) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("/api/login", token);
    Get.offAll(const DashboardView());
  }
}
