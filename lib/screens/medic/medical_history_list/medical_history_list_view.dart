// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:sizer/sizer.dart';

import '../../../helpers/ui_data.dart';
import '../widget/medical_history_card_widget.dart';
import 'medical_history_list_controller.dart';

class MedicalHistoryListview extends StatelessWidget {
  MedicalHistoryListController controller =
      Get.put(MedicalHistoryListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Txt(
          'Rekam Medis',
          TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: controller.listMedicalHistory.isEmpty
          ? _placeHolder()
          : Obx(
              () => RefreshIndicator(
                key: controller.refreshKey,
                onRefresh: () => controller.fetchListMedicalHistory(),
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: controller.listMedicalHistory.length,
                  itemBuilder: (contex, i) {
                    return Padding(
                      padding: i == controller.listMedicalHistory.length - 1
                          ? EdgeInsets.fromLTRB(1.5.h, 1.5.h, 1.5.h, 1.5.h)
                          : EdgeInsets.fromLTRB(1.5.h, 1.5.h, 1.5.h, 0.h),
                      child: MedicalCardWidget(
                        model: controller.listMedicalHistory[i],
                      ),
                    );
                  },
                ),
              ),
            ),
    );
  }

  Widget _placeHolder() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Container(
            height: 100,
            width: 100,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/diagnosis.png"), fit: BoxFit.cover),
            ),
          ),
        ),
        SizedBox(height: 4.h),
        Txt(
          "Belum Ada Rekam Medis",
          TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 0.5.h),
        Txt(
          "Silakan konsultasi dengan dokter",
          TextStyle(fontSize: 12.sp, color: UIColor.cDark50),
        ),
        SizedBox(height: 4.h),
      ],
    );
  }
}
