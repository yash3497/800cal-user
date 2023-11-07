import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:eight_hundred_cal/backend/bottom_bar/bottom_bar_backend.dart';
import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:eight_hundred_cal/model/profile/profile_model.dart';
import 'package:eight_hundred_cal/screens/splash.dart';
import 'package:eight_hundred_cal/services/cloudinary_setup.dart';
import 'package:eight_hundred_cal/services/http_service.dart';
import 'package:eight_hundred_cal/services/storage_service.dart';
import 'package:eight_hundred_cal/utils/api_constants.dart';
import 'package:eight_hundred_cal/utils/db_keys.dart';
import 'package:eight_hundred_cal/widgets/show_loader_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileBackend extends GetxController {
  ProfileModel? model;

  Future<bool> fetchProfileData() async {
    try {
      var c = Get.put(TranslatorBackend());
      String token = await StorageService().read(DbKeys.authToken);
      var response =
          await HttpServices.getWithToken(ApiConstants.profile, token);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        model = ProfileModel.fromJson(data['customer']);

        model?.username = await c.translateText(model!.username);
        model?.email = await c.translateText(model!.email);
        model?.firstname = await c.translateText(model!.firstname);
        model?.lastname = await c.translateText(model!.lastname);
        model?.gender = await c.translateText(model!.gender);
        model?.gender = await c.translateText(model!.gender);
        model?.phonenumber = await c.translateText(model!.phonenumber);
        model?.address = await c.translateText(model!.address);
        update();
        return true;
      } else {
        print("Fetch profile data failed: ${response.statusCode}");
      }
      return false;
    } catch (e) {
      print("Fetching profile data failed: $e");
      return false;
    }
  }

  uploadImage(ImageSource source, BuildContext context) async {
    final picker = await ImagePicker().pickImage(source: source);
    showLoaderDialog(context);
    if (picker != null) {
      String url = await CloudinaryService().uploadFIle(File(picker.path));
      Get.back();
      model!.image = url;
      update();
    } else {
      Get.back();
    }
  }

  updateProfile(ProfileModel model, BuildContext context) async {
    try {
      showLoaderDialog(context);
      String token = await StorageService().read(DbKeys.authToken);
      var response = await HttpServices.patchWithToken(
          ApiConstants.updateProfile, jsonEncode(model.toJson()), token);

      if (response.statusCode == 200) {
        fetchProfileData();
        Get.back();
        Get.put(BottomBarBackend()).updateIndex(10);
      } else {
        print("Update profile data failed: ${response.statusCode}");
      }
    } catch (e) {
      print("update profile data failed: $e");
    }
  }

  updateProfile2(ProfileModel model, BuildContext context) async {
    try {
      String token = await StorageService().read(DbKeys.authToken);
      var response = await HttpServices.patchWithToken(
          ApiConstants.updateProfile, jsonEncode(model.toJson()), token);

      if (response.statusCode == 200) {
        fetchProfileData();
      } else {
        print("Update profile data failed: ${response.statusCode}");
      }
    } catch (e) {
      print("update profile data failed: $e");
    }
  }

  updateSubscriptionProfile(ProfileModel model) async {
    try {
      String token = await StorageService().read(DbKeys.authToken);
      var response = await HttpServices.patchWithToken(
          ApiConstants.updateProfile, jsonEncode(model.toJson()), token);

      if (response.statusCode == 200) {
        Get.deleteAll();
        Get.offAll(() => SplashScreen());
      } else {
        print("Update profile data failed: ${response.statusCode}");
      }
    } catch (e) {
      print("update profile data failed: $e");
    }
  }
}
