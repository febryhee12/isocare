import 'package:get/get.dart';
import '../controllers/clinic_nearby_controller.dart';

class ClinicNearbyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ClinicNearbyController());
  }
}
