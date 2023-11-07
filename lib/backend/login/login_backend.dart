import 'dart:convert';
import 'dart:developer';

import 'package:eight_hundred_cal/backend/login/register_backend.dart';
import 'package:eight_hundred_cal/widgets/error_snak_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../model/profile/profile_model.dart';
import '../../screens/bottom_bar/bottom_bar_screen.dart';
import '../../services/http_service.dart';
import '../../services/storage_service.dart';
import '../../utils/api_constants.dart';
import '../../utils/db_keys.dart';
import '../profile/profile_backend.dart';
import '../subscription/subscription_backend.dart';

class LoginBackend extends GetxController {
  login(String email, String password,
      {bool isSocial = false, String name = ''}) async {
    if (email != "" && password != "") {
      var response = await HttpServices.post(
          ApiConstants.login,
          jsonEncode({
            "username": email,
            "password": password,
          }));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['error']) {
          if (isSocial) {
            Get.put(RegisterBackend()).register(name, email, password);
          } else {
            Get.back();
            ErrorSnackBar(data['message']);
          }
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
        if (isSocial) {
          Get.put(RegisterBackend()).register(name, email, password);
        } else {
          Get.back();
          log(response.body);
          ErrorSnackBar("No user found with this email and password");
        }
      }
    } else {
      Get.back();
      ErrorSnackBar("Please fill all the fields");
    }
  }

  signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    UserCredential cred =
        await FirebaseAuth.instance.signInWithCredential(credential);
    login(cred.user?.email ?? '', 'test1234',
        isSocial: true, name: cred.user?.displayName ?? '');
  }

  signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);
    // Once signed in, return the UserCredential
    UserCredential cred = await FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential);
    login(cred.user?.email ?? '', 'test1234',
        isSocial: true, name: cred.user?.displayName ?? '');
  }
}
