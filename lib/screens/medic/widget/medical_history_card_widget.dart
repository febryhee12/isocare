import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../helpers/ui_data.dart';
import '../../../../models/medical_history_model.dart';
import '../medical_history_view.dart';

class MedicalCardWidget extends StatelessWidget {
  final MedicalHistoryModel? model;

  MedicalCardWidget({this.model});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(
        MedicalHistoryView(
          doctor: model!.doctorName,
          prediagnostic: model!.prediagnostic,
          symptom: model!.symptom,
          firstAid: model!.firstAid,
          physicalCheck: model!.physicalCheck,
          labResult: model!.labResult,
          checkupDate: model!.checkupDate,
          labFile: model!.labFile,
          doctorProfileImageLink: model!.doctorProfileImageLink,
          receiptStatus: model!.medicineRecipeTrackingStatus,
          medicineRecipes: model!.medicineRecipes,
          medicineRecipeTracking: model!.medicineRecipeTracking,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Color(0xFFE0E0E0),
              spreadRadius: 2,
              blurRadius: 24,
              offset: Offset(0, 8), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(2.5.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: UIColor.cGreyBase),
                      shape: BoxShape.circle,
                    ),
                    child: CachedNetworkImage(
                      imageUrl: model!.doctorProfileImageLink,
                      fit: BoxFit.cover,
                      imageBuilder: (context, imageProvider) => CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: imageProvider,
                      ),
                      placeholder: (context, url) => const CircleAvatar(
                        backgroundImage: AssetImage('assets/no_user.jpg'),
                        child: SizedBox(
                          height: 10,
                          width: 10,
                          child: Center(
                              child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                          )),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 1.5.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Txt(
                                model!.doctorName,
                                TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 1.h,
              ),
              // Divider(color: Color(0xFFC0C0C0)),
              Html(
                data: model!.prediagnostic.toUpperCase(),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.sp),
                child: Text(
                  model!.checkupDate,
                  style: TextStyle(fontSize: 9.sp, color: Colors.black38),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
