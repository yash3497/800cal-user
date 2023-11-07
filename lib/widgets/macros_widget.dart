import 'dart:developer';

import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/home/dish_info_page.dart';
import '../utils/app_text.dart';

class MacrosWidget extends StatelessWidget {
  String protiens;
  String carbs;
  String calories;
  String fat;
  MacrosWidget({
    super.key,
    this.protiens = '4g',
    this.carbs = '10g',
    this.calories = '100',
    this.fat = '10g',
  });

  @override
  Widget build(BuildContext context) {
    var c = Get.put(TranslatorBackend());
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MacrosCard(
          title: calories,
          logo: "assets/icons/fire.png",
          description: c.lang == 'en' ? AppText.caloriesEn : AppText.caloriesAr,
        ),
        MacrosCard(
          title: protiens,
          logo: "assets/icons/muscle.png",
          description: c.lang == 'en' ? AppText.protiensEn : AppText.protiensAr,
        ),
        MacrosCard(
          title: carbs,
          logo: "assets/icons/wheat.png",
          description: c.lang == 'en' ? AppText.carbsEn : AppText.carbsAr,
        ),
        MacrosCard(
          title: fat,
          logo: "assets/icons/drops.png",
          description: c.lang == 'en' ? AppText.fatEn : AppText.fatAr,
        ),
      ],
    );
  }
}
