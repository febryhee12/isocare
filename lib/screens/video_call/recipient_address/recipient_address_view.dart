import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../config.dart';
import '../../../helpers/widget/button.dart';
import '../../../helpers/widget/textfield.dart';
import 'recipient_address_controller.dart';

class MyChromeSafariBrowser extends ChromeSafariBrowser {
  @override
  void onOpened() {
    // print("ChromeSafari browser opened");
  }

  @override
  void onCompletedInitialLoad() {
    // print("ChromeSafari browser initial load completed");
  }

  @override
  void onClosed() {
    // print("ChromeSafari browser closed");
  }
}

class RecipientAddrerssView extends StatelessWidget {
  RecipientAddrerssView({super.key});

  RecipientAddressController controller = Get.put(RecipientAddressController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          iconTheme: const IconThemeData(
            color: kPrimaryColor,
          ),
          backgroundColor: kBackgroundColor,
        ),
        body: body(context),
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
                "Sebelum melakukan konsulatasi, harap isi form alamat pengiriman obat.",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(
                height: 3.h,
              ),
              fieldRecipientName(),
              SizedBox(
                height: 1.h,
              ),
              fieldPhoneNumber(),
              SizedBox(
                height: 1.h,
              ),
              fieldAddress(),
              SizedBox(
                height: 1.h,
              ),
              fieldPostalCode(),
              SizedBox(
                height: 1.h,
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

  fieldRecipientName() {
    return InputTextField(
      hintText: "Nama Penerima",
      keyboardType: TextInputType.name,
      obscureText: false,
      controller: controller.recipientName,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
      ],
      validator: (value) {
        if (value!.isEmpty) {
          return 'Diperlukan';
        }
        if (value.length <= 1) {
          return 'Minimal 2 karakter';
        }
        return null;
      },
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

  fieldAddress() {
    return InputTextField(
      hintText: "Alamat Penerima",
      keyboardType: TextInputType.text,
      maxline: 3,
      obscureText: false,
      controller: controller.address,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Diperlukan';
        }
        return null;
      },
    );
  }

  fieldPostalCode() {
    return InputTextField(
      hintText: "Kode Pos",
      keyboardType: TextInputType.number,
      obscureText: false,
      controller: controller.postalCode,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        FilteringTextInputFormatter.deny(RegExp('[ ]')),
      ],
      validator: (value) {
        if (value!.isEmpty) {
          return 'Diperlukan';
        }
        return null;
      },
    );
  }

  buttonSubmit() {
    return Padding(
      padding: EdgeInsets.only(bottom: 3.h),
      child: ButtonElevated(
        minSize: const Size(double.infinity, 50),
        label: 'Mulai Konsultasi',
        textStyle: TextStyle(
            fontSize: 14.sp, color: Colors.white, fontWeight: FontWeight.w600),
        onPressed: () {
          controller.submitAddress();
        },
        cButton: kPrimaryColor,
        cBorder: Colors.transparent,
        wBorder: 0,
      ),
    );
  }
}
