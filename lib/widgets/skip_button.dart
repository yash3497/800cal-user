import 'package:eight_hundred_cal/backend/theme/theme_backend.dart';
import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

import '../utils/app_text.dart';
import '../utils/colors.dart';

class SkipButton extends StatefulWidget {
  final Function()? onTap;
  const SkipButton({super.key, this.onTap});

  @override
  State<SkipButton> createState() => _SkipButtonState();
}

class _SkipButtonState extends State<SkipButton> {
  var c = Get.put(TranslatorBackend());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.put(ThemeBackend()).checkTheme();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeBackend>(
        init: ThemeBackend(),
        builder: (controller) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FlutterSwitch(
                width: 60,
                height: 30,
                value: controller.isDarkMode,
                onToggle: (value) {
                  controller.updateTheme(value);
                },
                activeToggleColor: AppColor.secondaryColor,
                activeColor: AppColor.inputBoxBGColor,
                inactiveColor: AppColor.inputBoxBGColor,
              ),
              InkWell(
                onTap: widget.onTap,
                child: Text(
                  c.lang == 'en'
                      ? AppText.continueAsGuestEn
                      : AppText.continueAsGuestAr,
                  style: TextStyle(
                    color: AppColor.secondaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          );
        });
  }
}
