class IngredientModel {
  final String id;
  String title;
  final String image;

  IngredientModel({required this.id, required this.title, required this.image});

  factory IngredientModel.fromJson(Map<String, dynamic> json) {
    return IngredientModel(
        id: json['_id'], title: json['title'], image: json['image']);
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'image': image,
    };
  }
}
