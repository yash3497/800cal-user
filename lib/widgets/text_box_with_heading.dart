import 'package:eight_hundred_cal/utils/constants.dart';
import 'package:eight_hundred_cal/widgets/custom_text_box.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';

class TextBoxWithHeading extends StatelessWidget {
  final String heading;
  final TextEditingController? controller;
  final Icon? suffixIcon;
  const TextBoxWithHeading(
      {super.key, required this.heading, this.controller, this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColor.whiteColor,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        heightBox(10),
        CustomTextBox(
          hintText: heading,
          controller: controller,
          suffixIcon: suffixIcon,
        ),
      ],
    );
  }
}
