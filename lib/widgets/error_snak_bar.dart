import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:eight_hundred_cal/utils/app_text.dart';
import 'package:eight_hundred_cal/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void ErrorSnackBar(String message) async {
  var c = Get.put(TranslatorBackend());
  String m = await c.translateText(message);
  Get.snackbar(
    c.lang == 'en' ? AppText.errorEn : AppText.errorAr,
    "$m",
    backgroundColor: AppColor.secondaryColor,
    colorText: AppColor.pimaryColor,
    margin: EdgeInsets.all(20),
    borderRadius: 10,
    duration: Duration(seconds: 3),
  );
}
