import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/doctor_model.dart';
import '../../service/app_exceptions.dart';
import '../../service/base_client.dart';
import '../../service/base_controller.dart';
import '../../service/base_url.dart';
import '../beranda/home_controller.dart';
import '../video_call/auth_video_call/auth_view.dart';
import '../video_call/recipient_address/recipient_address_view.dart';

class DashboardController extends GetxController with BaseController {
  final HomeController homeController = Get.put(HomeController());
  var listDoctor = <ListDoctor>[].obs;
  var textClear = ''.obs;
  var voucherStatus = ''.obs;
  late TextEditingController voucherCode;

  @override
  void onInit() {
    super.onInit();
    voucherCode = TextEditingController();
    fetchListDoctor();
  }

  @override
  void dispose() {
    voucherCode.dispose();
    super.dispose();
  }

  Future<List<ListDoctor>?> getListDoctor() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString(BaseUrl.token);
    var response = await BaseClient().get(BaseUrl.baseUrl, BaseUrl.listDoctor,
        {'Authorization': 'Bearer $token'}).catchError(handleError);

    if (response != null) {
      var responData = json.decode(response);
      List<dynamic> arr = responData["data"];
      List<ListDoctor> result = [];
      // ignore: avoid_function_literals_in_foreach_calls
      arr.forEach((x) {
        result.add(ListDoctor.fromJson(x));
      });
      return result;
    } else {
      return null;
    }
  }

  Future<void> fetchListDoctor() async {
    try {
      var doctor = await getListDoctor();
      if (doctor != null) {
        // isLoading(true);
        listDoctor.assignAll(doctor);
      }
    } on FetchDataException catch (e) {
      throw Exception(
        {
          // ignore: avoid_print
          print('error caught: $e')
        },
      );
    } finally {
      // isLoading(false);
    }
  }

  //check Input
  void clearText() {
    voucherCode = TextEditingController(text: textClear.value);
  }

  //check Voucer
  Future<void> checkVoucher() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString(BaseUrl.token);
    var response = await BaseClient().postHB(
        BaseUrl.baseUrl,
        BaseUrl.getVoucher,
        {'Authorization': 'Bearer $token'},
        {'code': voucherCode.text}).catchError(handleError);
    var data = await jsonDecode(response);
    if (data['status'] == true) {
      clearText();
      if (homeController.profileUser.value.yesdokRegistration == 0) {
        Get.back();
        Get.to(AuthVideoCallView());
      } else {
        Get.back();
        Get.to(RecipientAddrerssView());
      }
    }
  }
}
