class FoodModel {
  final String id;
  final bool popular;
  final String description;
  final bool featured;
  String name;
  final String image;
  final Map restaurant;
  final String badge;
  final List ingredients;
  String protien;
  String fat;
  String carbs;
  String calories;
  final String category;

  FoodModel({
    required this.id,
    required this.popular,
    required this.description,
    required this.featured,
    required this.name,
    required this.image,
    required this.restaurant,
    required this.badge,
    required this.ingredients,
    required this.protien,
    required this.fat,
    required this.carbs,
    required this.calories,
    required this.category,
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
        id: json['_id'],
        popular: json['popular'],
        description: json['description'],
        featured: json['featured'],
        name: json['name'],
        image: json['image'],
        restaurant: json['restaurant'],
        badge: json['badge'],
        ingredients: json['ingredients'],
        protien: json['protien'],
        fat: json['fat'],
        carbs: json['carbs'],
        calories: json['calories'],
        category: json['category']);
  }
}
