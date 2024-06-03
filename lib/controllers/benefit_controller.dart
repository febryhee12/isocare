import 'package:get/get.dart';
import '../providers/benefit_provider.dart';

class BenefitController extends GetxController with StateMixin<List<dynamic>> {
  dynamic argumentData = Get.arguments;
  var memberId = ''.obs;
  var memberName = ''.obs;

  @override
  void onInit() {
    memberId.value = argumentData[0]['memberId'];
    memberName.value = argumentData[0]['memberName'];

    change(null, status: RxStatus.loading());
    BenefitProvider().fetchBenefit(argumentData[0]['memberId']).then((value) {
      change(value, status: RxStatus.success());
    }, onError: (error) {
      change(null, status: RxStatus.error(error.toString()));
    });

    update();
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
