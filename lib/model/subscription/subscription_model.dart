import 'package:eight_hundred_cal/model/meal/meal_model.dart';
import 'package:eight_hundred_cal/model/program/program_model.dart';

import '../restaurant/group_restaurant_model.dart';

class SubscriptionModel {
  late ProgramModel _program;
  late String _duration;
  late DateTime _startDate;
  late MealModel _meal;
  late bool _includeFriday;
  late DateTime _endDate;
  List<String> _allergies = [];
  List<String> _allergiesID = [];
  List<String> _dislikes = [];
  List<String> _dislikesID = [];
  late GroupRestaurantCategoryModel _restaurant;
  late String _groupRestaurantCategory;
  bool _discount = false;
  late int _discountPrice;

  ProgramModel get program => _program;

  set program(ProgramModel value) {
    _program = value;
  }

  String get duration => _duration;

  set duration(String value) {
    _duration = value;
  }

  DateTime get startDate => _startDate;

  set startDate(DateTime value) {
    _startDate = value;
  }

  MealModel get meal => _meal;

  set meal(MealModel value) {
    _meal = value;
  }

  bool get includeFriday => _includeFriday;

  set includeFriday(bool value) {
    _includeFriday = value;
  }

  DateTime get endDate => _endDate;

  set endDate(DateTime value) {
    _endDate = value;
  }

  List<String> get allergies => _allergies;

  set allergies(List<String> value) {
    _allergies = value;
  }

  List<String> get allergiesID => _allergiesID;

  set allergiesID(List<String> value) {
    _allergiesID = value;
  }

  List<String> get dislikes => _dislikes;

  set dislikes(List<String> value) {
    _dislikes = value;
  }

  List<String> get dislikesID => _dislikesID;

  set dislikesID(List<String> value) {
    _dislikes = value;
  }

  GroupRestaurantCategoryModel get restaurant => _restaurant;

  set restaurant(GroupRestaurantCategoryModel value) {
    _restaurant = value;
  }

  String get groupRestaurantCategory => _groupRestaurantCategory;

  set groupRestaurantCategory(String value) {
    _groupRestaurantCategory = value;
  }

  bool get discount => _discount;

  set discount(bool value) {
    _discount = value;
  }

  int get discountPrice => _discountPrice;

  set discountPrice(int value) {
    _discountPrice = value;
  }

  // SubscriptionModel({
  //   required ProgramModel program,
  //   required String duration,
  //   required String startDate,
  //   required MealModel meal,
  //   required bool includeFriday,
  //   required String endDate,
  //   required List<String> allergies,
  //   required List<String> dislikes,
  // })  : _dislikes = dislikes,
  //       _allergies = allergies,
  //       _endDate = endDate,
  //       _includeFriday = includeFriday,
  //       _meal = meal,
  //       _startDate = startDate,
  //       _duration = duration,
  //       _program = program;
}
