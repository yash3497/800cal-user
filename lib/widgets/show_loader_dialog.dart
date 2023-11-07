import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/app_text.dart';

//create a loader dialog

showLoaderDialog(BuildContext context) {
  var c = Get.put(TranslatorBackend());
  AlertDialog alert = AlertDialog(
    content: Row(
      children: [
        const CircularProgressIndicator(),
        const SizedBox(
          width: 20,
        ),
        Text("${c.lang == 'en' ? AppText.loadingEn : AppText.loadingAr}..."),
      ],
    ),
  );
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
