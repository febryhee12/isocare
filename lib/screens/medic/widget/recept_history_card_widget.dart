import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../helpers/ui_data.dart';
import '../../../../models/medical_history_model.dart';

class ReceptHistoryCardWidget extends StatelessWidget {
  final MedicineRecipes? model;

  ReceptHistoryCardWidget({this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 1.h, bottom: 1.5.h),
      padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 2.5.h),
      decoration: BoxDecoration(
        color: UIColor.cGrey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Txt(
            'Nama Obat',
            TextStyle(
                color: UIColor.cDark50,
                fontSize: 11.sp,
                fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 1.5.h,
          ),
          Txt(model!.medicineName,
              TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp)),
          Padding(
            padding: EdgeInsets.only(top: 0.5.h),
            child: Txt(
              "${model!.quantity} ${model!.unit}",
              TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.normal,
                color: UIColor.cDark50,
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 1.h),
              child: const Divider(color: Color(0xFFC0C0C0))),
          Txt(model!.direction, TextStyle(fontSize: 12.sp)),
        ],
      ),
    );
  }
}
