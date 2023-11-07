// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:eight_hundred_cal/backend/bottom_bar/bottom_bar_backend.dart';
import 'package:eight_hundred_cal/backend/meal/meal_backend.dart';
import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:eight_hundred_cal/utils/app_text.dart';

import 'package:eight_hundred_cal/utils/colors.dart';
import 'package:eight_hundred_cal/utils/constants.dart';
import 'package:eight_hundred_cal/widgets/custom_button.dart';
import 'package:eight_hundred_cal/widgets/custom_date_calendar_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

void showSubsriptionPopup(BuildContext context, String programId) {
  var c = Get.put(TranslatorBackend());
  final startDateController = TextEditingController(
      text: "${DateFormat("dd-MM-yyyy").format(DateTime.now())}");
  subscriptionModel.startDate = DateTime.now();
  subscriptionModel.duration = subscriptionWeekListEn[0];
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        backgroundColor: AppColor.inputBoxBGColor,
        child: SizedBox(
          width: width(context),
          height: height(context) * .46,
          child: Padding(
            padding: EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  c.lang == 'en'
                      ? AppText.subscriptionDurationEn
                      : AppText.subscriptionDurationAr,
                  style: TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                heightBox(10),
                Container(
                  width: width(context),
                  height: 70,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColor.whiteColor, width: 0.5),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: DropdownButtonFormField(
                        onChanged: (value) async {
                          subscriptionModel.duration =
                              await c.translateTextInEn(value!);
                          log(subscriptionModel.duration);
                        },
                        value: (c.lang == 'en'
                            ? subscriptionWeekListEn
                            : subscriptionWeekListAr)[0],
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColor.whiteColor,
                          fontWeight: FontWeight.w400,
                        ),
                        icon: SizedBox(),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        dropdownColor: AppColor.inputBoxBGColor,
                        items: (c.lang == 'en'
                                ? subscriptionWeekListEn
                                : subscriptionWeekListAr)
                            .map((e) {
                          return DropdownMenuItem(
                            value: e,
                            child: Text(
                              e,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                heightBox(10),
                Text(
                  c.lang == 'en' ? AppText.startDateEn : AppText.startDateAr,
                  style: TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                heightBox(10),
                Container(
                  width: width(context),
                  height: 70,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColor.whiteColor, width: 0.5),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: TextFormField(
                        readOnly: true,
                        onTap: () async {
                          DateTime value = await customDatePicker(
                              context, DateTime.now(), DateTime(2050));

                          startDateController.text =
                              "${DateFormat("dd-MM-yyyy").format(value)}";
                          subscriptionModel.startDate = value;
                        },
                        controller: startDateController,
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColor.whiteColor,
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.calendar_month,
                            color: AppColor.mediumGreyColor,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
                heightBox(18),
                Center(
                  child: SizedBox(
                      width: 133,
                      height: 60,
                      child: CustomButton(
                        text: c.lang == 'en' ? AppText.nextEn : AppText.nextAr,
                        onTap: () {
                          Get.back();
                          Get.put(MealBackend()).fetchAllMeals(programId);
                          Get.put(BottomBarBackend()).updateIndex(6);
                        },
                      )),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
