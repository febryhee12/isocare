import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:isocare/screens/beranda/home_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../service/base_client.dart';
import '../../../service/base_url.dart';
import '../recipient_address/recipient_address_view.dart';
import '/service/base_controller.dart';

class AuthController extends GetxController with BaseController {
  final formKey = GlobalKey<FormState>();
  HomeController homeController = Get.put(HomeController());

  String formatDate =
      DateFormat("dd-MM-yyyy").format(DateTime.now()).toString();
  var selectedDate = DateTime.now().obs;

  late var nameFill = homeController.profileUser.value.name;
  late var emailFill = homeController.profileUser.value.email;
  late var typeFill = homeController.profileUser.value.type;
  late var addressFill = homeController.profileUser.value.address ?? 'rumah';
  late var birthDateFill = homeController.profileUser.value.birthday;
  late var phoneFill = homeController.profileUser.value.phone;
  late TextEditingController name;
  late TextEditingController email;
  late TextEditingController phoneNumber;
  String? insuranceType;

  @override
  void onInit() {
    super.onInit();
    name = TextEditingController(text: nameFill);
    phoneNumber = TextEditingController(text: phoneFill);
    email = TextEditingController(text: emailFill);
    if (typeFill == null) {
      insuranceType = 'public';
    } else {
      insuranceType = typeFill;
    }
    selectedDate.value = DateTime.parse(birthDateFill);
    formatDate = DateFormat("yyyy-MM-dd").format(selectedDate.value).toString();
  }

  @override
  void dispose() {
    phoneNumber.dispose();
    email.dispose();
    super.dispose();
  }

  Future<void> chooseDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: Get.context!,
        initialDate: selectedDate.value,
        firstDate: DateTime(1950),
        lastDate: DateTime.now());
    if (pickedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate;
      formatDate =
          DateFormat("yyyy-MM-dd").format(selectedDate.value).toString();
    }
  }

  Future<void> submit() async {
    if (formKey.currentState!.validate()) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      var token = pref.getString(BaseUrl.token);
      print(typeFill);
      print(email.text);
      print(phoneNumber.text);
      print(formatDate);

      var response = await BaseClient().postHB(
        BaseUrl.baseUrl,
        BaseUrl.updateData,
        {'Authorization': 'Bearer $token'},
        {
          'email': email.text,
          'address': addressFill,
          'phone': phoneNumber.text,
          'member[type]': typeFill,
          'member[birthday]': formatDate,
        },
      ).catchError(handleError);
      print(response);
      var data = await jsonDecode(response);
      if (data['status'] == true) {
        Get.off(RecipientAddrerssView());
      } else {
        showDialog(
          barrierDismissible: true,
          context: Get.context!,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Gagal'),
            content: const Text(
              'Silakan coba kembali',
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                    // padding: EdgeInsets.zero,
                    minimumSize: const Size(50, 0),
                    alignment: Alignment.centerLeft),
                onPressed: () => Get.back(),
                child: Text(
                  'Kembali',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
        );
      }
    }
    return;
  }
}
