import 'dart:developer';

class RestaurantModel {
  final String id;
  String title;
  List tags;
  final String username;
  final String email;
  final bool verified;
  final String role;
  final bool closed;
  final bool enabled;
  final String createdAt;
  final Map category;
  String description;
  final String logo;
  final num rating;

  RestaurantModel(
      {required this.id,
      required this.title,
      required this.tags,
      required this.username,
      required this.email,
      required this.verified,
      required this.role,
      required this.closed,
      required this.enabled,
      required this.createdAt,
      required this.category,
      required this.description,
      required this.logo,
      required this.rating});

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      id: json['_id'],
      title: json['title'],
      tags: json['tags'] ?? [],
      username: json['username'],
      email: json['email'],
      verified: json['verified'],
      role: json['role'],
      closed: json['closed'],
      enabled: json['enabled'],
      createdAt: json['created_at'],
      category: json['category'],
      description: json['description'] != null ? json['description'] : "",
      logo: json['logo'],
      rating: json['rating'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'tags': tags,
      'username': username,
      'email': email,
      'verified': verified,
      'role': role,
      'closed': closed,
      'enabled': enabled,
      'created_at': createdAt,
      'category': category,
      'description': description,
      'logo': logo,
      'rating': rating,
    };
  }
}
