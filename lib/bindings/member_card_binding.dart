import 'package:get/get.dart';
import '../controllers/member_card_controller.dart';

class MemberCardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MemberCardController());
  }
}
