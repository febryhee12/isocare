// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:sizer/sizer.dart';

import '../../../helpers/ui_data.dart';
import 'family_controller.dart';
import 'widget/family_card_widget.dart';

class FamilyListview extends StatelessWidget {
  FamilyListController controller = Get.put(FamilyListController());

  FamilyListview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black87, //change your color here
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: const Txt('Kartu Peserta', TextStyle(color: UIColor.cDark70)),
      ),
      body: Obx(
        () => RefreshIndicator(
          // key: controller.refreshKey,
          onRefresh: () => controller.fetchListFamily(),
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: controller.listFamily.length,
            itemBuilder: (contex, i) {
              return Padding(
                padding: i == controller.listFamily.length - 1
                    ? EdgeInsets.fromLTRB(1.5.h, 1.5.h, 1.5.h, 1.5.h)
                    : EdgeInsets.fromLTRB(1.5.h, 1.5.h, 1.5.h, 0.h),
                child: FamilyCardWidget(
                  model: controller.listFamily[i],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
