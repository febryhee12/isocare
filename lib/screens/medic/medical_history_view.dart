// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sizer/sizer.dart';

import '../../../helpers/ui_data.dart';
import '../../../helpers/widget/button.dart';
import 'widget/recept_history_card_widget.dart';
import 'widget/recept_traking_card_widget.dart';

class MedicalHistoryView extends StatefulWidget {
  String? doctor;
  String? prediagnostic;
  String? symptom;
  String? firstAid;
  String? physicalCheck;
  String? labResult;
  String? checkupDate;
  String? labFile;
  String? doctorProfileImageLink;
  String? receiptStatus;
  List? medicineRecipes;
  List? medicineRecipeTracking;

  MedicalHistoryView(
      {super.key,
      this.doctor,
      this.prediagnostic,
      this.symptom,
      this.firstAid,
      this.physicalCheck,
      this.labResult,
      this.checkupDate,
      this.labFile,
      this.doctorProfileImageLink,
      this.receiptStatus,
      this.medicineRecipes,
      this.medicineRecipeTracking});

  @override
  State<MedicalHistoryView> createState() => _MedicalHistoryViewState();
}

class _MedicalHistoryViewState extends State<MedicalHistoryView> {
  Future<void> openUrl(String url,
      {bool forceViewWeb = true,
      bool enableJavaScript = true,
      bool forceSafariVC = true}) async {
    await launch(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Get.back(),
        ),
        title: const Txt(
          'Detail Rekam Medis',
          TextStyle(color: UIColor.cDark70),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          color: UIColor.cGreyBase,
          child: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(2.h),
                  child: _doctor(context),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.fromLTRB(2.h, 3.h, 2.h, 0.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _kolomPertama(),
                      _devider(),
                      _kolomKedua(),
                      _devider(),
                      _kolomKetiga(),
                      _devider(),
                      _kolomKeLima(),
                      _kolomKeempat(),
                      // _labelnUnduh(),
                    ],
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                _listRecept(),
                SizedBox(
                  height: 1.h,
                ),
                _listTracking(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _devider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 2.h,
        ),
        // const Divider(color: Color(0xFFC0C0C0)),
        SizedBox(
          height: 2.h,
        ),
      ],
    );
  }

  Widget _doctor(context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFFAFAFA),
            spreadRadius: 2,
            blurRadius: 24,
            offset: Offset(0, 8), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(2.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 60,
                  height: 60,
                  child: CachedNetworkImage(
                    imageUrl: widget.doctorProfileImageLink!,
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Txt(
                          widget.doctor!,
                          TextStyle(
                              fontSize: 13.sp, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3.h,
            ),
            // const Divider(color: Color(0xFFC0C0C0)),
            // SizedBox(
            //   height: 1.h,
            // ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Txt(
                  'Tanggal konsultasi',
                  TextStyle(fontSize: 12.sp),
                ),
                Txt(
                  widget.checkupDate!,
                  TextStyle(fontSize: 12.sp),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _kolomPertama() {
    return medicalData(
        data: 'Perkiraan Diagnosis'.toUpperCase(),
        htmlData: widget.prediagnostic!);
  }

  _kolomKedua() {
    return medicalData(data: 'Gejala'.toUpperCase(), htmlData: widget.symptom!);
  }

  _kolomKetiga() {
    return medicalData(
        data: 'Penanganan pertama'.toUpperCase(), htmlData: widget.firstAid!);
  }

  // Widget _kolomKedua() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Padding(
  //         padding: EdgeInsets.only(left: 6),
  //         child: Txt(
  //           'Gejala'.toUpperCase(),
  //           TextStyle(
  //               fontSize: 11.sp,
  //               fontWeight: FontWeight.bold,
  //               color: Colors.black87),
  //         ),
  //       ),
  //       Html(
  //         onLinkTap: (url, context, attributes, element) async {
  //           if (await canLaunch(url!)) {
  //             await launch(url,
  //                 forceSafariVC: false,
  //                 forceWebView: false,
  //                 enableJavaScript: false);
  //           } else {
  //             throw "link tidak di temukan";
  //           }
  //         },
  //         data: widget.symptom!,
  //         style: {
  //           "body": Style(
  //             color: Colors.black54,
  //             fontSize: FontSize(12.sp),
  //             fontWeight: FontWeight.normal,
  //           ),
  //         },
  //       ),
  //     ],
  //   );
  // }

  // Widget _kolomKetiga() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Padding(
  //         padding: EdgeInsets.only(left: 6),
  //         child: Txt(
  //           'Penanganan pertama'.toUpperCase(),
  //           TextStyle(
  //               fontSize: 11.sp,
  //               fontWeight: FontWeight.bold,
  //               color: Colors.black87),
  //         ),
  //       ),
  //       Html(
  //         onLinkTap: (url, context, attributes, element) async {
  //           if (await canLaunch(url!)) {
  //             await launch(url,
  //                 forceSafariVC: false,
  //                 forceWebView: false,
  //                 enableJavaScript: false);
  //           } else {
  //             throw "link tidak di temukan";
  //           }
  //         },
  //         data: widget.firstAid!,
  //         style: {
  //           "body": Style(
  //             color: Colors.black54,
  //             fontSize: FontSize(12.sp),
  //             fontWeight: FontWeight.normal,
  //           ),
  //         },
  //       ),
  //     ],
  //   );
  // }

  Widget _kolomKeempat() {
    return widget.receiptStatus!.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.only(left: 6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Txt(
                  'Status pengiriman obat'.toUpperCase(),
                  TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Text(
                  widget.receiptStatus! == "pending"
                      ? "Menunggu Konfirmasi"
                      : widget.receiptStatus! == "unavalaible-medicine"
                          ? "Obat Tidak Tersedia"
                          : widget.receiptStatus! == "finding-outlet"
                              ? "Mencari Outlet"
                              : widget.receiptStatus! == "progress"
                                  ? "Diproses"
                                  : widget.receiptStatus! == "pickup"
                                      ? "Dalam Pemgambilan"
                                      : widget.receiptStatus! == "delivery"
                                          ? "Dalam Perjalanan"
                                          : widget.receiptStatus! == "arrived"
                                              ? "Sudah Diterima"
                                              : widget.receiptStatus! ==
                                                      "cancel"
                                                  ? "Batal"
                                                  : widget.receiptStatus!,
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: Colors.black54,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
              ],
            ),
          )
        : SizedBox(
            height: 0.h,
          );
  }

  Widget _kolomKeLima() {
    return widget.labFile!.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Txt(
                  'Lab File'.toUpperCase(),
                  TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.zero,
                      child: ButtonElevated(
                        label: 'Unduh PDF',
                        onPressed: () async {
                          final url = "${widget.labFile}";
                          String googleDocs =
                              "https://docs.google.com/viewer?url=";
                          if (await canLaunch(url)) {
                            await launch(
                              googleDocs + url,
                              forceSafariVC: false,
                              forceWebView: false,
                              enableJavaScript: false,
                            );
                          } else {
                            throw "link tidak di temukan";
                          }
                        },
                        cButton: UIColor.primary,
                        cBorder: Colors.transparent,
                        wBorder: 0,
                      ),
                    ),
                  ],
                ),
                _devider(),
              ],
            ),
          )
        : SizedBox(
            height: 0.h,
          );
  }

  Widget _labelnUnduh() {
    return SizedBox(
      height: 5.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Txt(
            'File PDF',
            TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
            margin: EdgeInsets.zero,
            child: ButtonElevated(
              label: 'Unduh PDF',
              onPressed: () {},
              cButton: UIColor.primary,
              cBorder: Colors.transparent,
              wBorder: 0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _listRecept() {
    return widget.medicineRecipes!.isNotEmpty
        ? Container(
            padding: EdgeInsets.symmetric(horizontal: 2.h),
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0.h, 3.5.h, 0.h, 2.h),
                  child: Txt(
                    'Resep obat',
                    TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.medicineRecipes!.length,
                  itemBuilder: (contex, i) {
                    return ReceptHistoryCardWidget(
                      model: widget.medicineRecipes![i],
                    );
                  },
                ),
              ],
            ),
          )
        : const SizedBox(
            height: 0,
          );
  }

  Widget _listTracking() {
    return widget.medicineRecipeTracking!.isNotEmpty
        ? Container(
            padding: EdgeInsets.symmetric(horizontal: 2.h),
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(2.h, 3.5.h, 2.h, 2.h),
                  child: Txt(
                    'Detail status pengiriman',
                    TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.medicineRecipeTracking!.length,
                  reverse: true,
                  itemBuilder: (contex, i) {
                    return ReceptTrackingCardWidget(
                      model: widget.medicineRecipeTracking![i],
                    );
                  },
                ),
              ],
            ),
          )
        : const SizedBox(
            height: 0,
          );
  }

  medicalData({String? data, String? htmlData}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Txt(
          data!,
          TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        Html(
          data: htmlData,
          style: {
            "div": Style(
              fontSize: FontSize.medium,
              padding: HtmlPaddings.all(0),
              margin: Margins.all(0),
            ),
            "body": Style(
              fontSize: FontSize.medium,
              padding: HtmlPaddings.all(0),
              margin: Margins.all(0),
            ),
            "p": Style(
              fontSize: FontSize.medium,
              lineHeight: const LineHeight(1.8),
              color: Colors.black54,
              padding: HtmlPaddings.only(left: 0, top: 6),
              margin: Margins.all(0),
            ),
          },
        ),
        _devider(),
      ],
    );
  }
}
