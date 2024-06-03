import 'dart:async';
import 'package:get/get.dart';
import '../helpers/url.dart';

class BenefitProvider extends GetConnect {
  Future<List<dynamic>> fetchBenefit(memberId) async {
    final response = await get(
      Uri.parse(getBenefitUrl + '?Id=' + memberId).toString(),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
    );

    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return response.body;
    }
  }
}
