import 'package:eight_hundred_cal/backend/program/program_backend.dart';
import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:eight_hundred_cal/model/program/program_model.dart';
import 'package:eight_hundred_cal/utils/app_text.dart';
import 'package:eight_hundred_cal/utils/colors.dart';
import 'package:eight_hundred_cal/utils/constants.dart';
import 'package:eight_hundred_cal/widgets/custom_appbar.dart';
import 'package:eight_hundred_cal/widgets/custom_text_box.dart';
import 'package:eight_hundred_cal/widgets/program_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuitedProgramPage extends StatelessWidget {
  const SuitedProgramPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TranslatorBackend>(builder: (controller) {
      return SafeArea(
          child: Scaffold(
        backgroundColor: AppColor.pimaryColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding)
                .copyWith(top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBar(
                    text: controller.lang == 'en'
                        ? AppText.programHeadingEn
                        : AppText.programHeadingAr),
                heightBox(20),
                CustomTextBox(
                  hintText:
                      "${controller.lang == 'en' ? AppText.programSearchEn : AppText.programSearchAr}...",
                  onChanged: (p0) {
                    Get.put(ProgramBackend()).searchProgramByName(p0);
                  },
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColor.whiteColor,
                  ),
                ),
                heightBox(20),
                Text(
                  controller.lang == 'en'
                      ? AppText.programsEn
                      : AppText.programsAr,
                  style: TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                heightBox(20),
                GetBuilder<ProgramBackend>(builder: (controller) {
                  return GridView.builder(
                    itemCount: controller.tempList.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 18,
                      mainAxisSpacing: 18,
                      childAspectRatio: 0.8,
                    ),
                    itemBuilder: (context, index) {
                      return ProgramsCard(
                        model: controller.tempList[index],
                      );
                    },
                  );
                }),
                heightBox(120),
              ],
            ),
          ),
        ),
      ));
    });
  }
}
