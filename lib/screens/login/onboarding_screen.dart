import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:eight_hundred_cal/utils/app_text.dart';
import 'package:eight_hundred_cal/utils/colors.dart';
import 'package:eight_hundred_cal/utils/constants.dart';
import 'package:eight_hundred_cal/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'login_screen.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var c = Get.put(TranslatorBackend());
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColor.pimaryColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 50),
        child: Column(
          children: [
            Image.asset(
              "assets/images/onb.png",
              height: height(context) * .55,
              width: width(context),
              fit: BoxFit.fill,
            ),
            heightBox(15),
            Text(
              c.lang == 'en'
                  ? AppText.onboardingTitleEn
                  : AppText.onboardingTitleAr,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColor.whiteColor,
                fontSize: 28,
                fontWeight: FontWeight.w700,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40).copyWith(top: 10),
              child: Text(
                c.lang == 'en'
                    ? AppText.onboardingDescEn
                    : AppText.onboardingDescAr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColor.textgreyColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const Spacer(),
            CustomButton(
              text: "",
              isIcon: true,
              onTap: () {
                Get.to(() => LoginScreen());
              },
            ),
          ],
        ),
      ),
    ));
  }
}
