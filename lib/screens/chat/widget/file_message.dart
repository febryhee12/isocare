// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:sizer/sizer.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';

import '../../../../helpers/ui_data.dart';
import '../../../../styles/color.dart';
import '../chat_view_model.dart';
import 'message_item.dart';

class FileMessageItem extends MessageItem {
  FileMessageItem({
    required FileMessage curr,
    BaseMessage? prev,
    BaseMessage? next,
    required ChannelViewModel model,
    required bool isMyMessage,
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
  Widget get content => ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: (curr as FileMessage).localFile != null
            ? SizedBox(
                child: FittedBox(
                  child: Image.file((curr as FileMessage).localFile!),
                  fit: BoxFit.cover,
                ),
                height: 240,
                width: 240,
              )
            : CachedNetworkImage(
                height: 300,
                width: 240,
                fit: BoxFit.cover,
                imageUrl: (curr as FileMessage).secureUrl ??
                    (curr as FileMessage).url,
                imageBuilder: (context, imageProvider) {
                  return GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    ),
                    onTap: () =>
                        Get.to(PreviewImage(imageProvider: imageProvider)),
                  );
                },
                placeholder: (context, imageProvider) => Container(
                  color: SBColors.primary_300,
                  child: const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                  width: 30,
                  height: 30,
                ),
                errorWidget: (context, imageProvider, error) =>
                    const Icon(Icons.error),
              ),
      );
}

class PreviewImage extends StatelessWidget {
  ImageProvider imageProvider;

  // ignore: use_key_in_widget_constructors
  PreviewImage({required this.imageProvider});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
        title: Txt('Kembali', TextStyle(fontSize: 14.sp, color: Colors.white)),
      ),
      body: Center(
        child: PhotoView(imageProvider: imageProvider),
      ),
    );
  }
}
