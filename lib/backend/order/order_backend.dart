import 'dart:convert';
import 'dart:developer';

import 'package:eight_hundred_cal/model/order/order_model.dart';
import 'package:eight_hundred_cal/services/http_service.dart';
import 'package:eight_hundred_cal/services/storage_service.dart';
import 'package:eight_hundred_cal/utils/api_constants.dart';
import 'package:eight_hundred_cal/utils/db_keys.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class OrderBackend extends GetxController {
  String orderId = '';
  String invoiceNo = '';
  int discountPercentage = 0;
  int discountAmount = 0;
  String discountId = '';
  List<OrderModel> orderList = [];
  List<OrderModel> tempOrderList = [];

  applyDiscount(String coupon, num amount) async {
    try {
      String token = await StorageService().read(DbKeys.authToken);
      Map body = {"code": coupon, "amount": amount};
      var response = await HttpServices.postWithToken(
        ApiConstants.discount,
        jsonEncode(body),
        token,
      );
      log(token);
      if (response.statusCode == 200) {
        Get.back();
        var data = jsonDecode(response.body);
        log(data.toString());
        if (data['error']) {
          Fluttertoast.showToast(msg: 'Invalid Code');
        } else {
          discountAmount = data['data']['discountAmount'];
          discountPercentage = data['data']['percentage'];
          discountId = data['data']['_id'];
          update();
        }
      } else {
        Get.back();
        Fluttertoast.showToast(msg: 'Invalid Code');
      }
    } catch (e) {
      print("Apply Discount Error: $e");
    }
  }

  addOrders(Map data) async {
    try {
      String token = await StorageService().read(DbKeys.authToken);
      var response = await HttpServices.postWithToken(
          ApiConstants.createOrder, jsonEncode(data), token);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        orderId = data['subscription']['_id'];
        log("Order Id: $orderId");
        update();
      } else {
        print('Failed to create order: ${response.statusCode}');
      }
    } catch (e) {
      print("Add Order Error: $e");
    }
  }

  fetchOrder() async {
    try {
      String token = await StorageService().read(DbKeys.authToken);
      var response =
          await HttpServices.getWithToken(ApiConstants.fetchOrder, token);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        orderList = List<OrderModel>.from(
            data['subscriptions'].map((e) => OrderModel.fromJson(e))).toList();
        tempOrderList = orderList;
        update();
      } else {
        print("Fetch Orders Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Ftech Orders Error: $e");
    }
  }

  searchOrder(String value) {
    if (value != "") {
      orderList = tempOrderList
          .where((element) => element.program['name']
              .toString()
              .toLowerCase()
              .contains(value.toLowerCase()))
          .toList();
    } else {
      orderList = tempOrderList;
    }
    update();
  }
}
