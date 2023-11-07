import 'dart:convert';
import 'dart:developer';

import 'package:eight_hundred_cal/backend/profile/profile_backend.dart';
import 'package:eight_hundred_cal/backend/restaurant/restaurant_backend.dart';
import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:eight_hundred_cal/model/calendar/calendar_model.dart';
import 'package:eight_hundred_cal/model/ingredient/ingredient_model.dart';
import 'package:eight_hundred_cal/model/profile/profile_model.dart';
import 'package:eight_hundred_cal/screens/home/restaurant_detail_page.dart';
import 'package:eight_hundred_cal/screens/subscription/choose_your_meals_page.dart';
import 'package:eight_hundred_cal/services/http_service.dart';
import 'package:eight_hundred_cal/services/storage_service.dart';
import 'package:eight_hundred_cal/utils/api_constants.dart';
import 'package:eight_hundred_cal/utils/constants.dart';
import 'package:eight_hundred_cal/utils/db_keys.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../model/pie_chart/char_data_model.dart';
import '../../utils/colors.dart';
import '../order/order_backend.dart';

class SubscriptionBackend extends GetxController {
  List<IngredientModel> ingredientList = [];
  bool autofill = true;
  String calories = '500';
  Map dateMealList = {};
  CalendarModel? calendarModel;
  var controller = Get.put(OrderBackend());
  int pending = 0;
  int frozen = 0;
  int delivered = 0;
  int swappable = 0;
  int protien = 0;
  int calorie = 0;
  int carbs = 0;
  int fat = 0;
  int protienT = 0;
  int caloriesT = 0;
  int carbsT = 0;
  int fatT = 0;

  fetchIngredientList() async {
    try {
      var c = Get.put(TranslatorBackend());
      var controller = Get.put(ProfileBackend());
      var response = await HttpServices.get(ApiConstants.ingredients);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        ingredientList = List<IngredientModel>.from(
            data['ingredients'].map((e) => IngredientModel.fromJson(e)));
        for (int i = 0; i < ingredientList.length; i++) {
          ingredientList[i].title =
              await c.translateText(ingredientList[i].title);
          if (controller.model!.allergy.contains(ingredientList[i].id)) {
            subscriptionModel.allergies.add(ingredientList[i].title);
            subscriptionModel.allergiesID.add(ingredientList[i].id);
          }
          if (controller.model!.dislikes.contains(ingredientList[i].id)) {
            subscriptionModel.dislikes.add(ingredientList[i].title);
            subscriptionModel.dislikesID.add(ingredientList[i].id);
          }
        }
        update();
      }
    } catch (e) {
      print("Fetch Ingredient List Error: $e");
    }
  }

  addMeal(DateTime dateTime, String foodId, String calories, String carbs,
      String fat, String protien, String restaurantId) {
    try {
      String date = DateFormat('dd-MMM-yyyy').format(dateTime);
      if (dateMealList.containsKey(date)) {
        dateMealList[date]['food'].add(foodId);
        dateMealList[date]['calories'] +=
            int.parse(calories.replaceAll("kcal", ""));
        dateMealList[date]['carbs'] += int.parse(carbs.replaceAll("g", ""));
        dateMealList[date]['fat'] += int.parse(fat.replaceAll("g", ""));
        dateMealList[date]['protien'] += int.parse(protien.replaceAll("g", ""));
      } else {
        Map data2 = {
          "order": controller.orderId,
          "freezed": false,
          "restaurant": restaurantId,
          "date": mealDate.millisecondsSinceEpoch,
          "food": [foodId],
          "meals": subscriptionModel.meal.id,
          "program": subscriptionModel.program.id,
          "customer": calendarModel?.customer['_id'],
          "calories": int.parse(calories.replaceAll("kcal", "")),
          "carbs": int.parse(carbs.replaceAll("g", "")),
          "fat": int.parse(fat.replaceAll("g", "")),
          "protien": int.parse(protien.replaceAll("g", "")),
        };
        dateMealList[date] = data2;
      }
      update();
    } catch (e) {
      print("Add Meal Error: $e");
    }
  }

  addCalendarMeal() async {
    try {
      String token = await StorageService().read(DbKeys.authToken);
      dateMealList.keys.forEach((element) async {
        Map value = dateMealList[element.toString()];
        Map data = {
          'order': value["order"],
          'freezed': value["freezed"],
          'restaurant': value["restaurant"],
          'date': value['date'],
          'food': value['food'],
          'meals': value['meals'],
          'program': value['program'],
          'customer': value['customer'],
          'protein': value['protien'].toString(),
          'carbs': value['carbs'].toString(),
          'fats': value['fat'].toString(),
          'kcal': value['calories'].toString(),
        };
        var response = await HttpServices.postWithToken(
            ApiConstants.createCalendar, jsonEncode(data), token);
        log(response.statusCode.toString());
        if (response.statusCode == 200) {
          fetchCalendarData();
          dateMealList = {};
        } else {
          Fluttertoast.showToast(msg: "${response.body}");
        }
      });
    } catch (e) {
      print("Add Calendar Meal Error: $e");
    }
  }

  addUpdateMeal(DateTime dateTime, String foodId, String calories, String carbs,
      String fat, String protien, int index) {
    String date = DateFormat('dd-MMM-yyyy').format(dateTime);
    DateFormat format = DateFormat('dd/MM/yyyy');
    List data = calendarModel!.calendar
        .where((element) =>
            format
                .format(DateTime.fromMillisecondsSinceEpoch(element['date']))
                .toString() ==
            format.format(mealDate))
        .toList();
    if (dateMealList.containsKey(date)) {
      List food = dateMealList[date]['food'];
      food[index] = foodId;
      dateMealList[date]['food'] = food;
      dateMealList[date]['calories'] +=
          int.parse(calories.replaceAll("kcal", ""));
      dateMealList[date]['carbs'] += int.parse(carbs.replaceAll("g", ""));
      dateMealList[date]['fat'] += int.parse(fat.replaceAll("g", ""));
      dateMealList[date]['protien'] += int.parse(protien.replaceAll("g", ""));
    } else {
      Map data2 = {
        "order": data[0]['order'],
        "freezed": false,
        "restaurant": restaurantId,
        "date": mealDate.millisecondsSinceEpoch,
        "food": [foodId],
        "meals": data[0]['meals']['_id'],
        "program": data[0]['program']['_id'],
        "customer": data[0]['customer']['_id'],
        "calories": int.parse(calories.replaceAll("kcal", "")),
        "carbs": int.parse(carbs.replaceAll("g", "")),
        "fat": int.parse(fat.replaceAll("g", "")),
        "protien": int.parse(protien.replaceAll("g", "")),
      };
      dateMealList[date] = data2;
      dateMealList[date]['food'] = data[0]['food'];
      List food = dateMealList[date]['food'];
      food[index] = foodId;
      dateMealList[date]['food'] = food;
    }
    update();
  }

  fetchCalendarData() async {
    try {
      String token = await StorageService().read(DbKeys.authToken);
      log("Token: $token");
      log("OrderId: ${controller.orderId}");
      var response = await HttpServices.getWithToken(
          '${ApiConstants.fetchOrder}/${controller.orderId}', token);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        calendarModel = CalendarModel.fromJson(data['subscription']);
        update();
      } else {
        print("Fetch Calendar Data Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Fetch Calendar Data Error: $e");
    }
  }

  fetchSubscriptionData(String id) async {
    try {
      String token = await StorageService().read(DbKeys.authToken);
      log("OrderId: $id");
      var response = await HttpServices.getWithToken(
          '${ApiConstants.fetchOrder}/$id', token);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        calendarModel = CalendarModel.fromJson(data['subscription']);
        daysCalculation();
        _calloriCalc();
      } else {
        print("Fetch Subscription Data Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Fetch Subscription Data Error: $e");
    }
  }

  updateCalendar() async {
    try {
      String token = await StorageService().read(DbKeys.authToken);
      dateMealList.keys.forEach((element) async {
        Map value = dateMealList[element.toString()];
        DateFormat format = DateFormat('dd/MM/yyyy');
        List dataList = calendarModel!.calendar
            .where((element) =>
                format
                    .format(
                        DateTime.fromMillisecondsSinceEpoch(element['date']))
                    .toString() ==
                format.format(mealDate))
            .toList();
        Map data = {
          'order': value["order"],
          'freezed': value["freezed"],
          'restaurant': value["restaurant"],
          'date': value['date'],
          'food': value['food'],
          'meals': value['meals'],
          'program': value['program'],
          'customer': value['customer'],
          'protein': value['protien'].toString(),
          'carbs': value['carbs'].toString(),
          'fats': value['fat'].toString(),
          'kcal': value['calories'].toString(),
        };
        var response = await HttpServices.patchWithToken(
            "${ApiConstants.updateCalendar}${dataList[0]['_id']}",
            jsonEncode(data),
            token);
        log("CalId: ${dataList[0]['_id']}");
        log("data: ${jsonEncode(data)}");
        if (response.statusCode == 200) {
          log("Response Code: ${response.statusCode}");
          fetchCalendarData();
          dateMealList = {};
        } else {
          dateMealList = {};
          Fluttertoast.showToast(msg: "${response.body}");
        }
      });
      Get.put(RestaurantBackend()).edit = false;
    } catch (e) {
      Get.put(RestaurantBackend()).edit = false;
      print("Update Calendar Error: $e");
    }
  }

  freezeDate(bool value, String orderId, String id) async {
    try {
      String token = await StorageService().read(DbKeys.authToken);
      Map data = {
        'order': orderId,
        'freezed': value,
      };
      var response = await HttpServices.patchWithToken(
          "${ApiConstants.updateCalendar}$id", jsonEncode(data), token);
      if (response.statusCode == 200) {
        fetchCalendarData();
        fetchSubscriptionData(id);
        dateMealList = {};
      } else {
        dateMealList = {};
        Fluttertoast.showToast(msg: "${response.body}");
      }
    } catch (e) {
      print("Freezed Update Error: $e");
    }
  }

  Future<bool> autoCalendarFillApi() async {
    try {
      var restaurantController = Get.put(RestaurantBackend());
      int i = 0;
      DateTime dateTime = subscriptionModel.startDate;
      int duration =
          (int.parse(subscriptionModel.duration.split(" ")[0]) * 7).toInt();
      while (i < duration) {
        for (var item in restaurantController.restaurants) {
          var menuController = Get.put(RestaurantBackend());
          await menuController.fetchRestaurantMenu(item.id).then((value) {
            if (menuController.restaurantModel!.menu.isNotEmpty) {
              if (subscriptionModel.meal.description.contains('Breakfast')) {
                List bList = menuController.restaurantModel!.menu
                    .where((e) => e['category'] == 'breakfast')
                    .toList();
                addMeal(
                    dateTime,
                    bList.isNotEmpty ? bList[0]['_id'] : "",
                    bList.isNotEmpty ? bList[0]['calories'] : "",
                    bList.isNotEmpty ? bList[0]['carbs'] : "",
                    bList.isNotEmpty ? bList[0]['fat'] : "",
                    bList.isNotEmpty ? bList[0]['protien'] : "",
                    item.id);
              }
              if (subscriptionModel.meal.description.contains('Main Dish')) {
                List bList = menuController.restaurantModel!.menu
                    .where((e) => e['category'] == 'main-meal')
                    .toList();
                addMeal(
                    dateTime,
                    bList.isNotEmpty ? bList[0]['_id'] : "",
                    bList.isNotEmpty ? bList[0]['calories'] : "",
                    bList.isNotEmpty ? bList[0]['carbs'] : "",
                    bList.isNotEmpty ? bList[0]['fat'] : "",
                    bList.isNotEmpty ? bList[0]['protien'] : "",
                    item.id);
              }
              if (subscriptionModel.meal.description.contains('Snack')) {
                List bList = menuController.restaurantModel!.menu
                    .where((e) => e['category'] == 'snack')
                    .toList();
                addMeal(
                    dateTime,
                    bList.isNotEmpty ? bList[0]['_id'] : "",
                    bList.isNotEmpty ? bList[0]['calories'] : "",
                    bList.isNotEmpty ? bList[0]['carbs'] : "",
                    bList.isNotEmpty ? bList[0]['fat'] : "",
                    bList.isNotEmpty ? bList[0]['protien'] : "",
                    item.id);
              }
            }
          });
          i++;
          dateTime = dateTime.add(Duration(days: 1));
        }
      }
      if (i >= duration) {
        await addCalendarMeal();
        return true;
      }
      return false;
    } catch (e) {
      print("Automatic Calendar Fill Error: $e");
      return false;
    }
  }

  daysCalculation() {
    calendarModel?.calendar.forEach((element) {
      if (element['freezed']) {
        frozen++;
      }
      if (DateTime.fromMillisecondsSinceEpoch(element['date'])
          .isAfter(DateTime.now())) {
        pending++;
      }
    });
    delivered = (calendarModel?.calendar.length ?? 0) - pending - frozen;
    swappable = pending > 2 ? pending - 2 : 0;
    log("Pending: $pending");
    log("Frozen: $frozen");
    log("Delivered: $delivered");
    log("Swappable: $swappable");
    int total = delivered + pending + frozen + swappable;
    if (calendarModel != null && calendarModel!.calendar.isNotEmpty) {
      segments = [
        DonutSegment((delivered / total) * 100, AppColor.reviewCardTextColor),
        DonutSegment((frozen / total) * 100, AppColor.blueColor),
        DonutSegment((pending / total) * 100, AppColor.yellowColor),
        DonutSegment((swappable / total) * 100, AppColor.secondaryColor),
      ];
    }
    update();
  }

  _calloriCalc() {
    protien = calendarModel!.calendar
        .map(
          (e) => int.parse(e['protein']),
        )
        .fold(0, (previous, current) => previous + current);
    calorie = calendarModel!.calendar
        .map(
          (e) => int.parse(e['kcal']),
        )
        .fold(0, (previous, current) => previous + current);
    carbs = calendarModel!.calendar
        .map(
          (e) => int.parse(e['carbs']),
        )
        .fold(0, (previous, current) => previous + current);
    fat = calendarModel!.calendar
        .map(
          (e) => int.parse(e['fats']),
        )
        .fold(0, (previous, current) => previous + current);

    protienT = calendarModel!.calendar
        .map(
          (e) => DateTime.fromMillisecondsSinceEpoch(e['date'])
                  .isBefore(DateTime.now())
              ? int.parse(e['protein'])
              : 0,
        )
        .fold(0, (previous, current) => previous + current);
    caloriesT = calendarModel!.calendar
        .map(
          (e) => DateTime.fromMillisecondsSinceEpoch(e['date'])
                  .isBefore(DateTime.now())
              ? int.parse(e['kcal'])
              : 0,
        )
        .fold(0, (previous, current) => previous + current);
    carbsT = calendarModel!.calendar
        .map(
          (e) => DateTime.fromMillisecondsSinceEpoch(e['date'])
                  .isBefore(DateTime.now())
              ? int.parse(e['carbs'])
              : 0,
        )
        .fold(0, (previous, current) => previous + current);
    fatT = calendarModel!.calendar
        .map(
          (e) => DateTime.fromMillisecondsSinceEpoch(e['date'])
                  .isBefore(DateTime.now())
              ? int.parse(e['fats'])
              : 0,
        )
        .fold(0, (previous, current) => previous + current);
    update();
  }

  cancelSubscription() async {
    try {
      var p = Get.put(ProfileBackend());
      String token = await StorageService().read(DbKeys.authToken);
      ProfileModel? model = p.model;
      String url = "${ApiConstants.updateOrder}${model?.subscriptionId}";
      Map body = {
        "order_status": "cancel",
      };
      var response =
          await HttpServices.patchWithToken(url, jsonEncode(body), token);

      if (response.statusCode == 200) {
        model?.isSubscribed = false;
        model?.subscriptionId = '';
        model?.subscriptionEndDate = 0;
        model?.subscriptionStartDate = 0;
        log("Profile: ${model!.toJson()}");
        p.updateSubscriptionProfile(model);
      }
    } catch (e) {
      print("Subscription Cancel Error: $e");
    }
  }
}
