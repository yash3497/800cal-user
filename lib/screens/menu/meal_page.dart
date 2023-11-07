// ignore_for_file: prefer_const_constructors

import 'package:eight_hundred_cal/screens/menu/widgets/meal_select_card.dart';
import 'package:flutter/material.dart';

class MealPageScreen extends StatelessWidget {
  const MealPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
      ),
      itemCount: 10,
      itemBuilder: (context, index) {
        return MealSelectCard();
      },
    );
  }
}
