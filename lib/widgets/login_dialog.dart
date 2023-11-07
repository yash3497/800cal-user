import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:eight_hundred_cal/screens/login/login_screen.dart';
import 'package:eight_hundred_cal/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/app_text.dart';

void showLoginDialog(BuildContext context) {
  var c = Get.put(TranslatorBackend());
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: AppColor.inputBoxBGColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        title: Text(
          c.lang == 'en'
              ? AppText.loginYourAccountEn
              : AppText.loginYourAccountAr,
          style: TextStyle(color: AppColor.whiteColor),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              // Close the dialog when OK is pressed
              Navigator.of(context).pop();
            },
            child: Text(
              c.lang == 'en' ? AppText.cancelEn : AppText.cancelAr,
            ),
          ),
          TextButton(
            onPressed: () {
              Get.offAll(() => LoginScreen());
            },
            child: Text(
              c.lang == 'en' ? AppText.okEn : AppText.okAr,
            ),
          ),
        ],
      );
    },
  );
}
