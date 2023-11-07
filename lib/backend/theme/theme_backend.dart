import 'package:eight_hundred_cal/services/storage_service.dart';
import 'package:eight_hundred_cal/utils/colors.dart';
import 'package:eight_hundred_cal/utils/db_keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeBackend extends GetxController {
  bool isDarkMode = true;

  checkTheme() async {
    isDarkMode = await StorageService().read(DbKeys.theme) ?? true;
    AppColor.pimaryColor =
        isDarkMode ? Color(0xFF0D0D0D) : Color(0xFFFFFFFF).withOpacity(0.95);
    AppColor.whiteColor = !isDarkMode ? Color(0xFF0D0D0D) : Color(0xFFFFFFFF);
    AppColor.inputBoxBGColor =
        isDarkMode ? Color(0xFF252525) : Color(0xFF6E97C2);
    update();
  }

  updateTheme(bool val) {
    isDarkMode = val;
    StorageService().write(DbKeys.theme, val);
    AppColor.pimaryColor =
        isDarkMode ? Color(0xFF0D0D0D) : Color(0xFFFFFFFF).withOpacity(0.95);
    AppColor.whiteColor = !isDarkMode ? Color(0xFF0D0D0D) : Color(0xFFFFFFFF);
    AppColor.inputBoxBGColor =
        isDarkMode ? Color(0xFF252525) : Color(0xFF6E97C2);
    update();
  }
}
