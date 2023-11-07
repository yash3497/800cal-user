// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:eight_hundred_cal/backend/restaurant/restaurant_backend.dart';
import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:eight_hundred_cal/screens/home/widgets/home_screen_program_widget.dart';
import 'package:eight_hundred_cal/screens/home/widgets/home_screen_restaurant_widget.dart';
import 'package:eight_hundred_cal/utils/app_text.dart';
import 'package:eight_hundred_cal/utils/colors.dart';
import 'package:eight_hundred_cal/utils/constants.dart';
import 'package:eight_hundred_cal/utils/text_constant.dart';
import 'package:eight_hundred_cal/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../backend/profile/profile_backend.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(TranslatorBackend()).checkLanguage();
    Get.put(ProfileBackend()).fetchProfileData();
    return SafeArea(
      child: GetBuilder<TranslatorBackend>(builder: (controller) {
        return Scaffold(
          backgroundColor: AppColor.pimaryColor,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding)
                  .copyWith(top: 20),
              child: Column(
                children: [
                  CustomAppBar(
                      text: controller.lang == 'en'
                          ? AppText.homeHeadingEn
                          : AppText.homeHeadingAr),
                  heightBox(20),
                  HomeScreenBanner(),
                  heightBox(15),
                  ProfileCompleteBanner(),
                  heightBox(15),
                  HomeScreenProgramWidget(),
                  heightBox(20),
                  HomeScreenRestaurantWidget(),
                  heightBox(20),
                  HomeScreenSuccessStoryWidget(),
                  heightBox(200),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class ProfileCompleteBanner extends StatelessWidget {
  const ProfileCompleteBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var c = Get.put(TranslatorBackend());
    return Container(
      width: double.infinity,
      height: 70,
      decoration: ShapeDecoration(
        color: AppColor.inputBoxBGColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 19),
        child: Row(
          children: [
            Icon(
              Icons.person,
              color: AppColor.secondaryColor,
              size: 32,
            ),
            widthBox(28),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  c.lang == 'en'
                      ? AppText.homeCompleteProfileEn
                      : AppText.homeCompleteProfileAr,
                  style: TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  c.lang == 'en'
                      ? AppText.betterRecommendationsEn
                      : AppText.betterRecommendationsAr,
                  style: TextStyle(
                    color: AppColor.secondaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreenSuccessStoryWidget extends StatelessWidget {
  const HomeScreenSuccessStoryWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var c = Get.put(TranslatorBackend());
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              c.lang == 'en'
                  ? AppText.ourSuccessStoryEn
                  : AppText.ourSuccessStoryAr,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColor.whiteColor,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            // Text(
            //   c.lang == 'en' ? AppText.viewMoreEn : AppText.viewMoreAr,
            //   textAlign: TextAlign.center,
            //   style: TextStyle(
            //     color: AppColor.secondaryColor,
            //     fontSize: 14,
            //     fontWeight: FontWeight.w500,
            //   ),
            // )
          ],
        ),
        heightBox(15),
        SizedBox(
          height: height(context) * .28,
          child: PageView.builder(
            itemCount: 5,
            controller: PageController(
              viewportFraction: 0.85,
            ),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 15),
                child: SizedBox(
                  height: height(context) * .28,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: width(context) * .8,
                          height: height(context) * .24,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: AppColor.inputBoxBGColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 45, left: 20, right: 20),
                            child: Column(
                              children: [
                                Text(
                                  'Dianne Russell',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColor.whiteColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                heightBox(5),
                                Text(
                                  'Customer service agent',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColor.reviewCardTextColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                heightBox(10),
                                Text(
                                  'This is great. So Delicious! You must come here with your family. This is great. So Delicious! You must come here with your family. This is great. So Delicious! You must come here with your family...',
                                  maxLines: 5,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: AppColor.textgreyColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(
                            "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=800&q=60",
                            width: 76,
                            height: 76,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class HomeScreenBanner extends StatelessWidget {
  const HomeScreenBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var c = Get.put(TranslatorBackend());
    return Container(
      width: double.infinity,
      height: height(context) * .206,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        gradient: LinearGradient(
          begin: Alignment(1.00, 0.00),
          end: Alignment(-1, 0),
          colors: [AppColor.secondaryColor, AppColor.greenColor],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Stack(
        children: [
          Image.asset("assets/images/snacks_bowl.png"),
          Positioned(
            top: 28,
            left: 170,
            child: Column(
              children: [
                Text(
                  c.lang == 'en'
                      ? AppText.homeSubscriptionBannerEn
                      : AppText.homeSubscriptionBannerAr,
                  style: bodyText20(FontWeight.w600, AppColor.whiteColor),
                ),
                heightBox(16),
                Container(
                  width: 106,
                  height: 39,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                  decoration: ShapeDecoration(
                    color: AppColor.whiteColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Center(
                    child: Text(
                      c.lang == 'en'
                          ? AppText.exploreNowEn
                          : AppText.exploreNowAr,
                      style:
                          bodyText12(FontWeight.w700, AppColor.secondaryColor),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
