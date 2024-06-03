import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isocare/screens/root.dart';
import '../providers/auth_provider.dart';
import '../providers/dependent_provider.dart';

class AuthController extends GetxController with StateMixin<List<dynamic>> {
  var isLoggedIn = false.obs;
  var user = {};
  var dependents = [];

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void snackBarError(String msg) {
    Get.snackbar(
      "Pesan",
      msg,
      duration: const Duration(seconds: 1),
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  void login(username, password) async {
    if (username == '' || password == '') {
      snackBarError("Semua data harus diisi");
    } else {
      var response = await auth(username, password);

      if (response.memberId == null) {
        snackBarError("User tidak ditemukan");
      } else {
        change(null, status: RxStatus.loading());
        DependentProvider().fetchDependent(response.memberId).then((value) {
          dependents = value;
          change(null, status: RxStatus.success());
        });

        var birthDateParts = response.birthDate!.split('T');
        var birthDate = birthDateParts[0].trim();

        var effectiveDateParts = response.effectiveDate!.split('T');
        var effectiveDate = effectiveDateParts[0].trim();

        var endPolicyDateParts = response.endPolicyDate!.split('T');
        var endPolicyDate = endPolicyDateParts[0].trim();

        user = {
          'memberId': response.memberId,
          'memberName': response.memberName,
          'isoMemberId': response.isoMemberId,
          'companyId': response.companyId,
          'birthDate': birthDate,
          'gender': response.gender,
          'effectiveDate': effectiveDate,
          'endPolicyDate': endPolicyDate,
        };
        isLoggedIn.value = true;
        update();
      }
    }
  }

  void logout() {
    user = {};
    dependents = [];
    isLoggedIn.value = false;
    update();
    Get.offAll(() => Root());
  }
}
