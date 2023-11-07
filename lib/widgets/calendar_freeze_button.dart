import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:eight_hundred_cal/utils/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/subscription/widgets/freeze_of_the_day_dialog.dart';
import '../utils/colors.dart';

class CalendarConfirmButton extends StatelessWidget {
  const CalendarConfirmButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var c = Get.put(TranslatorBackend());
    return InkWell(
      onTap: () {
        showFreezeOfTheDayPopup(context);
      },
      child: Container(
        width: 87,
        height: 30,
        padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 5),
        decoration: ShapeDecoration(
          color: AppColor.blueColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
        child: Text(
          c.lang == 'en' ? AppText.freezeEn : AppText.freezeAr,
          style: TextStyle(
            color: AppColor.whiteColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
