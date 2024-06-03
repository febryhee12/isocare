import 'dart:async';
import 'dart:convert';

import 'package:date_count_down/countdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../helpers/ui_data.dart';
import '../../../models/chat_model.dart';
import '../../../service/base_client.dart';
import '../../../service/base_url.dart';
import '../../../service/notification_service.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:sendbird_sdk/sendbird_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../config.dart';
import '../../helpers/widget/button.dart';
import 'chat_view_model.dart';
import 'end/end_view.dart';
import 'widget/admin_messsage_item.dart';
import 'widget/file_message.dart';
import 'widget/message_input.dart';
import 'widget/user_message_item.dart';

// ignore: must_be_immutable
class ChatView extends StatefulWidget {
  GroupChannel channel;
  String endTime;
  String doctor;
  int id;
  dynamic status;
  String image;
  String channelUrl;

  ChatView(
      {required this.channel,
      required this.endTime,
      required this.doctor,
      required this.id,
      required this.status,
      required this.image,
      required this.channelUrl,
      Key? key})
      : super(key: key);
  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView>
    with ChannelEventHandler, WidgetsBindingObserver {
  late ChannelViewModel model;
  late Timer _timer;
  String countdown = '';
  bool _show = true;
  bool channelLoaded = false;

  @override
  void initState() {
    super.initState();
    model = ChannelViewModel(widget.channelUrl, widget.channel, widget.id);
    model.loadChannel().then((value) {
      setState(() {
        channelLoaded = true;
      });
      model.loadMessages(reload: true);
    });
    tz.initializeTimeZones();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.inactive:
        setState(() {
          channelLoaded = true;
        });
        model.loadMessages(reload: true);
        break;
      case AppLifecycleState.resumed:
        setState(() {
          channelLoaded = true;
        });
        model.loadMessages(reload: true);
        NotificationServices().cancelAllNotifications();
        break;
      case AppLifecycleState.paused:
        setState(() {
          channelLoaded = true;
        });
        model.loadMessages(reload: true);
        break;
      default:
        setState(() {
          channelLoaded = true;
        });
        model.loadMessages(reload: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (countdown == '0') {
      _timer.cancel();
      showAlret();
    } else {
      countdown = CountDown()
          .timeLeft(DateTime.parse(widget.endTime), '0', showLabel: false);
    }

    return ChangeNotifierProvider<ChannelViewModel>(
      create: (context) => model,
      key: const Key('channel_key'),
      child: WillPopScope(
        onWillPop: () async => _onWillPop(),
        child: Scaffold(
          backgroundColor: Colors.grey.shade200,
          appBar: _buildNavigationBar(),
          body: SafeArea(
            child: _show == false
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.0.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Txt(
                          "Maaf, konsultasi anda sudah berakhir",
                          TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 2.0.h,
                        ),
                        _buttonOut(),
                      ],
                    ),
                  )
                : Column(
                    children: [
                      Consumer<ChannelViewModel>(
                        builder: (context, value, child) {
                          return _buildContent();
                        },
                      ),
                      Selector<ChannelViewModel, bool>(
                        selector: (_, model) => model.isEditing,
                        builder: (c, editing, child) {
                          return MessageInput(
                            onPressPlus: () {
                              model.showPlusMenu(context);
                            },
                            onPressSend: (text) {
                              model.onSendUserMessage(text);
                            },
                            onChanged: (text) {
                              model.onTyping(text != '');
                            },
                            placeholder: model.selectedMessage?.message,
                            isEditing: editing,
                          );
                        },
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  AppBar _buildNavigationBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 4.h,
            width: 4.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: UIColor.mateWhite,
              image: DecorationImage(
                  image: NetworkImage(widget.image), fit: BoxFit.cover),
            ),
          ),
          SizedBox(width: 1.2.h),
          Txt(
            widget.doctor,
            TextStyle(fontSize: 16.sp, color: UIColor.cDark80),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Expanded(
      child: Container(
        color: Colors.white,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 5.2.h),
              child: ListView.builder(
                controller: model.lstController,
                itemCount: model.itemCount,
                shrinkWrap: true,
                reverse: true,
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                itemBuilder: (context, index) {
                  if (index == model.messages.length && model.hasNext) {
                    return const Center(
                      child: SizedBox(
                        width: 30,
                        height: 30,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  final message = model.messages[index];
                  final prev = (index < model.messages.length - 1)
                      ? model.messages[index + 1]
                      : null;
                  if (message.message == "EXITCHAT") {
                    _show = false;
                  }
                  // if (message.message == "DELIVERY") {
                  //   _show = false;
                  //   _showDelivery = false;
                  // }
                  final next = index == 0 ? null : model.messages[index - 1];
                  if (message is FileMessage) {
                    return FileMessageItem(
                      curr: message,
                      prev: prev,
                      next: next,
                      model: model,
                      isMyMessage: message.isMyMessage,
                      onPress: (pos) {
                        //
                      },
                      onLongPress: (pos) {
                        model.showMessageMenu(
                          context: context,
                          message: message,
                          pos: pos,
                        );
                      },
                    );
                  } else if (message is AdminMessage) {
                    return AdminMessageItem(curr: message, model: model);
                  } else if (message is UserMessage) {
                    return UserMessageItem(
                      curr: message,
                      prev: prev,
                      next: next,
                      model: model,
                      isMyMessage: message.isMyMessage,
                      onPress: (pos) {
                        //
                      },
                      onLongPress: (pos) {
                        model.showMessageMenu(
                          context: context,
                          message: message,
                          pos: pos,
                        );
                      },
                    );
                  } else {
                    //undefined message type
                    return Container();
                  }
                },
              ),
            ),
            Visibility(
              visible: _show,
              child: AnimatedOpacity(
                  opacity: _show ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: _showTimer()),
            ),
          ],
        ),
      ),
    );
    // });
    // );
  }

  Widget _buttonOut() {
    return SizedBox(
      width: double.infinity,
      height: 48.0,
      child: ButtonElevated(
        minSize: const Size(double.infinity, 50),
        label: "Keluar",
        textStyle: TextStyle(
            fontSize: 14.sp, color: Colors.white, fontWeight: FontWeight.w600),
        onPressed: () {
          Get.offAll(EndChatView());
        },
        cButton: kPrimaryColor,
        cBorder: Colors.transparent,
        wBorder: 0,
      ),
    );
  }

  Widget _showTimer() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.2.h, horizontal: 1.h),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.h),
        height: 7.h,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 12,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 1),
              child: Txt(' Waktu percakapan akan berakhir dalam ',
                  TextStyle(fontSize: 10.sp, color: UIColor.cDark80)),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: UIColor.countdown,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 12,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Align(
                alignment: Alignment.center,
                child: Txt(
                  countdown,
                  TextStyle(
                      fontSize: 13.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Txt(
              'Mohon Maaf',
              TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
            content:
                Txt('Harap selesaikan percakapan', TextStyle(fontSize: 12.sp)),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Txt(
                    'OK', TextStyle(fontSize: 14.sp, color: UIColor.primary)),
              ),
            ],
          ),
        )) ??
        false;
  }

  Future<ChatModel?> endChat() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString(BaseUrl.token);
    var response = await BaseClient().get(
        BaseUrl.baseUrl,
        BaseUrl.endChat + widget.id.toString(),
        {'Authorization': 'Bearer $token'});

    var jsonStr = response;

    if (response = true) {
      return ChatModel.fromJson(json.decode(jsonStr)['data']);
    }
    return response;
  }

  void showAlret() async {
    await Future.delayed(const Duration(microseconds: 1));
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Txt('Terima Kasih',
              TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
          content: Txt('Waktu konsultasi anda sudah berakhir',
              TextStyle(fontSize: 12.sp)),
          actions: [
            TextButton(
              child:
                  Txt('OK', TextStyle(fontSize: 14.sp, color: UIColor.primary)),
              onPressed: () {
                // endChat();
                Get.offAll(EndChatView());
              },
            ),
          ],
        );
      },
    );
  }
}
