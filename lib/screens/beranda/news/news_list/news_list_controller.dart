import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../models/news_model.dart';
import '../../../../service/app_exceptions.dart';
import '../../../../service/base_client.dart';
import '../../../../service/base_controller.dart';
import '../../../../service/base_url.dart';

class NewsListController extends GetxController with BaseController {
  var isLoading = true.obs;
  var listNews = <NewsModel>[].obs;
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void onInit() {
    super.onInit();
    fetchNewsList();
  }

  // GET LIST NEWS
  Future<List<NewsModel>?> getNews(int newsCategoryId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString(BaseUrl.token);
    var response = await BaseClient().get(
        BaseUrl.baseUrl,
        BaseUrl.listNewsUrl +
            newsCategoryId.toString() +
            "&table=true&sort[id]=desc&filters[source]=VM",
        {'Authorization': 'Bearer $token'});

    var responData = json.decode(response);

    if (response = true) {
      List<dynamic> arr = responData["data"]["data"];
      List<NewsModel> result = [];
      // ignore: avoid_function_literals_in_foreach_calls
      arr.forEach((x) {
        result.add(NewsModel.fromJson(x));
      });
      return result;
    } else {
      return null;
    }
  }

  Future<void> fetchNewsList({int news_category_id = 1}) async {
    try {
      var list = await getNews(news_category_id);
      if (list != null) {
        isLoading(true);
        listNews.assignAll(list);
      }
    } on FetchDataException catch (e) {
      throw Exception(
        {
          // ignore: avoid_print
          print('error caught: $e')
        },
      );
    } finally {
      isLoading(false);
    }
  }
}
