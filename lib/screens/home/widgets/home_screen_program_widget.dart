import 'package:eight_hundred_cal/backend/bottom_bar/bottom_bar_backend.dart';
import 'package:eight_hundred_cal/backend/program/program_backend.dart';
import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:eight_hundred_cal/utils/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../../../widgets/program_card.dart';

class HomeScreenProgramWidget extends StatelessWidget {
  const HomeScreenProgramWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(ProgramBackend()).fetchAllPrograms();
    var c = Get.put(TranslatorBackend());
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              c.lang == 'en' ? AppText.programsEn : AppText.programsAr,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColor.whiteColor,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            InkWell(
              onTap: () {
                Get.put(BottomBarBackend()).updateIndex(1);
              },
              child: Text(
                c.lang == 'en' ? AppText.viewMoreEn : AppText.viewMoreAr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColor.secondaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
        heightBox(15),
        SizedBox(
          height: height(context) * .26,
          child: GetBuilder<ProgramBackend>(builder: (controller) {
            return ListView.separated(
              itemCount: controller.programList.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return ProgramsCard(
                  model: controller.programList[index],
                );
              },
              separatorBuilder: (context, index) => widthBox(18),
            );
          }),
        ),
      ],
    );
  }
}
