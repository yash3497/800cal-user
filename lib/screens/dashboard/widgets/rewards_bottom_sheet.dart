import 'dart:io';

import 'package:eight_hundred_cal/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../../../utils/colors.dart';
import '../../../widgets/bottom_sheet_divider.dart';
import 'package:qr_flutter/qr_flutter.dart';

void showRewardBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: AppColor.pimaryColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),
    ),
    builder: (context) {
      return SingleChildScrollView(
        child: Container(
          width: width(context),
          padding: EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: AppColor.pimaryColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: BottomSheetDivider()),
              Text(
                'Share',
                style: TextStyle(
                  color: AppColor.whiteColor,
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
              heightBox(20),
              Center(
                child: QrImage(
                  data: '1234567890',
                  version: QrVersions.auto,
                  backgroundColor: AppColor.calendarbgColor,
                  foregroundColor: AppColor.whiteColor,
                  size: 160.0,
                ),
              ),
              heightBox(20),
              RewardBottomSheetDataCard(text: "Share your profile"),
              heightBox(20),
              RewardBottomSheetDataCard(
                text: "Invite others",
                onTap: () {
                  if (Platform.isAndroid) {
                    Share.share(
                        "Unlock the power of 800 cal! Join now with my referral code: Ref283 for exclusive rewards. Don't miss out, download today. $playStoreUrl");
                  } else {
                    Share.share(
                        "Unlock the power of 800 cal! Join now with my referral code: Ref283 for exclusive rewards. Don't miss out, download today. $appStoreUrl");
                  }
                },
              ),
              heightBox(20),
              RewardBottomSheetDataCard(text: "Referral points: 300"),
              heightBox(20),
              RewardBottomSheetDataCard(text: "Your unique link"),
            ],
          ),
        ),
      );
    },
  );
}

class RewardBottomSheetDataCard extends StatelessWidget {
  final String text;
  final Function()? onTap;
  const RewardBottomSheetDataCard({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 380,
        height: 70,
        padding: const EdgeInsets.symmetric(horizontal: 30),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: AppColor.calendarbgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColor.whiteColor,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
