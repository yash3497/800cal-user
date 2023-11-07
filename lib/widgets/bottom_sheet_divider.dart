import 'package:eight_hundred_cal/utils/colors.dart';
import 'package:flutter/material.dart';

class BottomSheetDivider extends StatelessWidget {
  const BottomSheetDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 9,
      decoration: BoxDecoration(
        color: AppColor.mediumGreyColor,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
