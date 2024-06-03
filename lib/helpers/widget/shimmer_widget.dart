import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;

  // ignore: use_key_in_widget_constructors
  const ShimmerWidget.rectangular(
      {this.width = double.infinity,
      required this.height,
      this.shapeBorder = const RoundedRectangleBorder()});
  // ignore: use_key_in_widget_constructors
  const ShimmerWidget.circular({
    this.width = double.infinity,
    required this.height,
    this.shapeBorder = const CircleBorder(),
  });

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
      child: Container(
        width: width,
        height: height,
        decoration:
            ShapeDecoration(color: Colors.grey[100]!, shape: shapeBorder),
      ),
      baseColor: const Color(0xFFCACACA),
      highlightColor: const Color(0xFFBBBBBB));
}
