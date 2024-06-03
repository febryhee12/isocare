import 'package:flutter/material.dart';
import 'package:sendbird_sdk/core/message/admin_message.dart';

import '../../../../styles/text_style.dart';
import '../chat_view_model.dart';
import 'message_item.dart';

class AdminMessageItem extends MessageItem {
  AdminMessageItem({
    required AdminMessage curr,
    required ChannelViewModel model,
  }) : super(curr: curr, model: model);

  @override
  Widget get content => Container(
        child: Text(
          curr.message,
          style: TextStyles.sendbirdCaption2OnLight2,
        ),
      );
}
