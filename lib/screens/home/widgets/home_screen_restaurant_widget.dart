import 'package:eight_hundred_cal/backend/restaurant/restaurant_backend.dart';
import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:eight_hundred_cal/utils/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../backend/bottom_bar/bottom_bar_backend.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../../../widgets/restaurant_card.dart';
import '../restaurant_detail_page.dart';

class HomeScreenRestaurantWidget extends StatelessWidget {
  const HomeScreenRestaurantWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(RestaurantBackend()).fetchAllRestaurants();
    var c = Get.put(TranslatorBackend());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              c.lang == 'en'
                  ? AppText.ourRestaurantsEn
                  : AppText.ourRestaurantsAr,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColor.whiteColor,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            InkWell(
              onTap: () {
                Get.put(BottomBarBackend()).updateIndex(5);
              },
              child: Text(
                c.lang == "en" ? AppText.viewMoreEn : AppText.viewMoreAr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColor.secondaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
        heightBox(15),
        SizedBox(
          height: 196,
          child: GetBuilder<RestaurantBackend>(builder: (controller) {
            return ListView.separated(
              itemCount: controller.restaurants.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Get.put(BottomBarBackend()).updateIndex(8);
                    restaurantId = controller.restaurants[index].id;
                  },
                  child: RestaurantCard(
                    model: controller.restaurants[index],
                  ),
                );
              },
              separatorBuilder: (context, index) => widthBox(18),
            );
          }),
        ),
      ],
    );
  }
}
