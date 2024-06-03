import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../config.dart';
import '../../../helpers/ui_data.dart';
import '../../../models/family_model.dart';

class FamilyCardWidget extends StatelessWidget {
  final FamilyModel? model;

  const FamilyCardWidget({super.key, this.model});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Txt(
            model!.memberName.toUpperCase(),
            TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87),
          ),
        ),
        SizedBox(
          height: 1.h,
        ),
        const Divider(
          color: Colors.black54,
          height: 0.5,
        ),
        SizedBox(
          height: 1.h,
        ),
        CachedNetworkImage(
          imageUrl: model!.insuranceCardUrlFront,
          imageBuilder: (context, imageProvider) => Container(
            height: 28.h,
            width: MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              // border: Border.all(width: 0.5, color: Colors.black12),
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
            ),
          ),
          // placeholder: (context, url) => Container(
          //   decoration: const BoxDecoration(),
          //   child: ShimmerWidget.rectangular(
          //     height: 14.h,
          //     width: 22.h,
          //     shapeBorder: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(8)),
          //   ),
          // ),
          // errorWidget: (context, url, error) => Container(
          //   height: 14.h,
          //   width: 22.h,
          //   decoration: BoxDecoration(
          //     color: MedisColors.grey_300,
          //     shape: BoxShape.rectangle,
          //     // border: Border.all(width: 0.5, color: Colors.black12),
          //     borderRadius: BorderRadius.circular(8),
          //   ),
          //   child: Image.asset(
          //     'assets/images/placeholder.png',
          //     fit: BoxFit.fill,
          //   ),
          // ),
        ),
        SizedBox(
          height: 1.h,
        ),
        CachedNetworkImage(
          imageUrl: model!.insuranceCardUrlBack,
          imageBuilder: (context, imageProvider) => Container(
            height: 28.h,
            width: MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              // border: Border.all(width: 0.5, color: Colors.black12),
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
            ),
          ),
          // placeholder: (context, url) => Container(
          //   decoration: const BoxDecoration(),
          //   child: ShimmerWidget.rectangular(
          //     height: 14.h,
          //     width: 22.h,
          //     shapeBorder: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(8)),
          //   ),
          // ),
          // errorWidget: (context, url, error) => Container(
          //   height: 14.h,
          //   width: 22.h,
          //   decoration: BoxDecoration(
          //     color: MedisColors.grey_300,
          //     shape: BoxShape.rectangle,
          //     // border: Border.all(width: 0.5, color: Colors.black12),
          //     borderRadius: BorderRadius.circular(8),
          //   ),
          //   child: Image.asset(
          //     'assets/images/placeholder.png',
          //     fit: BoxFit.fill,
          //   ),
          // ),
        ),
        SizedBox(
          height: 3.h,
        ),
      ],
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Align(
  //     alignment: Alignment.center,
  //     child: SizedBox(
  //       height: 40.h,
  //       child: Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
  //         child: Stack(
  //           children: [
  //             Container(
  //               height: 35.h,
  //               decoration: BoxDecoration(
  //                 border: Border.all(color: Colors.black26, width: 0.5),
  //                 image: const DecorationImage(
  //                     image: AssetImage("assets/images/bg9.png"),
  //                     fit: BoxFit.cover),
  //                 borderRadius: BorderRadius.circular(12),
  //                 // color: Colors.white,
  //               ),
  //             ),
  //             Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Container(
  //                   padding: const EdgeInsets.symmetric(
  //                       horizontal: 12, vertical: 12.0),
  //                   decoration: const BoxDecoration(
  //                     border: Border(
  //                       bottom: BorderSide(
  //                         width: 1,
  //                         color: kPrimaryColor,
  //                       ),
  //                     ),
  //                   ),
  //                   width: MediaQuery.of(context).size.width,
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       SizedBox(
  //                         height: 3.h,
  //                         child: Image.asset(
  //                           'assets/logo.png',
  //                         ),
  //                       ),
  //                       Txt(
  //                           'Kartu Identitas Peserta'.toUpperCase(),
  //                           TextStyle(
  //                               fontSize: 12.sp,
  //                               fontWeight: FontWeight.bold,
  //                               color: kPrimaryColor))
  //                     ],
  //                   ),
  //                 ),
  //                 SizedBox(
  //                   height: 2.h,
  //                 ),
  //                 Padding(
  //                   padding: const EdgeInsets.symmetric(horizontal: 12.0),
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Row(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: [
  //                           Txt(
  //                               model!.memberName,
  //                               TextStyle(
  //                                   fontSize: 14.sp,
  //                                   fontWeight: FontWeight.w600)),
  //                           Column(
  //                             crossAxisAlignment: CrossAxisAlignment.end,
  //                             mainAxisAlignment: MainAxisAlignment.center,
  //                             children: [
  //                               Txt(
  //                                   'Faskes',
  //                                   TextStyle(
  //                                       fontSize: 10.sp,
  //                                       color: UIColor.cGrey50)),
  //                               SizedBox(
  //                                 height: 1.h,
  //                               ),
  //                               Txt(
  //                                   model!.faskesName,
  //                                   TextStyle(
  //                                       fontSize: 11.sp,
  //                                       fontWeight: FontWeight.w600)),
  //                             ],
  //                           ),
  //                         ],
  //                       ),
  //                       Txt(
  //                           model!.birthday,
  //                           TextStyle(
  //                               fontSize: 11.sp,
  //                               color: UIColor.cGrey50,
  //                               fontWeight: FontWeight.normal)),
  //                       SizedBox(
  //                         height: 1.5.h,
  //                       ),
  //                       Txt('No. Kartu',
  //                           TextStyle(fontSize: 10.sp, color: UIColor.cGrey50)),
  //                       SizedBox(
  //                         height: 0.5.h,
  //                       ),
  //                       Txt(
  //                           model!.insuranceNumber,
  //                           TextStyle(
  //                               fontSize: 14.sp, fontWeight: FontWeight.w600)),
  //                       SizedBox(
  //                         height: 2.h,
  //                       ),
  //                       Txt('No. BPJS',
  //                           TextStyle(fontSize: 10.sp, color: UIColor.cGrey50)),
  //                       SizedBox(
  //                         height: 0.5.h,
  //                       ),
  //                       Txt(
  //                           model!.bpjsNumber,
  //                           TextStyle(
  //                               fontSize: 14.sp, fontWeight: FontWeight.w600)),
  //                       SizedBox(
  //                         height: 2.h,
  //                       ),
  //                     ],
  //                   ),
  //                 )
  //               ],
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
