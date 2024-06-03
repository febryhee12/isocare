import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../../../../helpers/ui_data.dart';
import '../../../../helpers/widget/shimmer_widget.dart';
import '../news_list/news_list_view.dart';
import 'news_category_controller.dart';

// ignore: use_key_in_widget_constructors
class NewsCategoryView extends StatefulWidget {
  @override
  State<NewsCategoryView> createState() => _NewsCategoryViewState();
}

class _NewsCategoryViewState extends State<NewsCategoryView>
    with AutomaticKeepAliveClientMixin<NewsCategoryView> {
  NewsCategoryController newsCategoryController =
      Get.put(NewsCategoryController());

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Obx(
      () => DefaultTabController(
        length: newsCategoryController.newsCategories.length,
        child: Scaffold(
            appBar: AppBar(
              title: const Txt(
                'News',
                TextStyle(color: UIColor.cDark70),
              ),
              iconTheme: const IconThemeData(
                color: Colors.black, //change your color here
              ),
              elevation: 0,
              backgroundColor: Colors.white,
              bottom: TabBar(
                tabs: newsCategoryController.newsCategories
                    .map((model) => tab(model.name))
                    .toList(),
                isScrollable: true,
                labelColor: Colors.blueAccent,
                unselectedLabelColor: Colors.black54,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Colors.blueAccent,
                labelStyle: GoogleFonts.sourceSansPro(
                  textStyle:
                      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            body: newsCategoryController.isLoading.value
                ? loadingContent()
                : tabBodyContent()),
      ),
    );
  }

  Widget loadingContent() {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: 4,
      itemBuilder: (contex, i) {
        return Padding(
          padding: EdgeInsets.only(top: 1.5.h, left: 2.h, right: 2.h),
          child: ShimmerWidget.rectangular(
            height: 200,
            shapeBorder:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      },
    );
  }

  Widget tabBodyContent() {
    return TabBarView(
      physics: const NeverScrollableScrollPhysics(),
      children: newsCategoryController.newsCategories
          .map(
            (model) => NewsListView(
              news_category_id: model.id,
              isRelod: true,
            ),
          )
          .toList(),
    );
  }

  Widget tab(String tabName) {
    return Tab(
      text: tabName,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
