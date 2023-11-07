// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:developer';

import 'package:eight_hundred_cal/backend/bottom_bar/bottom_bar_backend.dart';
import 'package:eight_hundred_cal/backend/meal/meal_backend.dart';
import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:eight_hundred_cal/model/meal/meal_model.dart';
import 'package:eight_hundred_cal/utils/app_text.dart';
import 'package:eight_hundred_cal/utils/colors.dart';
import 'package:eight_hundred_cal/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/custom_appbar.dart';

class MealsPerDayScreen extends StatelessWidget {
  const MealsPerDayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var c = Get.put(TranslatorBackend());
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColor.pimaryColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding)
            .copyWith(top: 20),
        child: Column(
          children: [
            CustomAppBar(
                text: c.lang == 'en'
                    ? AppText.mealPerDayHeadingEn
                    : AppText.mealPerDayHeadingAr),
            heightBox(20),
            Flexible(
              child: GetBuilder<MealBackend>(builder: (controller) {
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15),
                  itemCount: controller.mealList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {
                        MealModel m = controller.mealList[index];
                        m.name = await c.translateTextInEn(m.name);
                        List d = [];
                        for (int i = 0; i < m.description.length; i++) {
                          d.add(await c.translateTextInEn(m.description[i]));
                        }
                        m.description = d;
                        subscriptionModel.meal = m;
                        Get.put(BottomBarBackend()).updateIndex(7);
                      },
                      child: MealCard(
                        name: controller.mealList[index].name,
                        description:
                            controller.mealList[index].description.join(", "),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    ));
  }
}

class MealCard extends StatelessWidget {
  final String name;
  final String description;
  const MealCard({
    super.key,
    required this.name,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: AppColor.inputBoxBGColor,
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/meal.png",
              width: 90,
              height: 90,
            ),
            heightBox(15),
            Text(
              name,
              style: TextStyle(
                color: AppColor.whiteColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            heightBox(5),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColor.secondaryColor,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ));
  }
}
