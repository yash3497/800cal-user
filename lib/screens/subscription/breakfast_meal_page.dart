// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:eight_hundred_cal/backend/subscription/subscription_backend.dart';
import 'package:eight_hundred_cal/screens/subscription/widgets/meal_select_icon_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BreakFastMealPageScreen extends StatelessWidget {
  final List menu;
  const BreakFastMealPageScreen({super.key, required this.menu});

  @override
  Widget build(BuildContext context) {
    List bList = menu.where((e) => e['category'] == 'breakfast').toList();
    return GetBuilder<SubscriptionBackend>(builder: (controller) {
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.78,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
        ),
        itemCount: bList.length,
        padding: EdgeInsets.only(bottom: 120),
        itemBuilder: (context, index) {
          return MealSelectIconCard(
            data: bList[index],
            index: 0,
          );
        },
      );
    });
  }
}
