// ignore_for_file: prefer_const_constructors

import 'package:eight_hundred_cal/backend/login/login_backend.dart';
import 'package:eight_hundred_cal/backend/theme/theme_backend.dart';
import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:eight_hundred_cal/screens/bottom_bar/bottom_bar_screen.dart';
import 'package:eight_hundred_cal/screens/login/forget_password.dart';
import 'package:eight_hundred_cal/screens/login/signup_screen.dart';
import 'package:eight_hundred_cal/utils/app_text.dart';
import 'package:eight_hundred_cal/utils/colors.dart';
import 'package:eight_hundred_cal/utils/constants.dart';
import 'package:eight_hundred_cal/widgets/custom_button.dart';
import 'package:eight_hundred_cal/widgets/custom_text_box.dart';
import 'package:eight_hundred_cal/widgets/show_loader_dialog.dart';
import 'package:eight_hundred_cal/widgets/skip_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var c = Get.put(LoginBackend());
  var t = Get.put(TranslatorBackend());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<ThemeBackend>(
          init: ThemeBackend(),
          builder: (controller) {
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
                        t.lang == 'en'
                            ? AppText.loginForFreeEn
                            : AppText.loginForFreeAr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColor.whiteColor,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      heightBox(24),
                      CustomTextBox(
                        hintText: t.lang == 'en'
                            ? AppText.usernameEn
                            : AppText.usernameAr,
                        controller: emailController,
                      ),
                      heightBox(20),
                      CustomTextBox(
                        hintText: t.lang == 'en'
                            ? AppText.passwordEn
                            : AppText.passwordAr,
                        controller: passwordController,
                        obscureText: true,
                      ),
                      heightBox(10),
                      InkWell(
                        onTap: () {
                          Get.to(() => ForgetPassword());
                        },
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            t.lang == 'en'
                                ? AppText.forgetPasswordEn
                                : AppText.forgetPasswordAr,
                            style: TextStyle(
                              color: AppColor.secondaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      heightBox(10),
                      Text(
                        t.lang == 'en'
                            ? AppText.orContinueWithEn
                            : AppText.orContinueWithAr,
                        style: TextStyle(
                          color: AppColor.whiteColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      heightBox(27),
                      SocialMediaLoginCard(),
                      heightBox(32),
                      InkWell(
                        onTap: () {
                          Get.to(() => SignupScreen());
                        },
                        child: Text(
                          t.lang == 'en'
                              ? AppText.donthaveanaccountEn
                              : AppText.donthaveanaccountAr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColor.secondaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      heightBox(32),
                      CustomButton(
                        text:
                            t.lang == 'en' ? AppText.loginEn : AppText.loginAr,
                        onTap: () {
                          showLoaderDialog(context);
                          c.login(
                              emailController.text, passwordController.text);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}

class SocialMediaLoginCard extends StatelessWidget {
  const SocialMediaLoginCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var t = Get.put(TranslatorBackend());
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            Get.put(LoginBackend()).signInWithFacebook();
          },
          child: Container(
            width: width(context) * .42,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColor.inputBoxBGColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/icons/fb.png",
                  height: 28,
                  width: 28,
                ),
                widthBox(10),
                Text(
                  t.lang == 'en' ? AppText.facebookEn : AppText.facebookAr,
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
        ),
        InkWell(
          onTap: () {
            Get.put(LoginBackend()).signInWithGoogle();
          },
          child: Container(
            width: width(context) * .42,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColor.inputBoxBGColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/icons/google.png",
                  height: 28,
                  width: 28,
                ),
                widthBox(10),
                Text(
                  t.lang == 'en' ? AppText.googleEn : AppText.googleAr,
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
        ),
      ],
    );
  }
}
