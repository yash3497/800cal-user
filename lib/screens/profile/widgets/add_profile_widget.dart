import 'package:eight_hundred_cal/backend/bottom_bar/bottom_bar_backend.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';

class AddProfileWidget extends StatelessWidget {
  const AddProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.put(BottomBarBackend()).updateIndex(21);
      },
      child: Container(
        width: 40,
        height: 40,
        padding: const EdgeInsets.all(10),
        decoration: ShapeDecoration(
          color: AppColor.inputBoxBGColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        child: Center(
          child: Icon(
            Icons.add,
            color: AppColor.whiteColor,
          ),
        ),
      ),
    );
  }
}
