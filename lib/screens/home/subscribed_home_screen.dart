// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:eight_hundred_cal/backend/subscription/subscription_backend.dart';
import 'package:eight_hundred_cal/model/food/food_model.dart';
import 'package:eight_hundred_cal/screens/home/widgets/subscribed_donut_chart.dart';
import 'package:eight_hundred_cal/screens/home/widgets/subscribed_home_date_widget.dart';
import 'package:eight_hundred_cal/screens/home/widgets/subscribed_home_next_order_widget.dart';
import 'package:eight_hundred_cal/utils/constants.dart';
import 'package:eight_hundred_cal/widgets/custom_appbar.dart';
import 'package:eight_hundred_cal/widgets/macros_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../backend/food/food_backend.dart';
import '../../backend/profile/profile_backend.dart';
import '../../backend/program/program_backend.dart';
import '../../backend/restaurant/restaurant_backend.dart';
import '../../backend/translator/translator_backend.dart';
import '../../model/pie_chart/char_data_model.dart';
import '../../utils/app_text.dart';
import '../../utils/colors.dart';

class SubscribedHomeScreen extends StatefulWidget {
  const SubscribedHomeScreen({super.key});

  @override
  State<SubscribedHomeScreen> createState() => _SubscribedHomeScreenState();
}

class _SubscribedHomeScreenState extends State<SubscribedHomeScreen> {
  var profileController = Get.put(ProfileBackend());
  DateFormat format = DateFormat('dd/MM/yyyy');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.put(TranslatorBackend()).checkLanguage();
    profileController.fetchProfileData();
    Get.put(ProgramBackend()).fetchAllPrograms();
    Get.put(RestaurantBackend()).fetchAllRestaurants();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<TranslatorBackend>(builder: (controller) {
        return Scaffold(
          backgroundColor: AppColor.pimaryColor,
          body: GetBuilder<SubscriptionBackend>(builder: (controller2) {
            List? dList = controller2.calendarModel?.calendar
                .where((element) =>
                    format
                        .format(DateTime.fromMillisecondsSinceEpoch(
                            element['date']))
                        .toString() ==
                    format.format(DateTime.now()))
                .toList();
            Map data = dList != null ? dList[0] : {};
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding)
                    .copyWith(top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomAppBar(
                        text:
                            '${controller.lang == 'en' ? AppText.hiEn : AppText.hiAr}, ${profileController.model?.firstname}'),
                    heightBox(20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SubscribedHomeDonutChart(
                              text:
                                  '${controller2.calendarModel?.program['kcal']}${controller.lang == 'en' ? AppText.kcalEn : AppText.kcalAr}'),
                          SubscribedHomeDonutIndicatorWithText(),
                        ],
                      ),
                    ),
                    heightBox(20),
                    SubscribedHomeNextOrderWidget(
                      data: data,
                    ),
                    heightBox(20),
                    SubscribedHomeDateWidget(
                      calendar: controller2.calendarModel?.calendar ?? [],
                    ),
                    Divider(
                      color: AppColor.reviewCardTextColor,
                      thickness: 1,
                    ),
                    heightBox(10),
                    Text(
                      controller.lang == 'en'
                          ? AppText.totalMacrosEn
                          : AppText.totalMacrosAr,
                      style: TextStyle(
                        color: AppColor.whiteColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    heightBox(10),
                    MacrosWidget(
                      protiens:
                          '${controller2.protien}${controller.lang == 'en' ? AppText.gEn : AppText.gAr}',
                      calories:
                          '${controller2.calorie}${controller.lang == 'en' ? AppText.kcalEn : AppText.kcalAr}',
                      carbs:
                          '${controller2.carbs}${controller.lang == 'en' ? AppText.gEn : AppText.gAr}',
                      fat:
                          '${controller2.fat}${controller.lang == 'en' ? AppText.gEn : AppText.gAr}',
                    ),
                    heightBox(20),
                    SubscribedHomeFoodCardWithTextWidget(
                      heading: controller.lang == 'en'
                          ? AppText.breakfastEn
                          : AppText.breakfastAr,
                      mealId: data != {}
                          ? data['food'].length > 0
                              ? data['food'][0]
                              : ''
                          : "",
                    ),
                    heightBox(20),
                    SubscribedHomeFoodCardWithTextWidget(
                      heading: controller.lang == 'en'
                          ? AppText.mealEn
                          : AppText.mealAr,
                      mealId: data != {}
                          ? data['food'].length > 1
                              ? data['food'][1]
                              : ''
                          : '',
                    ),
                    heightBox(20),
                    SubscribedHomeFoodCardWithTextWidget(
                      heading: controller.lang == 'en'
                          ? AppText.snackAndsoupEn
                          : AppText.snackAndsoupAr,
                      mealId: data != {}
                          ? data['food'].length > 2
                              ? data['food'][2]
                              : ''
                          : '',
                    ),
                    heightBox(120),
                  ],
                ),
              ),
            );
          }),
        );
      }),
    );
  }
}

class SubscribedHomeFoodCardWithTextWidget extends StatefulWidget {
  final String heading;
  final String mealId;
  const SubscribedHomeFoodCardWithTextWidget({
    super.key,
    required this.heading,
    required this.mealId,
  });

  @override
  State<SubscribedHomeFoodCardWithTextWidget> createState() =>
      _SubscribedHomeFoodCardWithTextWidgetState();
}

class _SubscribedHomeFoodCardWithTextWidgetState
    extends State<SubscribedHomeFoodCardWithTextWidget> {
  FoodModel model = dummyFoodModel;
  var c = Get.put(TranslatorBackend());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.put(FoodBackend()).fetchFoodById(widget.mealId).then((value) {
      setState(() {
        model = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.heading,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColor.whiteColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        heightBox(15),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColor.inputBoxBGColor,
          ),
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  model.image,
                  width: 70,
                  height: 70,
                  fit: BoxFit.fill,
                ),
              ),
              widthBox(15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model.name}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColor.whiteColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '${model.calories}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColor.reviewCardTextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '${model.protien} ${c.lang == 'en' ? AppText.protiensEn : AppText.protiensAr}, ${model.carbs} ${c.lang == 'en' ? AppText.carbsEn : AppText.carbsAr}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColor.reviewCardTextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SubscribedHomeDonutIndicatorWithText extends StatelessWidget {
  const SubscribedHomeDonutIndicatorWithText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var c = Get.put(TranslatorBackend());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 30,
              height: 30,
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: AppColor.yellowColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
            widthBox(10),
            Text(
              c.lang == 'en' ? AppText.pendingEn : AppText.pendingAr,
              style: TextStyle(
                color: AppColor.whiteColor,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        heightBox(14),
        Row(
          children: [
            Container(
              width: 30,
              height: 30,
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: AppColor.secondaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
            widthBox(10),
            Text(
              c.lang == 'en' ? AppText.swappableEn : AppText.swappableAr,
              style: TextStyle(
                color: AppColor.whiteColor,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        heightBox(14),
        Row(
          children: [
            Container(
              width: 30,
              height: 30,
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: AppColor.blueColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
            widthBox(10),
            Text(
              c.lang == 'en' ? AppText.freezedEn : AppText.freezedAr,
              style: TextStyle(
                color: AppColor.whiteColor,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        heightBox(14),
        Row(
          children: [
            Container(
              width: 30,
              height: 30,
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: AppColor.reviewCardTextColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
            widthBox(10),
            Text(
              c.lang == 'en' ? AppText.deliveredEn : AppText.deliveredAr,
              style: TextStyle(
                color: AppColor.whiteColor,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
