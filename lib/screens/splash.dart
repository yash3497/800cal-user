import 'dart:async';
import 'dart:developer';

import 'package:eight_hundred_cal/backend/profile/profile_backend.dart';
import 'package:eight_hundred_cal/backend/theme/theme_backend.dart';
import 'package:eight_hundred_cal/screens/bottom_bar/bottom_bar_screen.dart';
import 'package:eight_hundred_cal/screens/login/onboarding_screen.dart';
import 'package:eight_hundred_cal/services/storage_service.dart';
import 'package:eight_hundred_cal/utils/colors.dart';
import 'package:eight_hundred_cal/utils/db_keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../backend/subscription/subscription_backend.dart';
import '../backend/translator/translator_backend.dart';
import '../model/profile/profile_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkNavigation();
    Get.put(TranslatorBackend()).checkLanguage();
    Get.put(ThemeBackend()).checkTheme();
  }

  _checkNavigation() async {
    if (await StorageService().read(DbKeys.authToken) != null) {
      var controller = Get.put(ProfileBackend());
      await controller.fetchProfileData().then((value) async {
        if (value) {
          ProfileModel model = Get.put(ProfileBackend()).model!;
          log("Profile: ${model.toJson()}");
          if (model.isSubscribed) {
            await Get.put(SubscriptionBackend())
                .fetchSubscriptionData(model.subscriptionId);
          }
          Get.to(() => BottomBarScreen());
        }
      });
    } else {
      await Future.delayed(Duration(seconds: 3));
      Get.to(() => OnBoardingScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColor.pimaryColor,
      body: Center(
        child: Image.asset("assets/icons/logo.png"),
      ),
    ));
  }
}
