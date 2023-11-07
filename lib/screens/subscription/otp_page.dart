import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:eight_hundred_cal/utils/colors.dart';
import 'package:eight_hundred_cal/utils/constants.dart';
import 'package:eight_hundred_cal/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/app_text.dart';

class OtpPageScreen extends StatelessWidget {
  final String phoneNumber;
  final Map data;
  const OtpPageScreen(
      {super.key, required this.phoneNumber, required this.data});

  @override
  Widget build(BuildContext context) {
    var c = Get.put(TranslatorBackend());
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColor.pimaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              c.lang == 'en'
                  ? AppText.enterFourDigitOtpEn
                  : AppText.enterFourDigitOtpAr,
              style: TextStyle(
                color: AppColor.whiteColor,
                fontSize: 32,
                fontWeight: FontWeight.w600,
              ),
            ),
            heightBox(8),
            Text(
              '${c.lang == 'en' ? AppText.codeSentToEn : AppText.codeSentToAr} $phoneNumber \n${c.lang == 'en' ? AppText.theCodeExpiredInEn : AppText.theCodeExpiredInAr} 01:30',
              style: TextStyle(
                color: AppColor.secondaryGreyColor,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            heightBox(30),
            Container(
              width: double.infinity,
              height: height(context) * .1,
              padding: EdgeInsets.symmetric(horizontal: 35),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppColor.secondaryGreyColor,
              ),
              child: Center(
                child: TextFormField(
                  scrollPhysics: NeverScrollableScrollPhysics(),
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                  style: TextStyle(
                    fontSize: 40,
                    color: AppColor.whiteColor,
                    fontWeight: FontWeight.w600,
                    letterSpacing: width(context) * .13,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    counterText: "",
                  ),
                ),
              ),
            ),
            Spacer(),
            Center(
              child: CustomButton(
                text: c.lang == 'en' ? AppText.nextEn : AppText.nextAr,
              ),
            ),
            heightBox(80),
          ],
        ),
      ),
    ));
  }
}
