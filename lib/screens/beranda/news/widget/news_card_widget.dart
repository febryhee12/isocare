import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sizer/sizer.dart';

import '../../../../helpers/ui_data.dart';
import '../../../../helpers/widget/shimmer_widget.dart';
import '../../../../models/news_model.dart';
import '../news_view.dart';

class NewsCardWidget extends StatelessWidget {
  final NewsModel? model;
  NewsCardWidget({this.model});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.8.h),
      child: Card(
        color: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: InkWell(
          onTap: () {
            Get.to(
              NewsView(
                title: model!.title,
                image: model!.coverImageLink,
                createdAt: model!.createdAt,
                content: model!.content,
              ),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: model!.coverImageLink,
                imageBuilder: (context, imageProvider) => Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(width: 0.5, color: Colors.black12),
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
                placeholder: (context, url) => Container(
                  decoration: const BoxDecoration(),
                  child: ShimmerWidget.rectangular(
                    height: 200,
                    shapeBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: UIColor.cGrey,
                    shape: BoxShape.rectangle,
                    border: Border.all(width: 0.5, color: Colors.black12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Image.asset('assets/no_image.png'),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 1.h),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    model!.title,
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
