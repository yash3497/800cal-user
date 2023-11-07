class MealModel {
  final String id;
  String name;
  final String logo;
  final List tags;
  List description;
  final String programId;

  MealModel(
      {required this.id,
      required this.name,
      required this.logo,
      required this.tags,
      required this.description,
      required this.programId});

  factory MealModel.fromJson(Map<String, dynamic> json) {
    return MealModel(
        id: json['_id'],
        name: json['name'],
        logo: json['logo'],
        tags: json['tags'],
        description: json['description'],
        programId: json['program']);
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'logo': logo,
      'tags': tags,
      'description': description,
      'program': programId
    };
  }
}
