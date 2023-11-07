import 'package:eight_hundred_cal/backend/bottom_bar/bottom_bar_backend.dart';
import 'package:eight_hundred_cal/backend/subscription/subscription_backend.dart';
import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:eight_hundred_cal/screens/bottom_bar/bottom_bar_screen.dart';
import 'package:eight_hundred_cal/utils/app_text.dart';
import 'package:eight_hundred_cal/utils/colors.dart';
import 'package:eight_hundred_cal/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubscriptionLoaderPage extends StatefulWidget {
  final bool auto;
  const SubscriptionLoaderPage({super.key, required this.auto});

  @override
  State<SubscriptionLoaderPage> createState() => _SubscriptionLoaderPageState();
}

class _SubscriptionLoaderPageState extends State<SubscriptionLoaderPage> {
  var c = Get.put(TranslatorBackend());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigateToCalendarPage();
  }

  _navigateToCalendarPage() async {
    if (widget.auto) {
      await Get.put(SubscriptionBackend()).autoCalendarFillApi().then((value) {
        Get.to(() => BottomBarScreen());
        Get.put(BottomBarBackend()).updateIndex(16);
      });
    } else {
      await Future.delayed(Duration(seconds: 3));
      Get.to(() => BottomBarScreen());
      Get.put(BottomBarBackend()).updateIndex(16);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColor.pimaryColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/salad_bowl.png",
                width: 285,
                height: 285,
              ),
              heightBox(20),
              Text(
                c.lang == 'en'
                    ? AppText.subscriptionLoaderDescEn
                    : AppText.subscriptionLoaderDescAr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColor.whiteColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
