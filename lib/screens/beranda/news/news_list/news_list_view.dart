import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../helpers/widget/shimmer_widget.dart';
import '../widget/news_card_widget.dart';
import 'news_list_controller.dart';

// ignore: must_be_immutable
class NewsListView extends StatefulWidget {
  // ignore: non_constant_identifier_names
  int news_category_id;
  bool isRelod;

  // ignore: use_key_in_widget_constructors, non_constant_identifier_names
  NewsListView({required this.news_category_id, required this.isRelod});

  @override
  State<NewsListView> createState() => _NewsListViewState();
}

class _NewsListViewState extends State<NewsListView> {
  NewsListController controller = Get.put(NewsListController());

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () async {
        if (widget.isRelod) {
          await controller.fetchNewsList(
              news_category_id: widget.news_category_id);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: 4,
          itemBuilder: (contex, i) {
            return Padding(
              padding: EdgeInsets.only(top: 1.5.h),
              child: ShimmerWidget.rectangular(
                height: 200,
                shapeBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
              ),
            );
          },
        );
      } else {
        return RefreshIndicator(
          onRefresh: () => controller.fetchNewsList(
              news_category_id: widget.news_category_id),
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: controller.listNews.length,
            itemBuilder: (contex, i) {
              return controller.isLoading.value ? buildShimer() : cardWidget(i);
            },
          ),
          key: GlobalKey<RefreshIndicatorState>(),
        );
      }
    });
  }

  Widget buildShimer() {
    return Padding(
      padding: EdgeInsets.only(top: 1.5.h),
      child: ShimmerWidget.rectangular(
        height: 200,
        shapeBorder:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
    );
  }

  Widget cardWidget(i) {
    return Padding(
      padding: EdgeInsets.only(top: 1.5.h),
      child: NewsCardWidget(
        model: controller.listNews[i],
      ),
    );
  }
}
