import 'package:eight_hundred_cal/backend/program/program_backend.dart';
import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:eight_hundred_cal/utils/colors.dart';
import 'package:eight_hundred_cal/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../backend/bottom_bar/bottom_bar_backend.dart';
import '../../model/program/program_model.dart';
import '../../utils/app_text.dart';
import '../../widgets/bottom_sheet_divider.dart';
import '../../widgets/program_card.dart';

ProgramModel? programModel;

class ProgramDetailsPage extends StatelessWidget {
  const ProgramDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColor.pimaryColor,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(
              height: height(context) * 1.3,
            ),
            ProgramInfoImageCard(),
            ProgramInforBackButton(),
            ProgramInfoBottomSheet(),
          ],
        ),
      ),
    ));
  }
}

class ProgramInfoImageCard extends StatelessWidget {
  const ProgramInfoImageCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      programModel?.logo ??
          "https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fGd5bXxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=800&q=60",
      width: width(context),
      height: height(context) * .4,
      fit: BoxFit.cover,
    );
  }
}

class ProgramInforBackButton extends StatelessWidget {
  const ProgramInforBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 20,
      top: 20,
      child: InkWell(
        onTap: () {
          Get.put(BottomBarBackend()).updateIndex(0);
        },
        child: Container(
          width: 24,
          height: 24,
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: AppColor.whiteColor.withOpacity(0.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: Center(
            child: Icon(
              Icons.arrow_back_ios_rounded,
              color: AppColor.whiteColor,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}

class ProgramInfoBottomSheet extends StatelessWidget {
  const ProgramInfoBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var c = Get.put(TranslatorBackend());
    return Positioned(
      left: 0,
      right: 0,
      top: height(context) * .37,
      child: Container(
        width: width(context),
        padding:
            EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 15),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: AppColor.pimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: BottomSheetDivider()),
            heightBox(20),
            programModel?.popular == true ? ProgramPopularCard() : SizedBox(),
            heightBox(20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${programModel?.name}',
                  style: TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                ProgramHealthyFoodCard(),
              ],
            ),
            heightBox(20),
            Row(
              children: [
                Image.asset(
                  "assets/icons/star.png",
                  width: 20,
                  height: 20,
                ),
                widthBox(5),
                Text(
                  '${programModel?.rating} ${c.lang == 'en' ? AppText.ratingEn : AppText.ratingAr}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColor.textgreyColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                widthBox(25),
                // Image.asset(
                //   "assets/icons/comments.png",
                //   width: 20,
                //   height: 20,
                // ),
                // widthBox(5),
                // Text(
                //   '6 comments',
                //   textAlign: TextAlign.center,
                //   style: TextStyle(
                //     color: AppColor.textgreyColor,
                //     fontSize: 14,
                //     fontWeight: FontWeight.w400,
                //   ),
                // ),
              ],
            ),
            heightBox(20),
            Text(
              '${programModel?.description}',
              style: TextStyle(
                color: AppColor.reviewCardTextColor,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
            heightBox(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  c.lang == 'en'
                      ? AppText.otherProgramsEn
                      : AppText.otherProgramsAr,
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
              height: height(context) * .24,
              child: GetBuilder<ProgramBackend>(builder: (controller) {
                List<ProgramModel> models = [];
                controller.programList.forEach((element) {
                  if (element != programModel) {
                    models.add(element);
                  }
                });
                return ListView.separated(
                  itemCount: models.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return ProgramsCard(
                      model: models[index],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return widthBox(20);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class ProgramHealthyFoodCard extends StatelessWidget {
  const ProgramHealthyFoodCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: AppColor.greenShadeColor.withOpacity(.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(21),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Text(
          "${programModel?.tag}",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColor.secondaryColor,
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class ProgramPopularCard extends StatelessWidget {
  const ProgramPopularCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: AppColor.greenShadeColor.withOpacity(.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(21),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Text(
          "Popular",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColor.secondaryColor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
