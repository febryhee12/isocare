import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:isocare/screens/login_isomedik/login_view.dart';
import 'package:sizer/sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/ui_data.dart';
import '../../models/banner_model.dart';
import '../../models/doctor_model.dart';
import '../../models/news_model.dart';
import '../../models/user_model.dart';
import '../../service/app_exceptions.dart';
import '../../service/base_client.dart';
import '../../service/base_controller.dart';
import '../../service/base_url.dart';
import '../option.dart';

class HomeController extends GetxController with BaseController {
  GetStorage box = GetStorage();
  final uiImage = UIImage();
  final uiText = UIText();
  late TextEditingController voucher;
  late TextEditingController inputCode;
  var isLoading = true.obs;
  var profileUser = User(
    id: 0,
    name: '',
    username: '',
    email: '',
    phone: '',
    profileImageLink: 'https://via.placeholder.com/50',
    birthday: '',
    address: '',
    bpjsNumber: '',
    insuranceNumber: '',
    consultationType: '',
    member: MemberModel(
      type: '',
      ktpImageLink: '',
    ),
  ).obs;
  var listDoctor = <ListDoctor>[].obs;
  var listBanner = <BannerModel>[].obs;
  var listNews = <NewsModel>[].obs;
  var dom = 1;

  final information = 'Waktu konsultasi dokter 24 Jam'.obs;

  @override
  void onInit() {
    super.onInit();
    voucher = TextEditingController();
    inputCode = TextEditingController();
    // authLoc();
    expDate();
    fetchUser();
    fetchListDoctor();
    fetchBanner();
    fetchNews();
    onReload();
  }

  Future<void> onReload() async {
    fetchUser();
    fetchListDoctor();
    fetchBanner();
    fetchNews();
  }

  @override
  void dispose() {
    voucher.dispose();
    inputCode.dispose();
    super.dispose();
  }

  Future<void> logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
    Get.offAll(OptionView());
  }

  // Future<void> authLoc() async {
  //   final statusLocation = await Permission.location.request();
  //   if (statusLocation == PermissionStatus.granted) {
  //     return;
  //   } else if (statusLocation == PermissionStatus.permanentlyDenied) {
  //     return;
  //   }
  // }

  // Check Token Expired //

  Future<void> expDate() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? date = pref.getString("expDate");
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd kk:mm:ss').format(now);

    if (date == formattedDate) {
      await pref.clear();
      Get.offAll(LoginView());
      Get.defaultDialog(
        titleStyle: GoogleFonts.sourceSansPro(
          textStyle: TextStyle(fontSize: 13.sp),
        ),
        barrierDismissible: false,
        titlePadding: EdgeInsets.all(2.h),
        title: 'Maaf token anda sudah expired, silakan login kembali',
        content: TextButton(
            onPressed: () {
              Get.back();
            },
            child: Txt('Ok', TextStyle(fontSize: 14.sp))),
      );
    }
  }

//GET USER //
  Future<User?> getUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString(BaseUrl.token);
    var response = await BaseClient().get(BaseUrl.baseUrl, BaseUrl.profileUrl,
        {'Authorization': 'Bearer $token'}).catchError(handleError);

    if (response != null) {
      var jsonStr = json.decode(response);

      return User.fromJson(jsonStr);
    }
    return null;
  }

  Future<void> fetchUser() async {
    var profile = await getUser();
    if (profile != null) {
      try {
        isLoading(true);
        profileUser.value = profile;
        box.write('consult', profileUser.value.consultationType);
      } finally {
        isLoading(false);
      }
    }
  }

//GET LIST DOCTOR //
  Future<List<ListDoctor>?> getListDoctor() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString(BaseUrl.token);
    var response = await BaseClient().get(BaseUrl.baseUrl, BaseUrl.listDoctor,
        {'Authorization': 'Bearer $token'}).catchError(handleError);

    if (response != null) {
      var responData = json.decode(response);
      List<dynamic> arr = responData["data"];
      List<ListDoctor> result = [];
      // ignore: avoid_function_literals_in_foreach_calls
      arr.forEach((x) {
        result.add(ListDoctor.fromJson(x));
      });
      return result;
    } else {
      return null;
    }
  }

  Future<void> fetchListDoctor() async {
    try {
      var doctor = await getListDoctor();
      if (doctor != null) {
        isLoading(true);
        listDoctor.assignAll(doctor);
      }
    } on FetchDataException catch (e) {
      throw Exception(
        {
          // ignore: avoid_print
          print('error caught: $e')
        },
      );
    } finally {
      isLoading(false);
    }
  }

  // GET BANNER //
  Future<List<BannerModel>?> getBanner() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString(BaseUrl.token);
    var response = await BaseClient().get(BaseUrl.baseUrl, BaseUrl.listBanner,
        {'Authorization': 'Bearer $token'});

    var responData = json.decode(response);

    if (response = true) {
      List<dynamic> arr = responData["data"]["data"];
      List<BannerModel> result = [];
      // ignore: avoid_function_literals_in_foreach_calls
      arr.forEach((x) {
        result.add(BannerModel.fromJson(x));
      });
      return result;
    } else {
      return null;
    }
  }

  Future<void> fetchBanner() async {
    try {
      var banner = await getBanner();
      if (banner != null) {
        isLoading(true);
        listBanner.assignAll(banner);
      }
    } on FetchDataException catch (e) {
      throw Exception(
        {
          // ignore: avoid_print
          print('error caught: $e')
        },
      );
    } finally {
      isLoading(false);
    }
  }

  // GET LIST NEWS
  Future<List<NewsModel>?> getNews(int newsCategoryId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString(BaseUrl.token);
    var response = await BaseClient().get(
        BaseUrl.baseUrl,
        BaseUrl.listNewsUrl + "&table=true&sort[id]=desc&filters[source]=VM",
        {'Authorization': 'Bearer $token'});

    var responData = json.decode(response);

    if (response = true) {
      List<dynamic> arr = responData["data"]["data"];
      List<NewsModel> result = [];
      // ignore: avoid_function_literals_in_foreach_calls
      arr.forEach((x) {
        result.add(NewsModel.fromJson(x));
      });
      return result;
    } else {
      return null;
    }
  }

  Future<void> fetchNews() async {
    try {
      var list = await getNews(dom);
      if (list != null) {
        isLoading(true);
        listNews.assignAll(list);
      }
    } on FetchDataException catch (e) {
      throw Exception(
        {
          // ignore: avoid_print
          print('error caught: $e')
        },
      );
    } finally {
      isLoading(false);
    }
  }
}
