import 'dart:async';
import 'package:get/get.dart';
import '../helpers/url.dart';

class DependentProvider extends GetConnect {
  Future<List<dynamic>> fetchDependent(memberId) async {
    final response = await get(
      Uri.parse(getDependentUrl + '?Id=' + memberId).toString(),
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
