import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../models/family_model.dart';
import '../../service/base_client.dart';
import '../../service/base_controller.dart';
import 'package:get/get.dart';

import '../../service/base_url.dart';

class FamilyListController extends GetxController with BaseController {
  var listFamily = <FamilyModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchListFamily();
  }

  // GET MEDICAL HISTORY USER
  Future<List<FamilyModel>?> getMedicalModel() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString(BaseUrl.token);
    var response = await BaseClient().get(
        BaseUrl.baseUrl,
        BaseUrl.family + "?sort[id]=desc&id=",
        {'Authorization': 'Bearer $token'}).catchError(handleError);

    if (response != null) {
      var responData = json.decode(response);
      List<dynamic> arr = responData["data"];
      List<FamilyModel> result = [];
      // ignore: avoid_function_literals_in_foreach_calls
      arr.forEach((x) {
        result.add(FamilyModel.fromJson(x));
      });
      return result;
    } else {
      return null;
    }
  }

  Future<void> fetchListFamily() async {
    try {
      var list = await getMedicalModel();
      if (list != null) {
        listFamily.assignAll(list);
      } else {
        return;
      }
    } finally {}
  }
}
