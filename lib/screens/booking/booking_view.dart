import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:isocare/service/base_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../config.dart';
import '../../helpers/ui_data.dart';
import '../../helpers/widget/button.dart';
import '../../helpers/widget/textfield.dart';
import '../../service/base_client.dart';
import '../../service/base_url.dart';

class BookingView extends StatefulWidget {
  @override
  State<BookingView> createState() => _BookingViewState();
}

class _BookingViewState extends State<BookingView> with BaseController {
  final formKey = GlobalKey<FormState>();

  var selectedDate = DateTime.now().add(const Duration(days: 1));
  // ignore: prefer_typing_uninitialized_variables
  var result;

  // String fdate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  late TextEditingController inputmatters;
  late TextEditingController inputPhone;

  @override
  void initState() {
    super.initState();
    result ??= DateFormat('yyyy-MM-dd')
        .format(DateTime.now().add(const Duration(days: 1)));
    inputmatters = TextEditingController();
    inputPhone = TextEditingController();
  }

  @override
  void dispose() {
    inputmatters.dispose();
    inputPhone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black87, //change your color here
          ),
          backgroundColor: Colors.white,
          elevation: 0.0,
          title:
              const Txt('Reservasi Klinik', TextStyle(color: UIColor.cDark70)),
        ),
        body: SafeArea(
          child: Container(
            height: double.infinity,
            padding: EdgeInsets.all(2.h),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Stack(
              children: [
                Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(bottom: 0.8.h),
                          child: Txt(
                            "Silakan isi form yang tersedia untuk melakukan reservasi klinik",
                            TextStyle(
                              color: UIColor.cDark80,
                              fontWeight: FontWeight.w600,
                              fontSize: 13.sp,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        _inputDate(),
                        _inputMatters(),
                        _inputNumber(),
                        SizedBox(
                          height: 2.5.h,
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: _buttonConfirmation()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputDate() {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Txt('Tanggal Reservasi', TextStyle(fontSize: 12.sp)),
          SizedBox(
            height: 2.h,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0), color: UIColor.cGrey),
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            child: GestureDetector(
              onTap: () async {
                DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime.now().add(const Duration(days: 1)),
                    lastDate: DateTime(2100));

                if (picked == null) return;

                setState(() {
                  selectedDate = picked;
                  result = DateFormat('yyyy-MM-dd').format(selectedDate);
                });
              },
              child: Txt(
                '${selectedDate.day} - ${selectedDate.month} - ${selectedDate.year}',
                TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.normal,
                    color: kPrimaryColor),
              ),
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
        ],
      ),
    );
  }

  Widget _inputMatters() {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: InputTextField(
        hintText: "Keperluan",
        obscureText: false,
        controller: inputmatters,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Wajib di isi';
          } else if (value.length <= 2) {
            return 'Minimal 8 karakter';
          }
          return null;
        },
      ),
    );
  }

  Widget _inputNumber() {
    return InputTextField(
        hintText: "Nomor yang dapat di hubungi",
        obscureText: false,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          FilteringTextInputFormatter.deny(RegExp('[ ]')),
        ],
        validator: (value) {
          if (value!.isEmpty) {
            return 'Wajib di isi';
          } else if (value.length <= 7) {
            return 'Minimal 8 karakter';
          }
          return null;
        },
        controller: inputPhone);
  }

  Widget _buttonConfirmation() {
    return Padding(
      padding: EdgeInsets.only(bottom: 3.h),
      child: ButtonElevated(
        minSize: const Size(double.infinity, 50),
        label: 'Submit',
        textStyle: TextStyle(
            fontSize: 14.sp, color: Colors.white, fontWeight: FontWeight.w600),
        onPressed: () => submitBooking(),
        cButton: kPrimaryColor,
        cBorder: Colors.transparent,
        wBorder: 0,
      ),
    );
  }

  Future<void> submitBooking() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString(BaseUrl.token);
    if (formKey.currentState!.validate()) {
      var response = await BaseClient().postHB(
        BaseUrl.baseUrl,
        BaseUrl.appointment,
        {'Authorization': 'Bearer $token'},
        {
          "consultation_date": result,
          "matters": inputmatters.text,
          "phone_number": inputPhone.text,
        },
      ).catchError(handleError);

      if (response == null) {
        Get.snackbar("Maaf", "Form wajib diisi semua",
            instantInit: false,
            backgroundColor: Colors.white,
            colorText: UIColor.cDark70,
            boxShadows: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 12,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ]);
        await Future.delayed(
            const Duration(seconds: 3), () => Get.closeAllSnackbars());
      } else {
        Get.back();
        Get.snackbar("Berhasil",
            "Mohon tunggu, kami akan menghubungi anda segera, Terima kasih",
            instantInit: false,
            backgroundColor: Colors.white,
            colorText: UIColor.cDark70,
            boxShadows: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 12,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ]);
        await Future.delayed(
            const Duration(seconds: 3), () => Get.closeAllSnackbars());
      }
    }
  }
}
