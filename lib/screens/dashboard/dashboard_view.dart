import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:isocare/screens/beranda/home_controller.dart';
import 'package:isocare/screens/booking/booking_view.dart';
import 'package:sizer/sizer.dart';

import '../../config.dart';
import '../../helpers/ui_data.dart';
import '../../helpers/widget/button.dart';
import '../../helpers/widget/textfield.dart';
import '../beranda/home_view.dart';
import '../chat/waitng/waiting_support.dart';
import '../medic/medical_history_list/medical_history_list_view.dart';
import 'dashboard_controller.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final DashboardController dashController = Get.put(DashboardController());
  final HomeController homeController = Get.put(HomeController());

  var tabIndex = 0;

  void changeTabIndex(int index) {
    setState(() {
      tabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          IndexedStack(
            index: tabIndex,
            children: [
              HomeView(),
              MedicalHistoryListview(),
            ],
          ),
        ],
      ),
      floatingActionButton: SpeedDial(
        backgroundColor: kPrimaryColor,
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: const IconThemeData(size: 22.0),
        visible: true,
        curve: Curves.bounceIn,
        children: [
          SpeedDialChild(
            child: const FaIcon(FontAwesomeIcons.building, color: Colors.white),
            backgroundColor: kPrimaryColor,
            onTap: () async {
              Get.to(BookingView());
            },
            labelWidget: Container(
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(5),
              ),
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.all(6),
              child: const Txt(
                'Reservasi Klinik',
                TextStyle(color: Colors.white),
              ),
            ), // Container
          ), // Speed
          SpeedDialChild(
            child:
                const FaIcon(FontAwesomeIcons.userDoctor, color: Colors.white),
            backgroundColor: kPrimaryColor,
            onTap: () async {
              await bottomSheetVoucher(context);
            },
            labelWidget: Container(
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(5),
              ),
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.all(6),
              child: const Txt(
                'Konsultasi Dokter',
                TextStyle(color: Colors.white),
              ),
            ), // Container
          ), // SpeedDialChild
          SpeedDialChild(
            child: const FaIcon(Icons.support_agent, color: Colors.white),
            backgroundColor: kPrimaryColor,
            onTap: () async {
              Get.to(WaitingSupportView());
            },
            labelWidget: Container(
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(5),
              ),
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.all(6),
              child: const Txt(
                'Chat Admin',
                TextStyle(color: Colors.white),
              ),
            ), // Container
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedItemColor: UIColor.cDark50,
        selectedItemColor: kPrimaryColor,
        onTap: changeTabIndex,
        currentIndex: tabIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          _bottomNavigationBarItem(
              icon: Ionicons.home_outline,
              active: Ionicons.home,
              label: 'Utama'),
          _bottomNavigationBarItem(
              icon: Ionicons.newspaper_outline,
              active: Ionicons.newspaper,
              label: 'Rekam'),
        ],
      ),
    );
  }

  _bottomNavigationBarItem({IconData? icon, IconData? active, String? label}) {
    return BottomNavigationBarItem(
        icon: Icon(icon), label: label, activeIcon: Icon(active));
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
