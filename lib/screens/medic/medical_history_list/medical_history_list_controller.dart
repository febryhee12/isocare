import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../models/medical_history_model.dart';
import '../../../../service/base_client.dart';
import '../../../../service/base_controller.dart';
import '../../../../service/base_url.dart';
import '../../../models/doctor_model.dart';
import '../../../service/app_exceptions.dart';

class MedicalHistoryListController extends GetxController with BaseController {
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  var listMedicalHistory = <MedicalHistoryModel>[].obs;
  var listDoctor = <ListDoctor>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchListMedicalHistory();
    fetchListDoctor();
  }

  // GET MEDICAL HISTORY USER
  Future<List<MedicalHistoryModel>?> getMedicalModel() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString(BaseUrl.token);
    var response = await BaseClient().get(
        BaseUrl.baseUrl,
        BaseUrl.medicalHistory + "?sort[id]=desc&id=",
        {'Authorization': 'Bearer $token'}).catchError(handleError);

    if (response != null) {
      var responData = json.decode(response);
      List<dynamic> arr = responData["data"];
      List<MedicalHistoryModel> result = [];
      // ignore: avoid_function_literals_in_foreach_calls
      arr.forEach((x) {
        result.add(MedicalHistoryModel.fromJson(x));
      });
      return result;
    } else {
      return null;
    }
  }

  Future<void> fetchListMedicalHistory() async {
    try {
      var list = await getMedicalModel();
      if (list != null) {
        listMedicalHistory.assignAll(list);
      } else {
        return;
      }
    } finally {}
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
}
