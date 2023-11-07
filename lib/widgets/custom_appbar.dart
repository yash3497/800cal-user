import 'package:eight_hundred_cal/backend/bottom_bar/bottom_bar_backend.dart';
import 'package:eight_hundred_cal/services/storage_service.dart';
import 'package:eight_hundred_cal/utils/db_keys.dart';
import 'package:eight_hundred_cal/utils/text_constant.dart';
import 'package:eight_hundred_cal/widgets/login_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/colors.dart';

class CustomAppBar extends StatelessWidget {
  final String text;
  bool showProfile;
  CustomAppBar({
    super.key,
    required this.text,
    this.showProfile = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Flexible(
          child: Text(text, style: appBarStyle()),
        ),
        showProfile
            ? InkWell(
                onTap: () async {
                  String token = await StorageService().read(DbKeys.authToken);

                  if (token != null) {
                    Get.put(BottomBarBackend()).updateIndex(10);
                  } else {
                    showLoginDialog(context);
                  }
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: ShapeDecoration(
                    color: AppColor.inputBoxBGColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.person,
                      color: AppColor.secondaryColor,
                      size: 32,
                    ),
                  ),
                ),
              )
            : SizedBox(),
      ],
    );
  }
}
