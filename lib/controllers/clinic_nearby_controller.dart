// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';
import '../providers/clinic_provider.dart';

class ClinicNearbyController extends GetxController
    with StateMixin<List<dynamic>> {
  var currentLocation = ''.obs;

  void snackBarError(String msg) {
    Get.snackbar(
      "Pesan",
      msg,
      duration: const Duration(seconds: 1),
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  @override
  void onInit() {
    requestLocationPermission();
    Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    ).then((Position position) {
      getAddressFromLatLong(position);
      search(position);
    });
    super.onInit();
  }

  void search(position) {
    change(null, status: RxStatus.loading());
    if (position.latitude.toString() == null ||
        position.longitude.toString() == null) {
      snackBarError(
          "Lokasi tidak ditemukan, Izinkan pencarian lokasi terlebih dahulu");
    }
    ClinicProvider()
        .fetchByCoordinate(
            position.latitude.toString(), position.longitude.toString())
        .then((value) {
      change(value, status: RxStatus.success());
    }, onError: (error) {
      change(null, status: RxStatus.error(error.toString()));
    });
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  Future<void> requestLocationPermission() async {
    final status = await Permission.location.request();
    if (status == PermissionStatus.granted) {
      await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      ).then((Position position) {
        getAddressFromLatLong(position);
        search(position);
      });
      // print('Permission Granted');
    } else if (status == PermissionStatus.denied) {
      // print('Permission denied');
      snackBarError(
          "Lokasi tidak ditemukan, Izinkan pencarian lokasi terlebih dahulu");
    } else if (status == PermissionStatus.permanentlyDenied) {
      // print('Permission Permanently Denied');
      snackBarError(
          "Lokasi tidak ditemukan, Izinkan pencarian lokasi terlebih dahulu");
      await openAppSettings();
    }
  }

  Future<void> getAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks[0];
    if (position.latitude == null || position.longitude == null) {
      currentLocation.value =
          'Tidak ditemukan, Pencarian lokasi tidak diizinkan';
    } else {
      currentLocation.value =
          '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    }
    update();
  }
}
