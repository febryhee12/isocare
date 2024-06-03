import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:sizer/sizer.dart';

import '../../../helpers/ui_data.dart';

// ignore: must_be_immutable
class NewsView extends StatelessWidget {
  String? image;
  String? title;
  String? createdAt;
  String? content;

  NewsView({super.key, this.image, this.title, this.createdAt, this.content});
  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            flexibleSpace: FlexibleSpaceBar(
              background: _backgroundImage(),
            ),
            iconTheme: const IconThemeData(
              color: Colors.black, //change your color here
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            expandedHeight: 250,
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: _newsDetailSection(),
          ),
        ],
      ),
    );
  }

  _backgroundImage() {
    return CachedNetworkImage(
      imageUrl: image!,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
        ),
      ),
      errorWidget: (context, url, error) => Image.asset('assets/no_image.png'),
    );
  }

  _newsDetailSection() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _rowTitle(),
          const SizedBox(
            height: 10.0,
          ),
          _rowDate(),
          const SizedBox(
            height: 16.0,
          ),
          _rowDetail(),
        ],
      ),
    );
  }

  _rowTitle() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child:
          Txt(title!, TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
    );
  }

  _rowDate() {
    var date = DateTime.parse(createdAt!);
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Txt(
          '${date.day.toString()}-${date.month.toString()}-${date.year.toString()}',
          TextStyle(fontSize: 10.sp)),
    );
  }

  _rowDetail() {
    return Html(
      // onLinkTap: (url, context, attributes, element) async {
      //   if (await canLaunch(url!)) {
      //     await launch(url,
      //         forceSafariVC: false,
      //         forceWebView: false,
      //         enableJavaScript: false);
      //   } else {
      //     throw "link tidak di temukan";
      //   }
      // },
      data: content!,
    );
  }
}
