import 'dart:convert';
import 'dart:developer';

import 'package:eight_hundred_cal/widgets/error_snak_bar.dart';
import 'package:get/get.dart';

import '../../model/profile/profile_model.dart';
import '../../screens/bottom_bar/bottom_bar_screen.dart';
import '../../services/http_service.dart';
import '../../services/storage_service.dart';
import '../../utils/api_constants.dart';
import '../../utils/db_keys.dart';
import '../profile/profile_backend.dart';
import '../subscription/subscription_backend.dart';

class RegisterBackend extends GetxController {
  register(String name, String email, String password) async {
    if (email != "" && password != "" && name != "") {
      var response = await HttpServices.post(
          ApiConstants.register,
          jsonEncode({
            "username": email,
            "password": password,
            "email": email,
            "firstname": name,
            "lastname": name,
          }));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['error']) {
          Get.back();
          ErrorSnackBar(data['message']);
        } else {
          log("Login Data: $data");
          StorageService().write(DbKeys.authToken, data["token"]);
          Get.back();
          var controller = Get.put(ProfileBackend());
          await controller.fetchProfileData().then((value) async {
            if (value) {
              ProfileModel model = Get.put(ProfileBackend()).model!;
              await Get.put(SubscriptionBackend())
                  .fetchSubscriptionData(model.subscriptionId);
              Get.offAll(() => BottomBarScreen());
            }
          });
        }
      } else {
        Get.back();
        log(response.body);
        ErrorSnackBar("Something went wrong");
      }
    } else {
      Get.back();
      ErrorSnackBar("Please fill all the fields");
    }
  }

  registerSubProfile(ProfileModel model) async {
    try {
      ProfileModel primaryModel = Get.put(ProfileBackend()).model!;
      Map data = {
        "username": model.email,
        "password": model.password,
        "email": model.email,
        "firstname": model.firstname,
        "lastname": model.lastname,
      };
      var response =
          await HttpServices.post(ApiConstants.register, jsonEncode(data));
      if (response.statusCode == 200) {
        var resBody = jsonDecode(response.body);
        String token = resBody["token"];
        List arr = primaryModel.subusers;
        arr.remove(token);
        model.subusers.addAll(arr);
        var resp = await HttpServices.patchWithToken(
            ApiConstants.updateProfile, jsonEncode(model.toJson()), token);
        if (resp.statusCode == 200) {
          primaryModel.subusers.add(token);
          var resFinal = await HttpServices.patchWithToken(
              ApiConstants.updateProfile,
              jsonEncode(primaryModel.toJson()),
              token);
          if (resFinal.statusCode == 200) {
            Get.put(ProfileBackend()).fetchProfileData();
            Get.back();
            Get.back();
          }
        }
      } else {
        print("Register Sub Profile Error: ${response.body}");
      }
    } catch (e) {
      print("Register Sub Profile Error: $e");
    }
  }
}
