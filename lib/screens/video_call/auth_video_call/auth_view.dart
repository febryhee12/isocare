import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:isocare/screens/video_call/auth_video_call/auth_controller.dart';
import 'package:sizer/sizer.dart';

import '../../../config.dart';
import '../../../helpers/widget/button.dart';
import '../../../helpers/widget/textfield.dart';

class AuthVideoCallView extends StatelessWidget {
  AuthVideoCallView({Key? key}) : super(key: key);

  AuthController controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(
          color: kPrimaryColor,
        ),
        backgroundColor: kBackgroundColor,
      ),
      body: Obx(
        () => body(context),
      ),
    );
  }

  body(context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: controller.formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(2.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: 1.h,
              ),
              Text(
                "Harap lengkapi data di bawah ini untuk melakukan kosultasi",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(
                height: 3.h,
              ),
              fieldFullName(),
              SizedBox(
                height: 1.h,
              ),
              fieldPhoneNumber(),
              SizedBox(
                height: 1.h,
              ),
              fieldEmail(),
              SizedBox(
                height: 1.h,
              ),
              dropDownBirthDate(),
              SizedBox(
                height: 3.h,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: buttonSubmit(),
              ),
              SizedBox(
                height: 2.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  fieldFullName() {
    return InputTextField(
      hintText: "Nama Lengkap",
      keyboardType: TextInputType.name,
      obscureText: false,
      controller: controller.name,
      enabled: false,
    );
  }

  fieldPhoneNumber() {
    return InputTextField(
      hintText: "Nomor Telepon",
      keyboardType: TextInputType.phone,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        FilteringTextInputFormatter.deny(RegExp('[ ]')),
      ],
      obscureText: false,
      controller: controller.phoneNumber,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Diperlukan';
        }
        if (value.length <= 8) {
          return 'Minimal 9 karakter';
        }
        return null;
      },
    );
  }

  fieldEmail() {
    return InputTextField(
      hintText: "Email",
      keyboardType: TextInputType.emailAddress,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.deny(RegExp('[ ]')),
      ],
      obscureText: false,
      controller: controller.email,
      validator: (value) => EmailValidator.validate(value!)
          ? null
          : "Harap input email dengan benar",
    );
  }

  dropDownBirthDate() {
    return GestureDetector(
      onTap: () {
        controller.chooseDate();
      },
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 54,
          ),
          Stack(
            children: [
              Container(
                height: 48,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 3.h, vertical: 2.3.h),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(width: 1, color: Colors.grey)),
              ),
            ],
          ),
          Positioned(
            top: 0,
            left: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              margin: const EdgeInsets.only(bottom: 20),
              alignment: Alignment.topLeft,
              color: Colors.white,
              child: Text(
                "Tanggal Lahir",
                style: TextStyle(fontSize: 10.sp),
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 20,
            child: Text(DateFormat("dd-MM-yyyy")
                .format(controller.selectedDate.value)
                .toString()),
          )
        ],
      ),
    );
  }

  buttonSubmit() {
    return Padding(
      padding: EdgeInsets.only(bottom: 3.h),
      child: ButtonElevated(
        minSize: const Size(double.infinity, 50),
        label: 'Lanjut',
        textStyle: TextStyle(
            fontSize: 14.sp, color: Colors.white, fontWeight: FontWeight.w600),
        onPressed: () {
          controller.submit();
        },
        cButton: kPrimaryColor,
        cBorder: Colors.transparent,
        wBorder: 0,
      ),
    );
  }
}
