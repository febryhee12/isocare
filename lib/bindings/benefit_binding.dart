import 'package:get/get.dart';
import '../controllers/benefit_controller.dart';

class BenefitBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BenefitController());
  }
}
