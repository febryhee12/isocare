import 'package:flutter/material.dart';
import 'package:isocare/config.dart';

class HeroTitle extends StatelessWidget {
  const HeroTitle({
    Key? key,
    @required this.title,
    @required this.subtitle,
  }) : super(key: key);

  final String? title, subtitle;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              title!,
              style: TextStyle(
                fontSize: Config.screenWidth! * 0.07,
                color: kPrimaryColor,
              ),
            ),
            SizedBox(height: Config.screenHeight! * 0.01),
            Text(
              subtitle!,
              style: TextStyle(
                fontSize: Config.screenWidth! * 0.035,
              ),
            ),
            SizedBox(height: Config.screenHeight! * 0.01),
          ],
        ),
      ),
    );
  }
}
