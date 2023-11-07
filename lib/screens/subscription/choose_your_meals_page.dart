import 'dart:developer';

import 'package:eight_hundred_cal/backend/bottom_bar/bottom_bar_backend.dart';
import 'package:eight_hundred_cal/backend/profile/profile_backend.dart';
import 'package:eight_hundred_cal/backend/restaurant/restaurant_backend.dart';
import 'package:eight_hundred_cal/backend/subscription/subscription_backend.dart';
import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:eight_hundred_cal/screens/home/restaurant_detail_page.dart';
import 'package:eight_hundred_cal/screens/subscription/snack_meal_page.dart';
import 'package:eight_hundred_cal/utils/app_text.dart';
import 'package:eight_hundred_cal/utils/colors.dart';
import 'package:eight_hundred_cal/utils/constants.dart';
import 'package:eight_hundred_cal/widgets/custom_appbar.dart';
import 'package:eight_hundred_cal/widgets/custom_button.dart';
import 'package:eight_hundred_cal/widgets/macros_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

import '../home/dish_info_page.dart';
import '../menu/choose_your_package_meal.dart';
import 'breakfast_meal_page.dart';
import 'meal_page.dart';

DateTime mealDate = DateTime.now();

class ChooseYourMealsPage extends StatefulWidget {
  const ChooseYourMealsPage({super.key});

  @override
  State<ChooseYourMealsPage> createState() => _ChooseYourMealsPageState();
}

class _ChooseYourMealsPageState extends State<ChooseYourMealsPage>
    with TickerProviderStateMixin {
  TabController? tabController;
  var c = Get.put(TranslatorBackend());

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    Get.put(RestaurantBackend()).fetchRestaurantMenu(restaurantId);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColor.pimaryColor,
      body: GetBuilder<RestaurantBackend>(builder: (controller) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding)
              .copyWith(top: 20),
          child: Stack(
            children: [
              Column(
                children: [
                  CustomAppBar(
                      text: c.lang == 'en'
                          ? AppText.chooseYourMealEn
                          : AppText.chooseYourMealAr),
                  heightBox(20),
                  ChooseYourMealsDateWidget(
                    edit: controller.edit,
                  ),
                  heightBox(20),
                  Image.network(
                    controller.restaurantModel?.logo ??
                        "https://images.unsplash.com/photo-1619454016518-697bc231e7cb?auto=format&fit=crop&q=80&w=2960&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                    width: 50,
                    height: 50,
                  ),
                  heightBox(10),
                  GetBuilder<SubscriptionBackend>(builder: (controller) {
                    Map subs = controller.dateMealList[
                        DateFormat('dd-MMM-yyyy').format(mealDate)];
                    return MacrosWidget(
                      protiens: subs != null
                          ? '${subs['protien']}${c.lang == 'en' ? AppText.gEn : AppText.gAr}'
                          : '0${c.lang == 'en' ? AppText.gEn : AppText.gAr}',
                      carbs: subs != null
                          ? '${subs['carbs']}${c.lang == 'en' ? AppText.gEn : AppText.gAr}'
                          : '0${c.lang == 'en' ? AppText.gEn : AppText.gAr}',
                      calories: subs != null
                          ? '${subs['calories']}${c.lang == 'en' ? AppText.kcalEn : AppText.kcalAr}'
                          : '0${c.lang == 'en' ? AppText.kcalEn : AppText.kcalAr}',
                      fat: subs != null
                          ? '${subs['fat']}${c.lang == 'en' ? AppText.gEn : AppText.gAr}'
                          : '0${c.lang == 'en' ? AppText.gEn : AppText.gAr}',
                    );
                  }),
                  heightBox(20),
                  ChooseYourPackageMealTabBar(tabController: tabController),
                  heightBox(20),
                  Flexible(
                    child: TabBarView(controller: tabController, children: [
                      BreakFastMealPageScreen(
                        menu: controller.restaurantModel?.menu ?? [],
                      ),
                      MealMealsPageScreen(
                        menu: controller.restaurantModel?.menu ?? [],
                      ),
                      SnackSoupMealPageScreen(
                        menu: controller.restaurantModel?.menu ?? [],
                      ),
                    ]),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 120),
                  child: CustomButton(
                    onTap: () async {
                      if (controller.edit) {
                        await Get.put(SubscriptionBackend()).updateCalendar();
                      } else {
                        await Get.put(SubscriptionBackend()).addCalendarMeal();
                      }
                      if (Get.put(ProfileBackend()).model?.isSubscribed ??
                          false) {
                        Get.put(BottomBarBackend()).updateIndex(3);
                      } else {
                        Get.put(BottomBarBackend()).updateIndex(16);
                      }
                    },
                    text: c.lang == 'en' ? AppText.nextEn : AppText.nextAr,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    ));
  }
}

class ChooseYourMealsDateWidget extends StatefulWidget {
  final bool edit;
  const ChooseYourMealsDateWidget({
    super.key,
    required this.edit,
  });

  @override
  State<ChooseYourMealsDateWidget> createState() =>
      _ChooseYourMealsDateWidgetState();
}

class _ChooseYourMealsDateWidgetState extends State<ChooseYourMealsDateWidget> {
  String date = "";
  var c = Get.put(TranslatorBackend());
  var controller = Get.put(SubscriptionBackend());
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  _changeLanguage() async {
    date = await c.translateText(DateFormat('d MMM, y').format(mealDate));
    Get.put(RestaurantBackend()).update();
    setState(() {});
  }

  _next() {
    mealDate = mealDate.add(Duration(days: 1));
    _changeLanguage();
  }

  _prev() {
    mealDate = mealDate.add(Duration(days: -1));
    _changeLanguage();
  }

  _fetchDate() {
    setState(() {
      startDate = DateTime.fromMillisecondsSinceEpoch(
          controller.calendarModel?.startDate ?? 0);
      endDate = DateTime.fromMillisecondsSinceEpoch(
          controller.calendarModel?.endDate ?? 0);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _changeLanguage();
    _fetchDate();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        startDate.year == mealDate.year &&
                    startDate.month == mealDate.month &&
                    startDate.day == mealDate.day ||
                widget.edit
            ? SizedBox()
            : InkWell(
                onTap: () {
                  _prev();
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 16,
                  color: AppColor.whiteColor,
                ),
              ),
        Text(
          date,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColor.whiteColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        endDate.year == mealDate.year &&
                    endDate.month == mealDate.month &&
                    endDate.day == mealDate.day ||
                widget.edit
            ? SizedBox()
            : InkWell(
                onTap: () {
                  _next();
                },
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: AppColor.whiteColor,
                ),
              ),
      ],
    );
  }
}
