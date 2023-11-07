import 'package:flutter/material.dart';

import '../utils/colors.dart';

class MacrosDataWidget extends StatelessWidget {
  final String title;
  final String logo;
  final String description;
  const MacrosDataWidget({
    super.key,
    required this.title,
    required this.logo,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColor.secondaryColor,
            fontSize: 26,
            fontWeight: FontWeight.w700,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              logo,
              width: 18,
              height: 18,
            ),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColor.whiteColor,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
      ],
    );
  }
}
