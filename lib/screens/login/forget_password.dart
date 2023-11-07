import 'package:eight_hundred_cal/backend/theme/theme_backend.dart';
import 'package:eight_hundred_cal/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../backend/translator/translator_backend.dart';
import '../../utils/app_text.dart';
import '../../utils/constants.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_box.dart';
import '../../widgets/show_loader_dialog.dart';
import '../../widgets/skip_button.dart';
import '../bottom_bar/bottom_bar_screen.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  var t = Get.put(TranslatorBackend());
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: GetBuilder<ThemeBackend>(builder: (controller) {
      return Scaffold(
        backgroundColor: AppColor.pimaryColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Column(
              children: [
                SkipButton(
                  onTap: () {
                    Get.to(() => BottomBarScreen());
                  },
                ),
                heightBox(60),
                Image.asset(
                  "assets/icons/logo.png",
                  height: width(context) * .4,
                  width: width(context) * .4,
                ),
                Text(
                  t.lang == 'en' ? AppText.forgetPassEn : AppText.forgetPassAr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                heightBox(24),
                CustomTextBox(
                  hintText:
                      t.lang == 'en' ? AppText.usernameEn : AppText.usernameAr,
                  controller: emailController,
                ),
                heightBox(32),
                CustomButton(
                  text: t.lang == 'en'
                      ? AppText.forgetPassEn
                      : AppText.forgetPassAr,
                  onTap: () {
                    showLoaderDialog(context);
                  },
                ),
              ],
            ),
          ),
        ),
      );
    }));
  }
}
