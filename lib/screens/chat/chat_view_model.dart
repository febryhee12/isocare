import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:isocare/screens/chat/end/end_view.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import '../../models/chat_model.dart';
import '../../service/base_client.dart';
import '../../service/base_url.dart';
import '../../service/notification_service.dart';
import '../../styles/color.dart';
import '../../utility/debouncer.dart';
import 'widget/attachment_modal.dart';
import 'widget/message_item.dart';

enum PopupMenuType { copy }
// enum UserEngagementState { typing, online, last_seen, none }

class ChannelViewModel
    with
        ChangeNotifier,
        ChannelEventHandler,
        ConnectionEventHandler,
        WidgetsBindingObserver {
  List<BaseMessage> _messages = [];
  late GroupChannel channel;
  late String channelUrl;
  File? uploadFile;

  BaseMessage? selectedMessage;

  User currentUser = sendbird.currentUser!;

  bool hasNext = false;
  bool isLoading = false;
  bool isDisposed = false;
  bool isEditing = false;
  int id;

  final ScrollController lstController = ScrollController();
  final readDebouncer = Debouncer(milliseconds: 1000);
  Timer? _typingTimer;

  int get itemCount => hasNext ? _messages.length + 1 : _messages.length;
  bool get displayOnline => channel.members.length == 2;

  List<BaseMessage> get messages => _messages;

  ChannelViewModel(this.channelUrl, this.channel, this.id) {
    sendbird.addChannelEventHandler('channel_listener', this);
    lstController.addListener(_scrollListener);
    // channel.markAsRead();
  }

  @override
  void dispose() async {
    super.dispose();
    sendbird.removeChannelEventHandler('channel_listener');
    channel.endTyping();
    isDisposed = true;
  }

  // void setEditing(bool value) {
  //   final prev = isEditing;
  //   isEditing = value;
  //   if (value != prev) notifyListeners();
  // }

  Future<void> loadChannel() async {
    channel = await GroupChannel.getChannel(channelUrl);
    channel.markAsRead();
  }

  Future<void> loadMessages({
    int? timestamp,
    bool reload = false,
  }) async {
    if (isLoading) {
      return;
    }

    isLoading = true;

    final ts = reload
        ? DateTime.now().millisecondsSinceEpoch
        : timestamp ?? DateTime.now().millisecondsSinceEpoch;

    try {
      final params = MessageListParams()
        ..isInclusive = false
        ..includeThreadInfo = true
        ..reverse = true
        ..previousResultSize = 60;
      final messages = await channel.getMessagesByTimestamp(ts, params);
      _messages = reload ? messages : _messages + messages;
      hasNext = messages.length == 20;
      isLoading = false;
      if (!isDisposed) notifyListeners();
    } catch (e) {
      isLoading = false;
      // print('group_channel_view.dart: getMessages: ERROR: $e');
    }
  }

  void onSendUserMessage(String message) async {
    if (message == '') {
      return;
    }

    final preMessage = channel.sendUserMessageWithText(message.trim(),
        onCompleted: (msg, error) {
      // messages.repl(0, msg);
      final index =
          _messages.indexWhere((element) => element.requestId == msg.requestId);
      if (index != -1) _messages.removeAt(index);
      _messages = [msg, ..._messages];
      _messages.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      markAsReadDebounce();
      if (!isDisposed) notifyListeners();
    });

    _messages = [preMessage, ..._messages];
    if (!isDisposed) notifyListeners();

    lstController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void onSendFileMessage(File file) async {
    final params = FileMessageParams.withFile(file);
    final preMessage =
        channel.sendFileMessage(params, onCompleted: (msg, error) {
      final index =
          _messages.indexWhere((element) => element.requestId == msg.requestId);
      if (index != -1) _messages.removeAt(index);
      _messages = [msg, ..._messages];
      _messages.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      markAsReadDebounce();
      if (!isDisposed) notifyListeners();
    });

    _messages = [preMessage, ..._messages];
    if (!isDisposed) notifyListeners();

    lstController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void onUpdateMessage(String? updateText) async {
    isEditing = false;

    if (updateText == null) {
      selectedMessage = null;
      notifyListeners();
      return;
    }

    if (selectedMessage == null) return;

    try {
      await channel.updateUserMessage(
          selectedMessage!.messageId, UserMessageParams(message: updateText));
      selectedMessage = null;
      notifyListeners();
    } catch (e) {
      selectedMessage = null;
    }
  }

  void onTyping(bool hasText) {
    if (!hasText) {
      channel.endTyping();
    } else {
      channel.startTyping();
      _typingTimer?.cancel();
      _typingTimer = Timer(const Duration(milliseconds: 3000), () {
        channel.endTyping();
      });
    }
  }

  Future<GroupChannel> createChannel(String userId) {
    try {
      final params = GroupChannelParams()
        ..operatorUserIds = [currentUser.userId]
        ..userIds = [userId, currentUser.userId]
        ..isDistinct = true;
      final newChannel = GroupChannel.createChannel(params);
      return newChannel;
    } catch (e) {
      rethrow;
    }
  }

  void onCopyText(String text) {
    Clipboard.setData(ClipboardData(text: text));
  }

  MessageState getMessageState(BaseMessage message) {
    if (message.sendingStatus != MessageSendingStatus.succeeded) {
      return MessageState.none;
    }

    final readAll = channel.getUnreadMembers(message).isEmpty;
    final deliverAll = channel.getUndeliveredMembers(message).isEmpty;

    if (readAll) {
      return MessageState.read;
    } else if (deliverAll) {
      return MessageState.delivered;
    } else {
      return MessageState.none;
    }
  }

  // ui helpers

  // void showProfile(BuildContext context, Sender? sender) async {
  //   if (sender == null) return;

  //   final modal = ProfileModal(ctx: context, user: sender);
  //   final goToChannel = await modal.show();
  //   if (goToChannel) {
  //     final newChannel = await createChannel(sender.userId);
  //     Navigator.popAndPushNamed(
  //       context,
  //       '/channel',
  //       arguments: newChannel.channelUrl,
  //     );
  //   }
  // }

  void showPlusMenu(BuildContext context) async {
    final modal = AttachmentModal(context: context);
    final file = await modal.getFile();
    if (file != null) onSendFileMessage(file);
  }

  void showMessageMenu({
    required BuildContext context,
    required BaseMessage message,
    required Offset pos,
  }) async {
    List<PopupMenuEntry> items = [];
    if (message is UserMessage) {
      items.add(_buildPopupItem(
        'Copy',
        'assets/iconCopy@3x.png',
        PopupMenuType.copy,
      ));
    }

    if (items.isEmpty) return;

    selectedMessage = message;

    double x = pos.dx, y = pos.dy;
    final height = MediaQuery.of(context).size.height;
    if (height - pos.dy <= height / 3) y = pos.dy - 140;

    final selected = await showMenu(
        context: context,
        // initialValue: PopupMenuType.edit,
        position: RelativeRect.fromLTRB(x, y, pos.dx + 1, pos.dy + 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        items: items);

    switch (selected) {
      case PopupMenuType.copy:
        onCopyText(message.message);
        selectedMessage = null;
        break;
      default:
        selectedMessage = null;
        break;
    }
  }

  // Future _showDeleteConfirmation(BuildContext context) async {
  //   // set up the buttons
  //   Widget cancelButton = TextButton(
  //     child: Text("Cancel"),
  //     onPressed: () {
  //       Navigator.pop(context);
  //     },
  //   );
  // }

  PopupMenuEntry _buildPopupItem(
      String text, String imageName, PopupMenuType value) {
    return PopupMenuItem(
        height: 40,
        child: Container(
          constraints: const BoxConstraints(minWidth: 180),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(text),
              const SizedBox(width: 8),
              ImageIcon(
                AssetImage(imageName),
                color: SBColors.primary_300,
              )
            ],
          ),
        ),
        value: value);
  }

  _scrollListener() {
    if (lstController.offset >= lstController.position.maxScrollExtent &&
        !lstController.position.outOfRange &&
        !isLoading) {
      final offset = lstController.offset;

      loadMessages(
        timestamp: _messages.last.createdAt,
      );

      lstController.animateTo(
        offset,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    }
    if (lstController.offset <= lstController.position.minScrollExtent &&
        !lstController.position.outOfRange) {
      //reach bottom
    }
  }

  // handlers

  void markAsReadDebounce() {
    channel.markAsRead();
    readDebouncer.run(() => channel.markAsRead());
  }

  @override
  Future<void> onMessageReceived(
      BaseChannel channel, BaseMessage message) async {
    if (channel.channelUrl != this.channel.channelUrl) return;
    final index = _messages.indexWhere((e) => e.messageId == message.messageId);
    _messages = [..._messages];

    if (index != -1 && _messages.isNotEmpty) {
      _messages.removeAt(index);
      _messages[index] = message;
    } else if (message.message == "EXITCHAT") {
      try {
        return Get.offAll(EndChatView());
      } catch (e) {
        // print('EXITCHAT Failed $e');
        message.message;
      }
    } else if (message.message == "DELIVERY") {
      try {
        return Get.offAll(EndChatView());
      } catch (e) {
        // print('DELIVERY Failed $e');
        message.message;
      }
    }
    // else if (message.message == "EXTEND") {
    //   try {
    //     return Get.offAllNamed(utility.RouteName.waiting);
    //   } catch (e) {
    //     print('EXTEND Failed $e');
    //     message.message;
    //   }
    // }
    else {
      _messages.insert(0, message);
    }

    markAsReadDebounce();
    notifyListeners();

    NotificationServices().showNotification(
        2,
        "ISOCare",
        message.message != 'EXITCHAT'
            ? message.message
            : 'Dokter sudah mengakhiri percakapan anda',
        5);
  }

  Future<ChatModel?> endChat() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString(BaseUrl.token);
    var response = await BaseClient().get(BaseUrl.baseUrl,
        BaseUrl.endChat + id.toString(), {'Authorization': 'Bearer $token'});

    var jsonStr = response;

    if (response = true) {
      return ChatModel.fromJson(json.decode(jsonStr)['data']);
    }
    return response;
  }

  @override
  void onMessageUpdated(BaseChannel channel, BaseMessage message) {
    if (channel.channelUrl != this.channel.channelUrl) return;
    final index = _messages.indexWhere((e) => e.messageId == message.messageId);
    _messages = [..._messages];
    if (index != -1 && _messages.isNotEmpty) {
      _messages.removeAt(index);
      _messages[index] = message;
    } else {
      _messages.insert(0, message);
    }

    notifyListeners();
  }

  @override
  void onMessageDeleted(BaseChannel channel, int messageId) {
    _messages = [..._messages];
    _messages.removeWhere((e) => e.messageId == messageId);
    notifyListeners();
  }

  @override
  void onReadReceiptUpdated(GroupChannel channel) {
    _messages = [..._messages];
    notifyListeners();
  }

  @override
  void onDeliveryReceiptUpdated(GroupChannel channel) {
    _messages = [..._messages];
    notifyListeners();
  }

  @override
  void onChannelChanged(BaseChannel channel) {
    notifyListeners();
  }

  @override
  void onTypingStatusUpdated(GroupChannel channel) {
    if (channel.channelUrl == this.channel.channelUrl) {
      notifyListeners();
    }
  }

  @override
  void onReconnectionSucceeded() {}
}

extension Message on BaseMessage {
  bool get isMyMessage => sender?.userId == sendbird.currentUser?.userId;
}
