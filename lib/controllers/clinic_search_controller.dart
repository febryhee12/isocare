import 'package:get/get.dart';
import '../providers/clinic_provider.dart';

class ClinicSearchController extends GetxController
    with StateMixin<List<dynamic>> {
  @override
  void onInit() {
    change(null, status: RxStatus.success());
    super.onInit();
  }

  void search(keyword) {
    change(null, status: RxStatus.loading());
    ClinicProvider().fetchByKeyword(keyword).then((value) {
      change(value, status: RxStatus.success());
    }, onError: (error) {
      change(null, status: RxStatus.error(error.toString()));
    });
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
