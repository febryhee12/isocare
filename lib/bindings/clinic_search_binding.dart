import 'package:get/get.dart';
import '../controllers/clinic_search_controller.dart';

class ClinicSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ClinicSearchController());
  }
}
