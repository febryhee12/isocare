import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isocare/bindings/auth_binding.dart';
import 'package:isocare/screens/dashboard/dashboard_view.dart';
import 'package:isocare/screens/option.dart';
import 'package:isocare/config.dart';
import 'package:isocare/service/base_url.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart' as sand;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

late sand.SendbirdSdk sendbird;

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChannels.textInput.invokeMethod('TextInput.hide');
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [
      SystemUiOverlay.bottom,
      SystemUiOverlay.top,
    ],
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Init.instance.initialize(),
      builder: (context, AsyncSnapshot snapshot) {
        // Show splash screen while waiting for app resources to load:
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Sizer(
            builder: (context, portrait, screentype) {
              SizerUtil.deviceType == DeviceType.mobile
                  ? Container(
                      width: 100.h,
                      height: 20.h,
                    )
                  : Container(
                      width: 100.w,
                      height: 12.5.h,
                    );
              return const GetMaterialApp(
                debugShowCheckedModeBanner: false,
                home: Splash(),
              );
            },
          );
        } else {
          return Sizer(
            builder: (context, portrait, screentype) {
              SizerUtil.deviceType == DeviceType.mobile
                  ? Container(
                      width: 100.h,
                      height: 20.h,
                    )
                  : Container(
                      width: 100.w,
                      height: 12.5.h,
                    );
              return GetMaterialApp(
                // bind our app with the  Getx Controller
                enableLog: false,
                debugShowCheckedModeBanner: false,
                initialBinding: AuthBinding(),
                theme: ThemeData(
                  textTheme: GoogleFonts.latoTextTheme(
                    Theme.of(context).textTheme,
                  ),
                ),
                home: OptionView(),
              );
            },
          );
        }
      },
    );
  }
}

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Center(
        child: SizedBox(
          width: 40.h,
          child: Image.asset('assets/logo.png'),
        ),
      ),
    );
  }
}

class Init {
  Init._();
  static final instance = Init._();

  Future initialize() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString(BaseUrl.token);

    await Future.delayed(const Duration(seconds: 2));
    if (token != null) {
      Get.to(DashboardView());
    }
  }
}
