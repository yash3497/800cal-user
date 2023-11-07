import 'dart:developer';

import 'package:eight_hundred_cal/backend/order/order_backend.dart';
import 'package:eight_hundred_cal/backend/profile/profile_backend.dart';
import 'package:eight_hundred_cal/backend/wallet/wallet_backend.dart';
import 'package:eight_hundred_cal/screens/subscription/payment_failed_page.dart';
import 'package:eight_hundred_cal/screens/subscription/payment_sucessful_page.dart';
import 'package:eight_hundred_cal/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_upayments/flutter_upayments.dart';
import 'package:get/get.dart';

import '../../services/storage_service.dart';
import '../../utils/db_keys.dart';

class PaymentGateway extends GetxController {
  String liveApiKey = "2150fc871588a9944f2232044ce8255748a64856";
  String testApiKey = "jtest123";
  String liveUsername = "800cal";
  String testUsername = "test";
  String livePassword = "k@pNKqrNTxFs";
  String testPassword = "test";
  String liveMerchantId = "10136";
  String testMerchantId = "1201";

  requestPayments({
    required BuildContext context,
    required String amount,
    required String customerName,
    required String customerEmail,
    required String customerPhone,
    required bool debited,
    required String description,
  }) async {
    paymentDetails userData = paymentDetails(
      merchantId: "1201",
      username: "test",
      password: "test",
      apiKey: "jtest123",
      orderId: "12345",
      totalPrice: amount,
      currencyCode: "KWD",
      successUrl: "https://example.com/success.html",
      errorUrl: "https://example.com/error.html",
      testMode: "1",
      customerFName: customerName,
      customerEmail: customerEmail,
      customerMobile: customerPhone,
      paymentGateway: "knet",
      whitelabled: "true",
      productTitle: "productTitle",
      productName: "Product1",
      productPrice: "12",
      productQty: "2",
      reference: "Ref00001",
      notifyURL: "https://example.com/success.html",
    );
    await RequestPayment(context, userData, (isSuccess, data, message) async {
      Get.put(WalletBackend())
          .createTransaction(context, amount, description, debited);
    }, (isFailed, data2, message) async {});
    return false;
  }

  orderPayments(
    BuildContext context,
    Map data,
  ) async {
    paymentDetails userData = paymentDetails(
      merchantId: testMerchantId,
      username: testUsername,
      password: testPassword,
      apiKey: testApiKey,
      orderId: "4235",
      totalPrice: data['total'].toString(),
      currencyCode: "KWD",
      successUrl: "https://example.com/success.html",
      errorUrl: "https://example.com/error.html",
      testMode: "1",
      customerFName: data['name'],
      customerEmail: data['email'],
      customerMobile: data['phone'],
      paymentGateway: "knet",
      whitelabled: "true",
      productTitle: "productTitleqwq",
      productName: "Product1qwq",
      productPrice: "15",
      productQty: "1",
      reference: "Ref00008",
      notifyURL: "https://example.com/success.html",
    );
    await RequestPayment(context, userData, (isSuccess, data2, message) async {
      successOrder(context, data, data2);
    }, (isFailed, data2, message) async {
      data['payment_status'] = 'failed';
      Get.to(() => PaymentFailedPage());
      await Get.put(OrderBackend()).addOrders(data);
    });
  }

  successOrder(BuildContext context, Map data, Map data2) async {
    try {
      data['payment_status'] = 'success';

      var controller = Get.put(OrderBackend());

      await controller.addOrders(data);
      controller.invoiceNo = data2['TranID'][0];
      // ignore: use_build_context_synchronously
      await Get.put(WalletBackend()).createTransaction(
          context, data['total'].toString(), "Buy a Subscription Plan", true,
          isOrder: true);
      var c = Get.put(ProfileBackend());
      c.model!.allergy.addAll(subscriptionModel.allergiesID);
      c.model!.dislikes.addAll(subscriptionModel.dislikesID);
      await c.updateProfile2(c.model!, context);
      Get.to(() => PaymentSuccessFulPage());
    } catch (e) {
      print("Order Created: $e");
    }
  }
}
