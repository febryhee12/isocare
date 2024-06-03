// ignore_for_file: unrelated_type_equality_checks

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:isocare/screens/video_call/recipient_address/recipient_address_view.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../../config.dart';
import '../../../service/base_client.dart';
import '../../../service/base_controller.dart';
import '../../../service/base_url.dart';
import '../../chat/waitng/waiting_view.dart';
import '../../dashboard/dashboard_view.dart';

class RecipientAddressController extends GetxController with BaseController {
  GetStorage box = GetStorage();
  final ChromeSafariBrowser browser = MyChromeSafariBrowser();

  final formKey = GlobalKey<FormState>();

  late TextEditingController recipientName;
  late TextEditingController phoneNumber;
  late TextEditingController address;
  late TextEditingController postalCode;

  RxBool isCameraPermissionGranted = false.obs;
  RxBool isMicrophonePermissionGranted = false.obs;
  RxBool isStoragePermissionGranted = false.obs;
  RxBool islocationPermissionGranted = false.obs;

  @override
  void onInit() {
    super.onInit();
    permissionHandling();
    recipientName = TextEditingController();
    phoneNumber = TextEditingController();
    address = TextEditingController();
    postalCode = TextEditingController();
  }

  @override
  void dispose() {
    recipientName.dispose();
    phoneNumber.dispose();
    address.dispose();
    postalCode.dispose();
    super.dispose();
  }

  getBack() {
    showDialog(
      barrierDismissible: true,
      context: Get.context!,
      builder: (BuildContext context) => AlertDialog(
        // title: const Text(''),
        content: const Text(
          'Apakah anda yakin untuk mengakhiri konsultasi dengan dokter?',
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => Get.offAll(const DashboardView()),
                  child: Container(
                    child: Text(
                      "Ya",
                      style: TextStyle(fontSize: 12.sp, color: Colors.white),
                    ),
                    decoration: const BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(100))),
                  ),
                ),
                TextButton(
                  onPressed: () => Get.back(),
                  child: SizedBox(
                    child: Text(
                      "Tidak",
                      style: TextStyle(fontSize: 12.sp, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getURLVideoCall() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString(BaseUrl.token);
    var response = await BaseClient().get(BaseUrl.baseUrl, BaseUrl.urlVideoCall,
        {'Authorization': 'Bearer $token'}).catchError(handleError);

    var data = await jsonDecode(response);
    if (data['status'] == true) {
      String urlVideoCall = data['data']['consultation_url'].toString();
      Get.back();
      await browser.open(
        url: Uri.parse(urlVideoCall),
        options: ChromeSafariBrowserClassOptions(
          android: AndroidChromeCustomTabsOptions(
              enableUrlBarHiding: true,
              shareState: CustomTabsShareState.SHARE_STATE_OFF),
          ios: IOSSafariOptions(barCollapsingEnabled: true),
        ),
      );
    } else {
      showDialog(
        barrierDismissible: true,
        context: Get.context!,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Gagal'),
          content: const Text(
            'Silakan coba kembali',
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                  // padding: EdgeInsets.zero,
                  minimumSize: const Size(50, 0),
                  alignment: Alignment.centerLeft),
              onPressed: () => Get.offAll(const DashboardView()),
              child: Text(
                'Kembali',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        ),
      );
    }
  }

  Future<void> submitAddress() async {
    if (formKey.currentState!.validate()) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      var token = pref.getString(BaseUrl.token);
      var response = await BaseClient().postHB(
        BaseUrl.baseUrl,
        BaseUrl.updateAddress,
        {'Authorization': 'Bearer $token'},
        {
          'detail': address.text,
          'recipient_name': recipientName.text,
          'recipient_contact': phoneNumber.text,
          'postal_code': postalCode.text,
        },
      ).catchError(handleError);

      var data = await jsonDecode(response);
      if (data['status'] == true) {
        if (box.read('consult') == 'chat') {
          Get.to(WaitingView());
        } else {
          Get.offAll(const DashboardView());
          getURLVideoCall();
        }
      } else {
        showDialog(
          barrierDismissible: true,
          context: Get.context!,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Gagal'),
            content: const Text(
              'Silakan coba kembali',
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                    // padding: EdgeInsets.zero,
                    minimumSize: const Size(50, 0),
                    alignment: Alignment.centerLeft),
                onPressed: () => Get.back(),
                child: Text(
                  'Kembali',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
        );
      }
    }
    return;
  }

  Future permissionHandling() async {
    Map<Permission, PermissionStatus> status = await [
      Permission.camera,
      Permission.microphone,
      // Permission.location,
      // Permission.storage,
      //add more permission to request here.
    ].request();

// camera
    if (status[Permission.camera] == PermissionStatus.granted) {
      isCameraPermissionGranted.value = true;
    } else if (status[Permission.camera] ==
        PermissionStatus.permanentlyDenied) {
      final result = await Permission.camera.request();
      if (result.isGranted) {
        isCameraPermissionGranted.value = true;
      } else {
        showDialog(
          barrierDismissible: false,
          context: Get.context!,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Akses Kamera'),
            content: const Text(
              'Aplikasi ini membutuhkan akses ke kamera untuk merekam gambar',
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                    // padding: EdgeInsets.zero,
                    minimumSize: const Size(50, 0),
                    alignment: Alignment.centerLeft),
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  'Tolak',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                    // padding: EdgeInsets.zero,
                    minimumSize: const Size(50, 0),
                    alignment: Alignment.centerLeft),
                onPressed: () {
                  Get.back();
                  openAppSettings();
                },
                child: Text(
                  'Pengaturan',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
        );
      }
    }

// microphone
    if (status[Permission.microphone] == PermissionStatus.granted) {
      isMicrophonePermissionGranted.value = true;
    } else if (status[Permission.microphone] ==
        PermissionStatus.permanentlyDenied) {
      final result = await Permission.microphone.request();
      if (result.isGranted) {
        isMicrophonePermissionGranted.value = true;
      } else {
        showDialog(
          barrierDismissible: false,
          context: Get.context!,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Akses Kamera'),
            content: const Text(
              'Aplikasi ini membutuhkan akses ke mikrofon untuk merekam suara',
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                    // padding: EdgeInsets.zero,
                    minimumSize: const Size(50, 0),
                    alignment: Alignment.centerLeft),
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  'Tolak',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                    // padding: EdgeInsets.zero,
                    minimumSize: const Size(50, 0),
                    alignment: Alignment.centerLeft),
                onPressed: () {
                  Get.back();
                  openAppSettings();
                },
                child: Text(
                  'Pengaturan',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
        );
      }
    }

    // storage
    if (status[Permission.storage] == PermissionStatus.granted) {
      isStoragePermissionGranted.value = true;
    } else if (status[Permission.storage] ==
        PermissionStatus.permanentlyDenied) {
      final result = await Permission.storage.request();
      if (result.isGranted) {
        isStoragePermissionGranted.value = true;
      } else {
        showDialog(
          barrierDismissible: false,
          context: Get.context!,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Akses Galleri'),
            content: const Text(
              'Aplikasi ini membutuhkan akses ke galleri',
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                    // padding: EdgeInsets.zero,
                    minimumSize: const Size(50, 0),
                    alignment: Alignment.centerLeft),
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  'Tolak',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                    // padding: EdgeInsets.zero,
                    minimumSize: const Size(50, 0),
                    alignment: Alignment.centerLeft),
                onPressed: () {
                  Get.back();
                  openAppSettings();
                },
                child: Text(
                  'Pengaturan',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
        );
      }
    }

    // location
    if (status[Permission.location] == PermissionStatus.granted) {
      islocationPermissionGranted.value = true;
      return;
    } else if (status[Permission.location] ==
        PermissionStatus.permanentlyDenied) {
      final result = await Permission.location.request();
      if (result.isGranted) {
        islocationPermissionGranted.value = true;
      } else {
        showDialog(
          barrierDismissible: false,
          context: Get.context!,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Akses Lokasi'),
            content: const Text(
              'Aplikasi ini membutuhkan akses lokasi',
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                    // padding: EdgeInsets.zero,
                    minimumSize: const Size(50, 0),
                    alignment: Alignment.centerLeft),
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  'Tolak',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                    // padding: EdgeInsets.zero,
                    minimumSize: const Size(50, 0),
                    alignment: Alignment.centerLeft),
                onPressed: () {
                  Get.back();
                  openAppSettings();
                },
                child: Text(
                  'Pengaturan',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
        );
      }
    }
  }
}
