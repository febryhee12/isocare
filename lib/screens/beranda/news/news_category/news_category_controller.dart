import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../models/news_category_model.dart';
import '../../../../service/base_client.dart';
import '../../../../service/base_controller.dart';
import '../../../../service/base_url.dart';

class NewsCategoryController extends GetxController with BaseController {
  var isLoading = true.obs;
  var newsCategories = <NewsCategoryModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchNewsCategories();
  }

  Future<List<NewsCategoryModel>?> getNewsCategoryModel() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString(BaseUrl.token);
    var response = await BaseClient().get(BaseUrl.baseUrl,
        BaseUrl.categoryNewsUrl, {'Authorization': 'Bearer $token'});

    var responData = json.decode(response);

    if (response = true) {
      List<dynamic> arr = responData["data"]["data"];
      List<NewsCategoryModel> result = [];
      // ignore: avoid_function_literals_in_foreach_calls
      arr.forEach((x) {
        result.add(NewsCategoryModel.fromJson(x));
      });
      return result;
    } else {
      return null;
    }
  }

  Future<void> fetchNewsCategories() async {
    isLoading(true);
    var newsCatergory = await getNewsCategoryModel();
    if (newsCatergory != null) {
      newsCategories.clear();
      newsCategories.assignAll(newsCatergory);
    }
    isLoading(false);
  }
}
