import 'package:eight_hundred_cal/backend/restaurant/restaurant_backend.dart';
import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:eight_hundred_cal/screens/home/restaurant_detail_page.dart';
import 'package:eight_hundred_cal/utils/app_text.dart';
import 'package:eight_hundred_cal/utils/colors.dart';
import 'package:eight_hundred_cal/utils/constants.dart';
import 'package:eight_hundred_cal/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../backend/bottom_bar/bottom_bar_backend.dart';

class PopularMenuList extends StatelessWidget {
  const PopularMenuList({super.key});

  @override
  Widget build(BuildContext context) {
    var c = Get.put(TranslatorBackend());
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.pimaryColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding)
              .copyWith(top: 20),
          child: Column(
            children: [
              CustomAppBar(
                text: c.lang == 'en'
                    ? AppText.popularMenuEn
                    : AppText.popularMenuAr,
              ),
              heightBox(20),
              GetBuilder<RestaurantBackend>(builder: (controller) {
                return ListView.separated(
                  itemCount: controller.restaurantModel != null
                      ? controller.restaurantModel!.menu.length <= 3
                          ? controller.restaurantModel!.menu.length
                          : 3
                      : 0,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () {
                          controller.addMenuDetails(
                              controller.restaurantModel!.menu[index]);
                          Get.put(BottomBarBackend()).updateIndex(9);
                        },
                        child: PopularItemCard(
                          name: controller.restaurantModel!.menu[index]['name'],
                          image: controller.restaurantModel!.menu[index]
                              ['image'],
                          restaurantName: controller.restaurantModel!
                              .menu[index]['restaurant']['title'],
                          rating: controller.restaurantModel!.menu[index]
                              ['restaurant']['rating'],
                        ));
                  },
                  separatorBuilder: (context, index) => heightBox(15),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
