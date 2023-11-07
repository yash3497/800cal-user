import 'package:eight_hundred_cal/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../backend/bottom_bar/bottom_bar_backend.dart';
import '../../../utils/colors.dart';
import 'custom_bottom_nav_item.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomBarBackend>(
        init: BottomBarBackend(),
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.only(left: 14, right: 14, bottom: 14),
            child: SizedBox(
              height: 102,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      height: 70,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              width: 0.50,
                              color: AppColor.bottomBarBorderColor),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment(1.00, 0.00),
                          end: Alignment(-1, 0),
                          colors: [
                            AppColor.inputBoxBGColor,
                            AppColor.bottomBarColor
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: width(context) * .074,
                    bottom: 22,
                    child: CustomBottomNavItem(
                      imagePath: "assets/icons/home.png",
                      selected:
                          controller.gIndex == 0 || controller.gIndex == 5,
                      onTap: () {
                        controller.updateIndex(0);
                      },
                    ),
                  ),
                  Positioned(
                    left: width(context) * .24,
                    bottom: 22,
                    child: CustomBottomNavItem(
                      imagePath: "assets/icons/dish.png",
                      selected: controller.gIndex == 1,
                      onTap: () {
                        controller.updateIndex(1);
                      },
                    ),
                  ),
                  Positioned(
                      left: width(context) * .39,
                      bottom: 27,
                      child: DonutProgressBar(
                        onTap: () {
                          controller.updateIndex(2);
                        },
                      )),
                  Positioned(
                    right: width(context) * .24,
                    bottom: 22,
                    child: CustomBottomNavItem(
                      imagePath: "assets/icons/menu.png",
                      selected: controller.gIndex == 3,
                      onTap: () {
                        controller.updateIndex(3);
                      },
                    ),
                  ),
                  Positioned(
                    right: width(context) * .074,
                    bottom: 22,
                    child: CustomBottomNavItem(
                      imagePath: "assets/icons/dashboard.png",
                      selected: controller.gIndex == 4,
                      onTap: () {
                        controller.updateIndex(4);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
