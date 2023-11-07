// ignore_for_file: prefer_const_constructors

import 'package:eight_hundred_cal/backend/bottom_bar/bottom_bar_backend.dart';
import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:eight_hundred_cal/screens/dashboard/widgets/language_bottom_sheet.dart';
import 'package:eight_hundred_cal/screens/dashboard/widgets/rewards_bottom_sheet.dart';
import 'package:eight_hundred_cal/screens/login/login_screen.dart';
import 'package:eight_hundred_cal/services/storage_service.dart';
import 'package:eight_hundred_cal/utils/app_text.dart';
import 'package:eight_hundred_cal/utils/colors.dart';
import 'package:eight_hundred_cal/utils/constants.dart';
import 'package:eight_hundred_cal/utils/db_keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/login_dialog.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColor.pimaryColor,
      body: GetBuilder<TranslatorBackend>(
          init: TranslatorBackend(),
          builder: (controller) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding)
                    .copyWith(top: 20),
                child: Column(
                  children: [
                    DashboardCustomAppBar(),
                    heightBox(20),
                    DashboardCardWidget(
                      image: "assets/icons/profile.png",
                      title: controller.lang == 'en'
                          ? AppText.profileEn
                          : AppText.profileAr,
                      onTap: () async {
                        String userId =
                            await StorageService().read(DbKeys.authToken);
                        if (userId == null) {
                          showLoginDialog(context);
                        } else {
                          Get.put(BottomBarBackend()).updateIndex(10);
                        }
                      },
                    ),
                    heightBox(20),
                    DashboardCardWidget(
                      image: "assets/icons/setting.png",
                      title: controller.lang == 'en'
                          ? AppText.settingsEn
                          : AppText.settingsAr,
                      onTap: () {
                        Get.put(BottomBarBackend()).updateIndex(22);
                      },
                    ),
                    heightBox(20),
                    DashboardCardWidget(
                      image: "assets/icons/wallet.png",
                      title: controller.lang == 'en'
                          ? AppText.walletEn
                          : AppText.walletAr,
                      onTap: () {
                        Get.put(BottomBarBackend()).updateIndex(18);
                      },
                    ),
                    heightBox(20),
                    DashboardCardWidget(
                      image: "assets/icons/my_order.png",
                      title: controller.lang == 'en'
                          ? AppText.yourOrdersEn
                          : AppText.yourOrdersAr,
                      onTap: () {
                        Get.put(BottomBarBackend()).updateIndex(19);
                      },
                    ),
                    heightBox(20),
                    DashboardCardWidget(
                      onTap: () {
                        Get.put(BottomBarBackend()).updateIndex(24);
                      },
                      image: "assets/icons/support.png",
                      title: controller.lang == 'en'
                          ? AppText.contactUsEn
                          : AppText.contactUsAr,
                    ),
                    heightBox(20),
                    DashboardCardWidget(
                      image: "assets/icons/gift.png",
                      title: controller.lang == 'en'
                          ? AppText.rewardsEn
                          : AppText.rewardsAr,
                      onTap: () {
                        showRewardBottomSheet(context);
                      },
                    ),
                    heightBox(20),
                    DashboardCardWidget(
                      image: "assets/icons/languages.png",
                      title: controller.lang == 'en'
                          ? AppText.languageEn
                          : AppText.languageAr,
                      onTap: () {
                        showLanguageBottomSheet(context);
                      },
                    ),
                    heightBox(20),
                    DashboardCardWidget(
                      image: "assets/icons/policy.png",
                      title: controller.lang == 'en'
                          ? AppText.privacyPolicyEn
                          : AppText.privacyPolicyAr,
                    ),
                    heightBox(20),
                    DashboardCardWidget(
                      image: "assets/icons/logout.png",
                      title: controller.lang == 'en'
                          ? AppText.logoutEn
                          : AppText.logoutAr,
                      onTap: () async {
                        await StorageService().box.erase();
                        Get.offAll(() => LoginScreen());
                      },
                    ),
                    heightBox(120),
                  ],
                ),
              ),
            );
          }),
    ));
  }
}

class DashboardCardWidget extends StatelessWidget {
  final String image;
  final String title;
  final Function()? onTap;
  const DashboardCardWidget({
    super.key,
    required this.image,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width(context),
        height: 70,
        padding: const EdgeInsets.symmetric(horizontal: 30),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: AppColor.inputBoxBGColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Row(
          children: [
            Image.asset(
              image,
              width: 20,
              height: 20,
              color: AppColor.secondaryColor,
            ),
            widthBox(10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColor.whiteColor,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DashboardCustomAppBar extends StatelessWidget {
  const DashboardCustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var c = Get.put(TranslatorBackend());
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          c.lang == 'en' ? AppText.menuEn : AppText.menuAr,
          style: TextStyle(
            color: AppColor.whiteColor,
            fontSize: 32,
            fontWeight: FontWeight.w600,
          ),
        ),
        Image.asset(
          "assets/icons/logo.png",
          width: 65,
          height: 44,
        ),
      ],
    );
  }
}
