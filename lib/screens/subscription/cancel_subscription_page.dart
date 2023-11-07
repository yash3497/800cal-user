import 'package:eight_hundred_cal/backend/subscription/subscription_backend.dart';
import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:eight_hundred_cal/services/app_services.dart';
import 'package:eight_hundred_cal/utils/colors.dart';
import 'package:eight_hundred_cal/utils/constants.dart';
import 'package:eight_hundred_cal/widgets/custom_button.dart';
import 'package:eight_hundred_cal/widgets/custom_text_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/app_text.dart';

class CancelSubscriptionPage extends StatelessWidget {
  CancelSubscriptionPage({super.key});

  var c = Get.put(TranslatorBackend());
  var controller = Get.put(SubscriptionBackend());
  int penalty = 20;

  @override
  Widget build(BuildContext context) {
    int dayConsume = ((controller.calendarModel!.total /
                controller.calendarModel!.duration) *
            controller.delivered)
        .round();
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColor.pimaryColor,
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              c.lang == 'en'
                  ? AppText.cancelSubscriptionEn
                  : AppText.cancelSubscriptionAr,
              style: TextStyle(
                color: AppColor.whiteColor,
                fontSize: 32,
                fontWeight: FontWeight.w600,
              ),
            ),
            heightBox(20),
            Text(
              c.lang == 'en'
                  ? AppText.completedDaysEn
                  : AppText.completedDaysAr,
              style: TextStyle(
                color: AppColor.whiteColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            heightBox(10),
            CustomTextBox(
              hintText: "Enter days",
              readOnly: true,
              initialValue: '${controller.delivered}',
            ),
            heightBox(20),
            Text(
              c.lang == 'en' ? AppText.pendingDaysEn : AppText.pendingDaysAr,
              style: TextStyle(
                color: AppColor.whiteColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            heightBox(10),
            CustomTextBox(
              hintText: "Enter days",
              readOnly: true,
              initialValue: '${controller.pending}',
            ),
            heightBox(20),
            Text(
              c.lang == 'en' ? AppText.penaltyEn : AppText.penaltyAr,
              style: TextStyle(
                color: AppColor.whiteColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            heightBox(10),
            CustomTextBox(
              hintText: "Type here..",
              readOnly: true,
              initialValue:
                  '$penalty${c.lang == 'en' ? AppText.kdEn : AppText.kdAr}',
            ),
            heightBox(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  c.lang == 'en'
                      ? AppText.totalAmountPaidEn
                      : AppText.totalAmountPaidAr,
                  style: TextStyle(
                    color: AppColor.textgrey2Color,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  '${controller.calendarModel?.total}${c.lang == 'en' ? AppText.kdEn : AppText.kdAr}',
                  style: TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
            heightBox(5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  c.lang == 'en'
                      ? AppText.numberOfDaysConsumeEn
                      : AppText.numberOfDaysConsumeAr,
                  style: TextStyle(
                    color: AppColor.textgrey2Color,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  '-$dayConsume${c.lang == 'en' ? AppText.kdEn : AppText.kdAr}',
                  style: TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
            heightBox(5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  c.lang == 'en' ? AppText.penaltyEn : AppText.penaltyAr,
                  style: TextStyle(
                    color: AppColor.textgrey2Color,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  '-$penalty${c.lang == 'en' ? AppText.kdEn : AppText.kdAr}',
                  style: TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
            Divider(
              color: AppColor.whiteColor,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  c.lang == 'en' ? AppText.totalEn : AppText.totalAr,
                  style: TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${controller.calendarModel!.total - dayConsume - penalty}${c.lang == 'en' ? AppText.kdEn : AppText.kdAr}',
                  style: TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
            heightBox(20),
            Center(
              child: CustomButton(
                onTap: () {
                  controller.cancelSubscription();
                },
                text: c.lang == 'en' ? AppText.confirmEn : AppText.confirmAr,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
