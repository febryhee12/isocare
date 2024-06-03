// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:sizer/sizer.dart';
import '../../config.dart';
import '../../helpers/ui_data.dart';
import '../../helpers/widget/button.dart';
import '../../helpers/widget/textfield.dart';

import './login_controller.dart';

class LoginView extends StatelessWidget {
  LoginController controller = Get.put(LoginController());

  LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                  key: controller.formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 20.0, bottom: 5.h),
                          child: SizedBox(
                            height: 8.h,
                            child: Image.asset('assets/logo.png'),
                          ),
                        ),
                        Txt(
                          "${controller.uiText.labelTagline}",
                          TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.normal,
                              color: UIColor.cDark50),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        _inputUsername(),
                        _inputPassword(),
                        SizedBox(
                          height: 2.5.h,
                        ),
                      ],
                    ),
                  ),
                ),
                Align(alignment: Alignment.bottomCenter, child: _buttonLogin()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputUsername() {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: InputTextField(
        hintText: "${controller.uiText.username}",
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9_]")),
        ],
        obscureText: false,
        controller: controller.username,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Harap di isi';
          } else if (value.length <= 2) {
            return 'Minimal 8 karakter';
          }
          return null;
        },
      ),
    );
  }

  Widget _inputPassword() {
    return Obx(() => Padding(
          padding: EdgeInsets.only(bottom: 2.h),
          child: InputTextField(
            hintText: "${controller.uiText.password}",
            obscureText: controller.hidden.value,
            controller: controller.password,
            suffixIcon: IconButton(
              onPressed: () => controller.hidden.toggle(),
              icon: controller.hidden.value == false
                  ? const Icon(
                      Icons.visibility,
                    )
                  : const Icon(
                      Icons.visibility_off,
                    ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Wajib di isi';
              } else if (value.length <= 7) {
                return 'Minimal 8 karakter';
              }
              return null;
            },
          ),
        ));
  }

  Widget _buttonLogin() {
    return Padding(
      padding: EdgeInsets.only(bottom: 3.h),
      child: ButtonElevated(
        minSize: const Size(double.infinity, 50),
        label: controller.uiText.labelMasuk.value,
        textStyle: TextStyle(
            fontSize: 14.sp, color: Colors.white, fontWeight: FontWeight.w600),
        onPressed: () {
          controller.signIn();
        },
        cButton: kPrimaryColor,
        cBorder: Colors.transparent,
        wBorder: 0,
      ),
    );
  }
}
