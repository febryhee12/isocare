import 'package:get/get.dart';

import '../news_list/news_list_controller.dart';
import 'news_category_controller.dart';

class NewsCategoryBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<NewsCategoryController>(NewsCategoryController());
    Get.put<NewsListController>(NewsListController());
  }
}
