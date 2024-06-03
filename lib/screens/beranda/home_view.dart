import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:isocare/config.dart';
import 'package:isocare/screens/booking/booking_view.dart';
import 'package:isocare/screens/family/family_view.dart';
import '../../helpers/widget/button.dart';
import '../../helpers/widget/textfield.dart';
import '../chat/waitng/waiting_support.dart';
import '../chat/waitng/waiting_view.dart';
import '../dashboard/dashboard_controller.dart';
import '../video_call/recipient_address/recipient_address_view.dart';
import '/helpers/ui_data.dart';

import 'package:sizer/sizer.dart';

import 'home_controller.dart';

// ignore: must_be_immutable
class HomeView extends GetView<HomeController> {
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  @override
  final HomeController controller = Get.put(HomeController());
  final DashboardController dashController = Get.put(DashboardController());

  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight - 230) / 2;
    final double itemWidth = size.width / 2;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0.0),
        child: AppBar(
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          backgroundColor: kPrimaryColor,
          automaticallyImplyLeading: false,
        ),
      ),
      body: Obx(() {
        return ListView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            Container(
              color: kPrimaryColor,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 1.h),
                child: SizedBox(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(100)),
                            width: 40,
                            height: 40,
                            child: CachedNetworkImage(
                              imageUrl:
                                  controller.profileUser.value.profileImageLink,
                              fit: BoxFit.cover,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.cover),
                                ),
                              ),
                              placeholder: (context, url) => const CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/no_user.jpg'),
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
                          Padding(
                            padding: EdgeInsets.only(left: 2.h),
                            child: Txt(
                              controller.profileUser.value.username,
                              TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: _buttonlogout(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Stack(
              children: [
                SizedBox(
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  child: CustomPaint(
                    painter: CurvePainter(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 5.0, vertical: 5.0),
                  child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: (itemWidth / itemHeight),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      _konsultasi(context),
                      _reservasi(),
                      _admin(),
                      // _kartuPerserta(context),
                      _kartuFamily(),
                    ],
                    // gridDelegate:
                    //     const SliverGridDelegateWithFixedCrossAxisCount(
                    //         crossAxisCount: 2,
                    //         mainAxisSpacing: 2,
                    //         crossAxisSpacing: 2),
                  ),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }

  Widget _konsultasi(context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () async {
          if (controller.profileUser.value.consultationType == 'chat') {
            Get.to(RecipientAddrerssView());
          } else {
            bottomSheetVoucher(context);
          }
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(width: 1.0, color: UIColor.cGrey),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 2.5.h,
              ),
              FaIcon(
                FontAwesomeIcons.userDoctor,
                color: kPrimaryColor,
                size: 5.h,
              ),
              SizedBox(
                height: 1.2.h,
              ),
              Txt(
                'Konsultasi'.toUpperCase(),
                TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 1.2.h,
              ),
              Txt(
                'Chat dokter online untuk diagnosa dan pengiriman obat',
                TextStyle(fontSize: 9.sp, color: UIColor.cGrey50),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _reservasi() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => Get.to(BookingView()),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(width: 1.0, color: UIColor.cGrey),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 2.5.h,
              ),
              FaIcon(
                FontAwesomeIcons.building,
                color: kPrimaryColor,
                size: 5.h,
              ),
              SizedBox(
                height: 1.2.h,
              ),
              Txt(
                'Reservasi Klinik'.toUpperCase(),
                TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 1.2.h,
              ),
              Txt(
                'Berobat di FKTP yang terdaftar',
                TextStyle(fontSize: 9.sp, color: UIColor.cGrey50),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _kartuFamily() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => Get.to(FamilyListview()),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(width: 1.0, color: UIColor.cGrey),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 2.5.h,
              ),
              FaIcon(
                FontAwesomeIcons.idCard,
                color: kPrimaryColor,
                size: 5.h,
              ),
              SizedBox(
                height: 1.2.h,
              ),
              Txt(
                'Kartu Isocare'.toUpperCase(),
                TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 1.2.h,
              ),
              Txt(
                'Informasi Peserta',
                TextStyle(fontSize: 9.sp, color: UIColor.cGrey50),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _admin() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => Get.to(WaitingSupportView()),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(width: 1.0, color: UIColor.cGrey),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 2.5.h,
              ),
              Icon(
                Icons.support_agent,
                color: kPrimaryColor,
                size: 5.h,
              ),
              SizedBox(
                height: 1.2.h,
              ),
              Txt(
                'Chat Admin'.toUpperCase(),
                TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 1.2.h,
              ),
              Txt(
                'Chat dengan admin mengenai program ISOcare',
                TextStyle(fontSize: 9.sp, color: UIColor.cGrey50),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buttonlogout() {
    return SizedBox(
      child: TextButton(
        style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(50, 0),
            alignment: Alignment.centerLeft,
            backgroundColor: kPrimaryColor),
        onPressed: () async {
          await controller.logout();
        },
        child: Txt(
            'Keluar',
            TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white)),
      ),
    );
  }

  bottomSheetVoucher(context) {
    return Get.bottomSheet(
      Container(
        height: 32.h,
        padding: EdgeInsets.symmetric(vertical: 2.h),
        color: Colors.white,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    right: 2.h, left: 2.5.h, top: 2.h, bottom: 2.h),
                child: Text(
                  'Silakan masukan kode voucher untuk melakukan konsultasi',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.h),
                child: fieldInputVoucher(),
              ),
              SizedBox(
                height: 1.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.h),
                child: ButtonElevated(
                  minSize: const Size(double.infinity, 50),
                  label: 'Submit',
                  textStyle: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                  onPressed: () => dashController.checkVoucher(),
                  cButton: kPrimaryColor,
                  cBorder: Colors.transparent,
                  wBorder: 0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  fieldInputVoucher() {
    return InputTextField(
      hintText: "Masukan Kode Voucher Anda",
      obscureText: false,
      controller: dashController.voucherCode,
      keyboardType: TextInputType.text,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9_]')),
        FilteringTextInputFormatter.deny(RegExp('[ ]'))
      ],
    );
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = kPrimaryColor;
    paint.style = PaintingStyle.fill; // Change this to fill

    var path = Path();

    path.moveTo(0, size.height * 0.25);
    path.quadraticBezierTo(
        size.width / 2, size.height / 2, size.width, size.height * 0.25);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
