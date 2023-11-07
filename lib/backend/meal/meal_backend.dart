import 'dart:convert';

import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:eight_hundred_cal/model/meal/meal_model.dart';
import 'package:get/get.dart';

import '../../services/http_service.dart';
import '../../utils/api_constants.dart';

class MealBackend extends GetxController {
  List<MealModel> mealList = [];

  fetchAllMeals(String programId) async {
    try {
      var c = Get.put(TranslatorBackend());
      final response =
          await HttpServices.get("${ApiConstants.meals}$programId");
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        List mList = data['meal'];
        mealList = mList.map((e) => MealModel.fromJson(e)).toList();
        for (int i = 0; i < mealList.length; i++) {
          mealList[i].name = await c.translateText(mealList[i].name);
          List d = [];
          for (int j = 0; j < mealList[i].description.length; j++) {
            d.add(await c.translateText(mealList[i].description[j]));
          }
          mealList[i].description = d;
        }
        update();
      } else {
        print("${response.statusCode}");
      }
    } catch (e) {
      print("FETCH ALL MEALS: $e");
    }
  }
}
