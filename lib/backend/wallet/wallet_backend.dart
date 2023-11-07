// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:eight_hundred_cal/backend/payments/payment_gateway.dart';
import 'package:eight_hundred_cal/backend/profile/profile_backend.dart';
import 'package:eight_hundred_cal/model/profile/profile_model.dart';
import 'package:eight_hundred_cal/model/wallet/transaction_model.dart';
import 'package:eight_hundred_cal/widgets/error_snak_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/http_service.dart';
import '../../services/storage_service.dart';
import '../../utils/api_constants.dart';
import '../../utils/db_keys.dart';
import '../translator/translator_backend.dart';

class WalletBackend extends GetxController {
  ProfileModel? model;
  List<TransactionModel> transactionList = [];

  fetchProfileData() async {
    try {
      var c = Get.put(TranslatorBackend());
      String token = await StorageService().read(DbKeys.authToken);
      var response =
          await HttpServices.getWithToken(ApiConstants.profile, token);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        model = ProfileModel.fromJson(data['customer']);
        update();
      } else {
        print("Fetch profile data failed: ${response.statusCode}");
      }
    } catch (e) {
      print("Fetching profile data failed: $e");
    }
  }

  fetchTransaction() async {
    try {
      var c = Get.put(TranslatorBackend());
      String token = await StorageService().read(DbKeys.authToken);
      var response =
          await HttpServices.getWithToken(ApiConstants.fetchTransaction, token);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        List c = data['transactions'];
        transactionList = c.map((e) => TransactionModel.fromJson(e)).toList();
        update();
      } else {
        print("Fetch Transaction Data failed: ${response.statusCode}");
      }
    } catch (e) {
      print("Fetching transaction data failed: $e");
    }
  }

  createTransaction(
      BuildContext context, String amount, String description, bool debited,
      {bool isOrder = false}) async {
    try {
      String token = await StorageService().read(DbKeys.authToken);
      Map body = {
        "amount": int.parse(amount),
        "debited": debited,
        "description": description,
      };
      var response = await HttpServices.postWithToken(
          ApiConstants.createTransaction, jsonEncode(body), token);
      if (response.statusCode == 200) {
        fetchProfileData();
        fetchTransaction();
        if (!isOrder) {
          Get.back();
        }
      } else {
        if (!isOrder) {
          Get.back();
        }
        print("Create Transaction Error: ${response.statusCode}");
      }
    } catch (e) {
      if (!isOrder) {
        Get.back();
      }
      print("Wallet Create Transaction Error: $e");
    }
  }
}
