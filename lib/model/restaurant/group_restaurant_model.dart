import 'package:eight_hundred_cal/model/restaurant/restaurant_model.dart';

class GroupRestaurantModel {
  final GroupRestaurantCategoryModel gold;
  final GroupRestaurantCategoryModel silver;
  final GroupRestaurantCategoryModel platinum;

  GroupRestaurantModel(
      {required this.gold, required this.silver, required this.platinum});

  factory GroupRestaurantModel.fromJson(Map<String, dynamic> json) {
    return GroupRestaurantModel(
        gold: GroupRestaurantCategoryModel.fromJson(json['gold']),
        silver: GroupRestaurantCategoryModel.fromJson(json['silver']),
        platinum: GroupRestaurantCategoryModel.fromJson(json['platinum']));
  }

  Map<String, dynamic> toJson() {
    return {
      'gold': gold.toJson(),
      'silver': silver.toJson(),
      'platinum': platinum.toJson(),
    };
  }
}

class GroupRestaurantCategoryModel {
  final String id;
  final int price;
  final List<RestaurantModel> restaurants;

  GroupRestaurantCategoryModel(
      {required this.price, required this.restaurants, required this.id});

  factory GroupRestaurantCategoryModel.fromJson(Map<String, dynamic> json) {
    return GroupRestaurantCategoryModel(
      price: json['price'],
      id: json['_id'],
      restaurants: List<RestaurantModel>.from(json['restaurants'].map((e) {
        return RestaurantModel.fromJson(e);
      })),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "price": price,
      "restaurants": restaurants.map((e) => e.toJson()).toList(),
      "_id": id,
    };
  }
}
