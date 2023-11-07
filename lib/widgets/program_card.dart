import 'package:eight_hundred_cal/model/program/program_model.dart';
import 'package:eight_hundred_cal/screens/subscription/program_details_page.dart';
import 'package:eight_hundred_cal/widgets/subscription_popup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../backend/bottom_bar/bottom_bar_backend.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';

class ProgramsCard extends StatelessWidget {
  final ProgramModel model;
  const ProgramsCard({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        subscriptionModel.program = model;
        showSubsriptionPopup(context, model.id);
      },
      child: Container(
        width: 180,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 28),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: AppColor.inputBoxBGColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Get.put(BottomBarBackend()).updateIndex(15);
                programModel = model;
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  model.logo,
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            heightBox(15),
            Text(
              model.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColor.whiteColor,
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
