// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:sizer/sizer.dart';

import '../../../helpers/ui_data.dart';

class BannerView extends StatelessWidget {
  String? title;
  String? coverImageLink;
  String? content;
  String? createAt;

  BannerView(
      {super.key,
      this.coverImageLink,
      this.content,
      this.title,
      this.createAt});

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
            backgroundColor: Colors.white,
            elevation: 0,
            expandedHeight: 190,
            pinned: true,
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: _bannerDetailSection(),
          ),
        ],
      ),
    );
  }

  _backgroundImage() {
    return Image.network(
      coverImageLink!,
      fit: BoxFit.fill,
    );
  }

  _bannerDetailSection() {
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
    var date = DateTime.parse(createAt!);
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Txt(
          '${date.day.toString()}-${date.month.toString()}-${date.year.toString()}',
          TextStyle(fontSize: 10.sp)),
    );
  }

  _rowDetail() {
    return Html(data: content!);
  }
}
