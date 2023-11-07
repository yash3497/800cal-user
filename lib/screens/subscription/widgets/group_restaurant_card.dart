import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:eight_hundred_cal/model/restaurant/group_restaurant_model.dart';
import 'package:eight_hundred_cal/model/restaurant/restaurant_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';
import '../../../utils/constants.dart';

class GroupRestaurantCard extends StatefulWidget {
  final RestaurantModel model;
  const GroupRestaurantCard({
    super.key,
    required this.model,
  });

  @override
  State<GroupRestaurantCard> createState() => _GroupRestaurantCardState();
}

class _GroupRestaurantCardState extends State<GroupRestaurantCard> {
  String title = "";

  _changeLanguage() async {
    title =
        await Get.put(TranslatorBackend()).translateText(widget.model.title);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _changeLanguage();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColor.inputBoxBGColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(9.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Image.asset(
                "assets/icons/leaf2.png",
                width: 20,
                height: 20,
              ),
            ),
            Image.network(
              widget.model.logo,
              width: 70,
              height: 70,
            ),
            heightBox(15),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColor.whiteColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    );
  }
}
