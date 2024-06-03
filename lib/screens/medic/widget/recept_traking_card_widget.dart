import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sizer/sizer.dart';

import '../../../../helpers/ui_data.dart';
import '../../../../models/medical_history_model.dart';

class ReceptTrackingCardWidget extends StatelessWidget {
  final MedicineRecipeTracking? model;

  ReceptTrackingCardWidget({this.model});

  @override
  Widget build(BuildContext context) {
    var date = DateTime.parse(model!.createdAt);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 2.h, top: 1.h),
            child: Column(
              children: [
                SizedBox(
                  height: 1.h,
                  width: 1.h,
                  child: const CircleAvatar(
                    backgroundColor: UIColor.primary,
                  ),
                ),
                SizedBox(
                  height: 12.h,
                  child:
                      VerticalDivider(color: UIColor.primarySoft, width: 1.h),
                )
              ],
            ),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Txt(
                    model!.status == "progress"
                        ? "Diproses"
                        : model!.status == "delivery"
                            ? "Dalam Perjalanan"
                            : model!.status == "arrived"
                                ? "Sudah Diterima"
                                : model!.status,
                    TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12.sp,
                        color: Colors.black54)),
                SizedBox(
                  height: 2.h,
                ),
                model!.type != "text"
                    ? LaunchBtn(() async {
                        await openUrl(model!.description);
                      }, "Link Traking " + model!.description)
                    : Txt(
                        model!.description,
                        TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 12.sp)),
                SizedBox(
                  height: 2.h,
                ),
                Txt('${date.day.toString()}-${date.month.toString()}-${date.year.toString()}',
                    TextStyle(fontSize: 11.sp, color: Colors.black54)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LaunchBtn extends StatelessWidget {
  final String text;
  final Function()? tap;

  LaunchBtn(this.tap, this.text);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        minimumSize: Size.zero,
        padding: EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child:
          Txt(text, TextStyle(fontWeight: FontWeight.normal, fontSize: 12.sp)),
      onPressed: tap,
    );
  }
}

Future<void> openUrl(String url,
    {bool forceViewWeb = false, bool enableJavaScript = false}) async {
  await launch(url);
}
