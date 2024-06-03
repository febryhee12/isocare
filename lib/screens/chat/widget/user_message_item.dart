import 'package:flutter/material.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';

import '../../../../styles/color.dart';
import '../chat_view_model.dart';
import 'message_item.dart';

class UserMessageItem extends MessageItem {
  UserMessageItem({
    required UserMessage curr,
    BaseMessage? prev,
    BaseMessage? next,
    required ChannelViewModel model,
    bool? isMyMessage,
    Function(Offset)? onPress,
    Function(Offset)? onLongPress,
  }) : super(
          curr: curr,
          prev: prev,
          next: next,
          model: model,
          isMyMessage: isMyMessage,
          onPress: onPress,
          onLongPress: onLongPress,
        );

  @override
  Widget get content => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: (isMyMessage ?? false)
              ? SBColors.primary_300
              : SBColors.background_100,
        ),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Text(
          curr.message,
          style: TextStyle(
            fontSize: 14,
            color: (isMyMessage ?? false)
                ? SBColors.ondark_01
                : SBColors.onlight_01,
          ),
        ),
      );
}
