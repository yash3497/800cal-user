// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:eight_hundred_cal/backend/subscription/subscription_backend.dart';
import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:eight_hundred_cal/screens/menu/breakfast_page.dart';
import 'package:eight_hundred_cal/screens/menu/meal_page.dart';
import 'package:eight_hundred_cal/screens/menu/snack_soup_page.dart';
import 'package:eight_hundred_cal/screens/subscription/choose_your_meals_page.dart';
import 'package:eight_hundred_cal/utils/colors.dart';
import 'package:eight_hundred_cal/utils/constants.dart';
import 'package:eight_hundred_cal/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../utils/app_text.dart';

class ChooseYourPackageMealScreen extends StatefulWidget {
  const ChooseYourPackageMealScreen({super.key});

  @override
  State<ChooseYourPackageMealScreen> createState() =>
      _ChooseYourPackageMealScreenState();
}

class _ChooseYourPackageMealScreenState
    extends State<ChooseYourPackageMealScreen> with TickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColor.pimaryColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding)
            .copyWith(top: 20),
        child: Column(
          children: [
            CustomAppBar(text: "Choose your \nPackage meals"),
            heightBox(10),
            ChooseYourPackageMealDateWidget(),
            ChooseYourPackageMealTabBar(tabController: tabController),
            heightBox(15),
            Flexible(
              child: TabBarView(controller: tabController, children: [
                BreakFastPageScreen(),
                MealPageScreen(),
                SnackSoupPageScreen(),
              ]),
            ),
          ],
        ),
      ),
    ));
  }
}

class ChooseYourPackageMealTabBar extends StatefulWidget {
  const ChooseYourPackageMealTabBar({
    super.key,
    required this.tabController,
  });

  final TabController? tabController;

  @override
  State<ChooseYourPackageMealTabBar> createState() =>
      _ChooseYourPackageMealTabBarState();
}

class _ChooseYourPackageMealTabBarState
    extends State<ChooseYourPackageMealTabBar> {
  var c = Get.put(TranslatorBackend());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubscriptionBackend>(
        init: SubscriptionBackend(),
        builder: (controller) {
          Map meal = controller
              .dateMealList[DateFormat('dd-MMM-yyyy').format(mealDate)];
          return Stack(
            children: [
              TabBar(
                  controller: widget.tabController,
                  indicatorColor: AppColor.whiteColor,
                  tabs: [
                    Tab(
                      text: c.lang == 'en'
                          ? AppText.breakfastEn
                          : AppText.breakfastAr,
                    ),
                    Tab(
                      text: c.lang == 'en' ? AppText.mealEn : AppText.mealAr,
                    ),
                    Tab(
                      text: c.lang == 'en'
                          ? AppText.snackAndsoupEn
                          : AppText.snackAndsoupAr,
                    ),
                  ]),
              Positioned(
                left: width(context) * .24,
                top: 0,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: AppColor.secondaryColor,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Center(
                    child: Text(
                      '${meal != null ? meal['food'].length > 0 ? '1' : '0' : '0'}/${controller.calendarModel?.meals['description'].contains('Breakfast') ? '1' : '0'}',
                      style: TextStyle(
                        color: AppColor.whiteColor,
                        fontSize: 8,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: width(context) * .52,
                top: 0,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: AppColor.secondaryColor,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Center(
                    child: Text(
                      '${meal != null ? meal['food'].length > 1 ? '1' : '0' : '0'}/${controller.calendarModel?.meals['description'].contains('Main Dish') ? '1' : '0'}',
                      style: TextStyle(
                        color: AppColor.whiteColor,
                        fontSize: 8,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: width(context) * .82,
                top: 0,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: AppColor.secondaryColor,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Center(
                    child: Text(
                      '${meal != null ? meal['food'].length > 2 ? '1' : '0' : '0'}/${controller.calendarModel?.meals['description'].contains('Snack') ? '1' : '0'}',
                      style: TextStyle(
                        color: AppColor.whiteColor,
                        fontSize: 8,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }
}

class ChooseYourPackageMealDateWidget extends StatelessWidget {
  const ChooseYourPackageMealDateWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
          radius: 25,
          backgroundImage: AssetImage("assets/images/resta_logo.png"),
          backgroundColor: AppColor.pimaryColor,
        ),
        Text(
          '10kcal',
          style: TextStyle(
            color: AppColor.whiteColor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          '20th Aug, 2023',
          style: TextStyle(
            color: AppColor.whiteColor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        )
      ],
    );
  }
}
