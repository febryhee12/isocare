import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';

import '../../../../styles/color.dart';
import 'avatar_view.dart';

class ProfileModal {
  final BuildContext ctx;
  final User user;

  ProfileModal({required this.ctx, required this.user});

  Future<bool> show() {
    final wait = Completer<bool>();

    showModalBottomSheet<bool>(
      context: ctx,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.0),
      ),
      builder: (BuildContext ctx) {
        return SafeArea(
          child: UserProfile(
            sender: user,
            onPressedMessage: (userId) {
              Navigator.pop(ctx, true);
            },
          ),
        );
      },
    ).then((isManuallyHidden) {
      wait.complete(isManuallyHidden ?? false);
    });

    return wait.future;
  }
}

class UserProfile extends StatelessWidget {
  final User sender;
  final Function(String)? onPressedMessage;

  UserProfile({required this.sender, this.onPressedMessage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 32, 16, 7),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AvatarView(user: sender, width: 120, height: 120),
          const SizedBox(height: 8),
          Text(
            sender.nickname,
            style: const TextStyle(
              color: SBColors.onlight_01,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
              fontStyle: FontStyle.normal,
              fontSize: 18.0,
            ),
          ),
        ],
      ),
    );
  }
}
