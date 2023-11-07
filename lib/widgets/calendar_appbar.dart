import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../backend/bottom_bar/bottom_bar_backend.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';

class CalendarConfirmAppBar extends StatelessWidget {
  const CalendarConfirmAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        widthBox(width(context) * .33),
        Image.asset(
          "assets/icons/logo.png",
          width: 120,
          height: 120,
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: InkWell(
            onTap: () {
              Get.put(BottomBarBackend()).updateIndex(10);
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: ShapeDecoration(
                color: AppColor.inputBoxBGColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.person,
                  color: AppColor.secondaryColor,
                  size: 32,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
