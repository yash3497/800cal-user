import 'dart:developer';

import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:eight_hundred_cal/utils/constants.dart';
import 'package:eight_hundred_cal/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';

void showLanguageBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    constraints: BoxConstraints(maxHeight: 360),
    backgroundColor: AppColor.pimaryColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),
    ),
    builder: (context) {
      Get.put(TranslatorBackend()).checkLanguage();
      return GetBuilder<TranslatorBackend>(builder: (controller) {
        return Container(
          padding: EdgeInsets.all(30),
          width: width(context),
          child: Column(
            children: [
              Text(
                'Choose the language',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColor.whiteColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              heightBox(20),
              LanguageBottomSheetDataCard(
                language: "English",
                isSelected: controller.lang == 'en',
                onTap: () {
                  controller.changeLanguage('en');
                },
              ),
              heightBox(20),
              LanguageBottomSheetDataCard(
                language: "Arabic",
                isSelected: controller.lang == 'ar',
                onTap: () {
                  controller.changeLanguage('ar');
                },
              ),
              heightBox(20),
              CustomButton(
                text: "Done",
                onTap: () {
                  Get.back();
                },
              ),
            ],
          ),
        );
      });
    },
  );
}

class LanguageBottomSheetDataCard extends StatelessWidget {
  final String language;
  final bool isSelected;
  final Function()? onTap;
  const LanguageBottomSheetDataCard(
      {super.key,
      required this.language,
      required this.isSelected,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width(context),
        height: 70,
        padding: const EdgeInsets.symmetric(horizontal: 30),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: AppColor.calendarbgColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(
                width: 1,
                color:
                    isSelected ? AppColor.secondaryColor : AppColor.whiteColor),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              language,
              textAlign: TextAlign.center,
              style: TextStyle(
                color:
                    isSelected ? AppColor.secondaryColor : AppColor.whiteColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    );
  }
}
