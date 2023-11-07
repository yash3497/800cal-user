import 'dart:convert';
import 'dart:developer';

import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:eight_hundred_cal/model/food/food_model.dart';
import 'package:eight_hundred_cal/services/http_service.dart';
import 'package:eight_hundred_cal/services/storage_service.dart';
import 'package:eight_hundred_cal/utils/api_constants.dart';
import 'package:eight_hundred_cal/utils/constants.dart';
import 'package:eight_hundred_cal/utils/db_keys.dart';
import 'package:get/get.dart';

class FoodBackend extends GetxController {
  Future<FoodModel> fetchFoodById(String id) async {
    FoodModel model = dummyFoodModel;
    try {
      FoodModel model = FoodModel(
          id: '',
          popular: false,
          description: '',
          featured: false,
          name: '',
          image: '',
          restaurant: {},
          badge: '',
          ingredients: [],
          protien: '',
          fat: '',
          carbs: '',
          calories: '',
          category: '');
      var c = Get.put(TranslatorBackend());
      String token = await StorageService().read(DbKeys.authToken);
      String url = '${ApiConstants.food}$id';
      var response = await HttpServices.getWithToken(url, token);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        model = FoodModel.fromJson(data['food']);
        log(response.statusCode.toString());
        model.name = await c.translateText(model.name);
        model.calories = await c.translateText(model.calories);
        model.protien = await c.translateText(model.protien);
        model.fat = await c.translateText(model.fat);
        model.carbs = await c.translateText(model.carbs);
        update();
        return model;
      } else {
        print("Failed to load food");
      }
      return model;
    } catch (e) {
      print('Fetch Food By ID Error: $e');
      return model;
    }
  }
}
