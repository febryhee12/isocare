import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../../../helpers/ui_data.dart';
import '../../../../models/chat_model.dart';
import '../../../../service/base_client.dart';
import '../../../../service/base_controller.dart';
import '../../../../service/base_url.dart';
import '../../../main.dart';
import '../../dashboard/dashboard_view.dart';
import '../chat_view.dart';

class WaitingSupportView extends StatefulWidget {
  @override
  State<WaitingSupportView> createState() => _WaitingSupportViewState();
}

class _WaitingSupportViewState extends State<WaitingSupportView>
    with ChannelEventHandler, BaseController {
  var chatUser = ChatModelAdmin(
    channelUrl: '',
    endChat: '',
    memberSendbirdUserId: '',
    status: 0,
    adminId: 0,
    adminName: '',
    adminProfileImageLink: '',
    adminSendbirdUserId: '',
    memberId: 0,
  );

  late GroupChannel channel;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(5.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    child: Lottie.asset('assets/support.json'),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  'Harap Menunggu',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.sourceSansPro(
                      textStyle: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.normal)),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  'Anda akan terhubung dengan admin',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.sourceSansPro(
                      textStyle: TextStyle(
                          fontSize: 15.sp, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getKey();
    loadingChat();
    SendbirdSdk().addChannelEventHandler('channel_listener', this);
  }

  Future loadingChat() async {
    var duration = Duration(seconds: 3);
    return Timer(duration, loadChat);
  }

  Future<void> route() async {
    // ignore: unnecessary_null_comparison
    if (chatUser.memberSendbirdUserId == null) {
      Get.back();
    } else {
      await sendbird.connect(chatUser.memberSendbirdUserId);
      GroupChannel.getChannel(chatUser.channelUrl).then((channel) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatView(
                      channel: channel,
                      endTime: chatUser.endChat,
                      doctor: chatUser.adminName,
                      id: chatUser.memberId,
                      status: chatUser.status,
                      image: chatUser.adminProfileImageLink,
                      channelUrl: chatUser.channelUrl,
                    )));
      }).catchError((e) {
        //handle error
        print('channel_list_view: gotoChannel: ERROR: $e');
      });
    }
  }

  @override
  void dispose() {
    SendbirdSdk().removeChannelEventHandler("chat");
    super.dispose();
  }

  Future<ChatModelAdmin?> postChat() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString(BaseUrl.token);
    var response = await BaseClient().postH(
        BaseUrl.baseUrl,
        BaseUrl.supportChat,
        {'Authorization': 'Bearer $token'}).catchError(handleError);

    var jsonStr = response;

    print('Coba cetak $response');
    if (response != null) {
      return ChatModelAdmin.fromJson(json.decode(jsonStr)['data']);
    } else {
      return Get.defaultDialog(
        titleStyle: GoogleFonts.sourceSansPro(
          textStyle: TextStyle(fontSize: 13.sp),
        ),
        barrierDismissible: false,
        titlePadding: EdgeInsets.all(2.h),
        title:
            'Maaf untuk saat ini semua admin sedang melayani peserta lain, silakan mencoba kembali beberpa saat lagi',
        content: TextButton(
            onPressed: () => Get.to(DashboardView()),
            child: Txt('Kembali', TextStyle(fontSize: 14.sp))),
      );
    }
  }

  Future<void> loadChat() async {
    var chat = await postChat();
    if (chat != null) {
      chatUser = chat;
      route();
    }
    return;
  }

  Future<void> getKey() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString(BaseUrl.token);
    var response = await BaseClient().postHB(BaseUrl.baseUrl, BaseUrl.getKey,
        {'Authorization': 'Bearer $token'}, {'name': 'sendbird_app_id'});

    final appKeyId = await jsonDecode(response);

    print(" ${appKeyId["data"]}");

    if (response = true) {
      sendbird = SendbirdSdk(appId: appKeyId['data']);
    } else {
      return Get.defaultDialog(
        titleStyle: GoogleFonts.sourceSansPro(
          textStyle: TextStyle(fontSize: 13.sp),
        ),
        barrierDismissible: false,
        titlePadding: EdgeInsets.all(2.h),
        title:
            'Maaf untuk saat ini semua admin sedang melayani peserta lain, silakan mencoba kembali beberpa saat lagi',
        content: TextButton(
            onPressed: () => Get.to(DashboardView()),
            child: Txt('Kembali', TextStyle(fontSize: 14.sp))),
      );
    }
  }
}
