// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:eight_hundred_cal/backend/bottom_bar/bottom_bar_backend.dart';
import 'package:eight_hundred_cal/backend/profile/profile_backend.dart';
import 'package:eight_hundred_cal/backend/subscription/subscription_backend.dart';
import 'package:eight_hundred_cal/model/profile/profile_model.dart';
import 'package:eight_hundred_cal/screens/bottom_bar/widgets/custom_bottom_bar.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';
import '../../utils/constants.dart';

class BottomBarScreen extends StatelessWidget {
  BottomBarScreen({
    super.key,
  });

  ProfileModel model = Get.put(ProfileBackend()).model!;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColor.pimaryColor,
      // bottomNavigationBar: CustomBottomBar(),
      body: Stack(
        children: [
          GetBuilder<BottomBarBackend>(
            init: BottomBarBackend(),
            builder: (controller) {
              return model.isSubscribed ||
                      !DateTime.now().isAfter(
                          DateTime.fromMillisecondsSinceEpoch(
                              model.subscriptionEndDate))
                  ? subWidgetList[controller.gIndex]
                  : widgetList[controller.gIndex];
            },
          ),
          Align(alignment: Alignment.bottomCenter, child: CustomBottomBar()),
        ],
      ),
    ));
  }
}
