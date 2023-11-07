import 'package:eight_hundred_cal/backend/login/register_backend.dart';
import 'package:eight_hundred_cal/backend/theme/theme_backend.dart';
import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:eight_hundred_cal/utils/app_text.dart';
import 'package:eight_hundred_cal/widgets/show_loader_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_box.dart';
import '../../widgets/skip_button.dart';
import '../bottom_bar/bottom_bar_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var c = Get.put(RegisterBackend());
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
                    padding:
                        const EdgeInsets.only(top: 20, left: 20, right: 20),
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
                          height: 200,
                          width: 200,
                        ),
                        Text(
                          t.lang == 'en'
                              ? AppText.signupForFreeEn
                              : AppText.signupForFreeAr,
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
                              t.lang == 'en' ? AppText.nameEn : AppText.nameAr,
                          controller: nameController,
                        ),
                        heightBox(20),
                        CustomTextBox(
                          hintText: t.lang == 'en'
                              ? AppText.emailaddressOrmobilenoEn
                              : AppText.emailaddressOrmobilenoAr,
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
                        heightBox(27),
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Text(
                            t.lang == 'en'
                                ? AppText.alreadyhaveanaccountEn
                                : AppText.alreadyhaveanaccountAr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColor.secondaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        heightBox(
                            height(context) * (t.lang == 'en' ? 0.12 : .09)),
                        CustomButton(
                          text: t.lang == 'en'
                              ? AppText.createAccountEn
                              : AppText.createAccountAr,
                          onTap: () {
                            showLoaderDialog(context);
                            c.register(nameController.text,
                                emailController.text, passwordController.text);
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
