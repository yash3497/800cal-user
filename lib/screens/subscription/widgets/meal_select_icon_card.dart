import 'dart:developer';

import 'package:eight_hundred_cal/backend/restaurant/restaurant_backend.dart';
import 'package:eight_hundred_cal/backend/subscription/subscription_backend.dart';
import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:eight_hundred_cal/screens/home/restaurant_detail_page.dart';
import 'package:eight_hundred_cal/screens/subscription/choose_your_meals_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../utils/app_text.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../../../widgets/custom_button.dart';

class MealSelectIconCard extends StatefulWidget {
  final Map data;
  final int index;
  const MealSelectIconCard({
    super.key,
    required this.data,
    required this.index,
  });

  @override
  State<MealSelectIconCard> createState() => _MealSelectIconCardState();
}

class _MealSelectIconCardState extends State<MealSelectIconCard> {
  var c = Get.put(TranslatorBackend());
  String name = '';

  _changeLan() async {
    name = await c.translateText(widget.data['name']);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _changeLan();
  }

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(SubscriptionBackend());
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: AppColor.inputBoxBGColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
          Align(
            alignment: Alignment.topRight,
            child: Image.asset(
              "assets/icons/leaf2.png",
              width: 20,
              height: 20,
            ),
          ),
          Image.network(
            widget.data['image'],
            width: 90,
            height: 90,
          ),
          Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColor.whiteColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            '${widget.data['calories']}',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColor.reviewCardTextColor,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/icons/wheat.png",
                width: 12,
                height: 12,
              ),
              Text(
                '${c.lang == 'en' ? AppText.carbsEn : AppText.carbsAr}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColor.reviewCardTextColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
              widthBox(4),
              Image.asset(
                "assets/icons/muscle.png",
                width: 12,
                height: 12,
              ),
              Text(
                '${c.lang == 'en' ? AppText.protiensEn : AppText.protiensAr}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColor.reviewCardTextColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
              widthBox(4),
              Image.asset(
                "assets/icons/drops.png",
                width: 12,
                height: 12,
              ),
              Text(
                '${c.lang == 'en' ? AppText.fatEn : AppText.fatAr}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColor.reviewCardTextColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          heightBox(4),
          SizedBox(
              width: 70,
              height: 23,
              child: controller.dateMealList[
                          DateFormat('dd-MMM-yyyy').format(mealDate)] !=
                      null
                  ? controller.dateMealList[DateFormat('dd-MMM-yyyy')
                              .format(mealDate)]['food']
                          .contains(widget.data['_id'])
                      ? Center(
                          child: Text(
                            '${c.lang == 'en' ? AppText.selectedEn : AppText.selectedAr}',
                            style: TextStyle(
                              color: AppColor.secondaryColor,
                              fontSize: 14,
                            ),
                          ),
                        )
                      : CustomButton(
                          text:
                              '${c.lang == 'en' ? AppText.selectEn : AppText.selectAr}',
                          onTap: () {
                            log("Data: ${widget.data}");
                            if (Get.put(RestaurantBackend()).edit) {
                              Get.put(SubscriptionBackend()).addUpdateMeal(
                                mealDate,
                                widget.data['_id'],
                                widget.data['calories'],
                                widget.data['carbs'],
                                widget.data['fat'],
                                widget.data['protien'],
                                widget.index,
                              );
                            } else {
                              Get.put(SubscriptionBackend()).addMeal(
                                mealDate,
                                widget.data['_id'],
                                widget.data['calories'],
                                widget.data['carbs'],
                                widget.data['fat'],
                                widget.data['protien'],
                                restaurantId,
                              );
                            }
                          },
                        )
                  : CustomButton(
                      text:
                          '${c.lang == 'en' ? AppText.selectEn : AppText.selectAr}',
                      onTap: () {
                        log("Data: ${widget.data}");
                        log("Data111: ${Get.put(RestaurantBackend()).edit}");
                        if (Get.put(RestaurantBackend()).edit) {
                          Get.put(SubscriptionBackend()).addUpdateMeal(
                            mealDate,
                            widget.data['_id'],
                            widget.data['calories'],
                            widget.data['carbs'],
                            widget.data['fat'],
                            widget.data['protien'],
                            widget.index,
                          );
                        } else {
                          Get.put(SubscriptionBackend()).addMeal(
                            mealDate,
                            widget.data['_id'],
                            widget.data['calories'],
                            widget.data['carbs'],
                            widget.data['fat'],
                            widget.data['protien'],
                            restaurantId,
                          );
                        }
                      },
                    )),
        ]),
      ),
    );
  }
}
