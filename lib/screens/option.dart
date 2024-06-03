import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isocare/screens/dashboard/dashboard_view.dart';
import 'package:isocare/screens/login_isomedik/login_view.dart';
import 'package:isocare/screens/root.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../helpers/ui_data.dart';
import '../service/base_url.dart';

class OptionView extends StatefulWidget {
  @override
  State<OptionView> createState() => _OptionViewState();
}

class _OptionViewState extends State<OptionView> {
  @override
  void initState() {
    super.initState();
    // validate();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/bg.png"),
                    fit: BoxFit.cover),
              ),
            ),
            Align(
                alignment: Alignment.topCenter,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 15.h),
                      child: SizedBox(
                          width: 40.h, child: Image.asset('assets/logo.png')),
                    ),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 5.h,
                  ),
                  _buttonISOMedic(),
                  // SizedBox(
                  //   height: 2.h,
                  // ),
                  // _buttonPesertaAsuransi(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                      child: Image.asset('assets/layanan-bebas-pulsa.png',
                          fit: BoxFit.cover),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buttonPesertaAsuransi() {
    return GestureDetector(
      onTap: () => Get.to(Root()),
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          height: 100,
          child: Row(
            children: [
              Center(
                child: ClipRRect(
                  child: Image.asset("assets/reliance.png"),
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(4),
                      topLeft: Radius.circular(4)),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: 12.0, left: 10.0),
                  alignment: Alignment.topLeft,
                  child: ListTile(
                    title: Txt(
                      "Peserta Asuransi",
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Txt("Diperuntukan untuk melihat isi kartu anggota",
                          TextStyle(fontSize: 11.sp)),
                    ),
                  ),
                ),
                flex: 8,
              ),
            ],
          ),
        ),
        elevation: 8,
        margin: EdgeInsets.all(10),
      ),
    );
  }

  Widget _buttonISOMedic() {
    return GestureDetector(
      onTap: () => Get.to(LoginView()),
      child: Card(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          height: 100,
          child: Row(
            children: [
              Center(
                child: ClipRRect(
                  child: Image.asset("assets/isocare.png"),
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(4),
                      topLeft: Radius.circular(4)),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(top: 12.0, left: 10.0),
                  alignment: Alignment.topLeft,
                  child: ListTile(
                    title: Txt(
                        "ISOcare",
                        TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14.sp)),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Txt(
                        "Dapat melakukan konsultasi dengan dokter klinik",
                        TextStyle(fontSize: 11.sp),
                      ),
                    ),
                  ),
                ),
                flex: 8,
              ),
            ],
          ),
        ),
        elevation: 8,
        margin: EdgeInsets.all(10),
      ),
    );
  }

  Future<void> validate() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString(BaseUrl.token);

    print(token);

    if (token != null) {
      Get.offAll(DashboardView());
    }
  }
}
