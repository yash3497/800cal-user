import 'package:eight_hundred_cal/backend/subscription/subscription_backend.dart';
import 'package:eight_hundred_cal/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

import '../../../utils/colors.dart';

class CustomBottomNavItem extends StatelessWidget {
  final String imagePath;
  final bool selected;
  final Function()? onTap;
  const CustomBottomNavItem(
      {super.key, required this.imagePath, required this.selected, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Image.asset(
        imagePath,
        width: 24,
        height: 24,
        color: selected ? AppColor.secondaryColor : null,
      ),
    );
  }
}

class DonutProgressBar extends StatelessWidget {
  final Function()? onTap;
  const DonutProgressBar({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubscriptionBackend>(builder: (controller) {
      return InkWell(
        onTap: onTap,
        child: SimpleCircularProgressBar(
          maxValue: controller.calendarModel != null
              ? double.parse(controller.calendarModel!.duration.toString())
              : 0.0,
          size: 65,
          startAngle: 90,
          progressColors: [
            AppColor.secondaryColor,
          ],
          valueNotifier: ValueNotifier(double.parse(
              (controller.delivered + controller.frozen).toString())),
          onGetText: (value) {
            TextStyle centerTextStyle = TextStyle(
              color: AppColor.whiteColor,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            );

            return Text(
              '${value.toInt()}/${controller.calendarModel != null ? controller.calendarModel!.duration : 0}',
              style: centerTextStyle,
            );
          },
        ),
      );
    });
  }
}
