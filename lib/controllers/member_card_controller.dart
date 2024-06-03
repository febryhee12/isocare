import 'package:get/get.dart';

class MemberCardController extends GetxController
    with StateMixin<List<dynamic>> {
  dynamic argumentData = Get.arguments;
  var cardNumber = ''.obs;
  var memberId = ''.obs;
  var memberName = ''.obs;
  var birthDate = ''.obs;
  var gender = ''.obs;
  var companyId = ''.obs;
  var endPolicyDate = ''.obs;

  @override
  void onInit() {
    cardNumber.value = argumentData[0]['cardNumber'];
    memberId.value = argumentData[0]['memberId'];
    memberName.value = argumentData[0]['memberName'];
    birthDate.value = argumentData[0]['birthDate'];
    gender.value = argumentData[0]['gender'];
    companyId.value = argumentData[0]['companyId'];
    endPolicyDate.value = argumentData[0]['endPolicyDate'];

    update();
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
