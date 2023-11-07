// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:eight_hundred_cal/backend/bottom_bar/bottom_bar_backend.dart';
import 'package:eight_hundred_cal/backend/restaurant/restaurant_backend.dart';
import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:eight_hundred_cal/utils/colors.dart';
import 'package:eight_hundred_cal/utils/constants.dart';
import 'package:eight_hundred_cal/widgets/bottom_sheet_divider.dart';
import 'package:eight_hundred_cal/widgets/restaurant_card.dart';

import '../../utils/app_text.dart';

String restaurantId = "";

class RestaurantDetailPage extends StatefulWidget {
  const RestaurantDetailPage({super.key});

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.put(RestaurantBackend()).fetchRestaurantDetails(restaurantId);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColor.pimaryColor,
      body: GetBuilder<RestaurantBackend>(builder: (controller) {
        return SingleChildScrollView(
          child: Stack(
            children: [
              SizedBox(
                height: height(context) * 1.8,
              ),
              RestaurantDetailImage(),
              RestaurantDetailLogo(
                logo: controller.restaurantModel != null
                    ? controller.restaurantModel!.logo
                    : "https://images.unsplash.com/photo-1555396273-367ea4eb4db5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8cmVzdGF1cmFudHxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=800&q=60",
              ),
              RestaurantDetailBottomSheet(),
            ],
          ),
        );
      }),
    ));
  }
}

class RestaurantDetailBottomSheet extends StatelessWidget {
  const RestaurantDetailBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var c = Get.put(TranslatorBackend());
    return Positioned(
      left: 0,
      right: 0,
      top: height(context) * .37,
      child: GetBuilder<RestaurantBackend>(builder: (controller) {
        return Container(
          width: width(context),
          padding:
              EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 15),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: AppColor.pimaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: BottomSheetDivider()),
              heightBox(20),
              PopularCard(
                showBubble: false,
                value: controller.restaurantModel != null &&
                        controller.restaurantModel!.tags.isNotEmpty
                    ? controller.restaurantModel!.tags.first
                        .toString()
                        .toUpperCase()
                    : "Popular",
              ),
              heightBox(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    controller.restaurantModel != null
                        ? controller.restaurantModel!.title ?? ""
                        : c.lang == 'en'
                            ? AppText.darkModeEn
                            : AppText.darkModeAr,
                    style: TextStyle(
                      color: AppColor.whiteColor,
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Image.asset(
                    "assets/icons/leaf.png",
                    height: 20,
                    width: 20,
                  ),
                ],
              ),
              heightBox(20),
              Row(
                children: [
                  Image.asset(
                    "assets/icons/star.png",
                    width: 20,
                    height: 20,
                  ),
                  widthBox(5),
                  Text(
                    '${controller.restaurantModel != null ? controller.restaurantModel!.rating ?? "4" : "4"} ${c.lang == 'en' ? AppText.ratingEn : AppText.ratingAr}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColor.textgreyColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  widthBox(25),
                  // Image.asset(
                  //   "assets/icons/comments.png",
                  //   width: 20,
                  //   height: 20,
                  // ),
                  // widthBox(5),
                  // Text(
                  //   '${controller.restaurantModel != null ? controller.restaurantModel!.comments.length : "0"} Comments',
                  //   textAlign: TextAlign.center,
                  //   style: TextStyle(
                  //     color: AppColor.textgreyColor,
                  //     fontSize: 14,
                  //     fontWeight: FontWeight.w400,
                  //   ),
                  // ),
                ],
              ),
              heightBox(20),
              Text(
                controller.restaurantModel != null
                    ? controller.restaurantModel!.description ??
                        "${c.lang == 'en' ? AppText.dummyEn : AppText.dummyAr}..."
                    : "${c.lang == 'en' ? AppText.dummyEn : AppText.dummyAr}...",
                style: TextStyle(
                  color: AppColor.reviewCardTextColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
              heightBox(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    c.lang == 'en'
                        ? AppText.popularMenuEn
                        : AppText.popularMenuAr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColor.whiteColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.put(BottomBarBackend()).updateIndex(23);
                    },
                    child: Text(
                      c.lang == 'en' ? AppText.viewMoreEn : AppText.viewMoreAr,
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
              ListView.separated(
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
                        image: controller.restaurantModel!.menu[index]['image'],
                        restaurantName: controller.restaurantModel!.menu[index]
                            ['restaurant']['title'],
                        rating: controller.restaurantModel!.menu[index]
                            ['restaurant']['rating'],
                      ));
                },
                separatorBuilder: (context, index) => heightBox(15),
              ),
              heightBox(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    c.lang == 'en'
                        ? AppText.similarRestaurantsEn
                        : AppText.similarRestaurantsAr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColor.whiteColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      c.lang == 'en' ? AppText.viewMoreEn : AppText.viewMoreAr,
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
                height: 200,
                child: ListView.separated(
                  itemCount: controller.restaurantModel != null
                      ? controller.similarRestaurants.length
                      : 0,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.put(BottomBarBackend()).updateIndex(8);
                        restaurantId = controller.similarRestaurants[index].id;
                      },
                      child: RestaurantCard(
                        model: controller.similarRestaurants[index],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => widthBox(15),
                ),
              ),
              heightBox(20),
              Text(
                c.lang == 'en'
                    ? AppText.previousOrdersEn
                    : AppText.previousOrdersAr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColor.whiteColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              heightBox(15),
              ListView.separated(
                itemCount: 0,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {
                        Get.put(BottomBarBackend()).updateIndex(9);
                      },
                      child: PopularItemCard(
                        name: 'BreakFast',
                        image:
                            'https://images.unsplash.com/photo-1550547660-d9450f859349?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Zm9vZCUyMGltYWdlfGVufDB8fDB8fHww&auto=format&fit=crop&w=800&q=60',
                        rating: 4,
                        restaurantName: 'Dummy',
                      ));
                },
                separatorBuilder: (context, index) => heightBox(15),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class PopularItemCard extends StatefulWidget {
  String image;
  String name;
  String restaurantName;
  num rating;
  PopularItemCard({
    Key? key,
    required this.image,
    required this.name,
    required this.restaurantName,
    required this.rating,
  }) : super(key: key);

  @override
  State<PopularItemCard> createState() => _PopularItemCardState();
}

class _PopularItemCardState extends State<PopularItemCard> {
  var c = Get.put(TranslatorBackend());
  String name = '';
  String restaurantName = '';

  _changeLanguage() async {
    name = await c.translateText(widget.name);
    restaurantName = await c.translateText(widget.restaurantName);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _changeLanguage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColor.inputBoxBGColor,
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: ShapeDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.image ??
                    "https://images.unsplash.com/photo-1521406165259-fe90230792da?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTF8fGZvb2QlMjBkaXNoZXMlMjBpbWFnZXxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=800&q=60"),
                fit: BoxFit.fill,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
          ),
          widthBox(12),
          SizedBox(
            width: width(context) * .5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  restaurantName,
                  style: TextStyle(
                    color: AppColor.textgreyColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
          Spacer(),
          SizedBox(
            height: 10,
            child: ListView.builder(
              itemCount: 5,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Icon(
                  index > widget.rating - 1 ? Icons.star_border : Icons.star,
                  color: AppColor.secondaryColor,
                  size: 10,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PopularCard extends StatefulWidget {
  bool showBubble;
  String value;
  PopularCard({
    super.key,
    this.showBubble = false,
    this.value = "Popular",
  });

  @override
  State<PopularCard> createState() => _PopularCardState();
}

class _PopularCardState extends State<PopularCard> {
  String badge = "Popular";

  _checkLanguage() async {
    var c = await Get.put(TranslatorBackend()).translateText(widget.value);
    setState(() {
      badge = c;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkLanguage();
  }

  @override
  Widget build(BuildContext context) {
    var c = Get.put(TranslatorBackend());
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: ShapeDecoration(
            color: AppColor.greenShadeColor.withOpacity(.1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(21),
            ),
          ),
          child: GetBuilder<RestaurantBackend>(builder: (controller) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Text(
                badge,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColor.secondaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }),
        ),
        widget.showBubble
            ? Container(
                width: 20,
                height: 20,
                padding: const EdgeInsets.all(3),
                decoration: ShapeDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(1.00, 0.00),
                    end: Alignment(-1, 0),
                    colors: [AppColor.secondaryColor, AppColor.greenColor],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27),
                  ),
                ),
                child: Center(
                  child: Text(
                    '1/4',
                    style: TextStyle(
                      color: AppColor.whiteColor,
                      fontSize: 8,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              )
            : SizedBox(),
      ],
    );
  }
}

class RestaurantDetailLogo extends StatelessWidget {
  final String logo;
  const RestaurantDetailLogo({
    super.key,
    required this.logo,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 20,
      top: height(context) * .28,
      child: Container(
        width: 70,
        height: 70,
        padding: const EdgeInsets.all(15),
        decoration: ShapeDecoration(
          color: AppColor.inputBoxBGColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 0.50, color: AppColor.secondaryColor),
            borderRadius: BorderRadius.circular(80),
          ),
        ),
        child: Center(
          child: Image.network(
            logo,
            width: 90,
            height: 90,
            // fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class RestaurantDetailImage extends StatelessWidget {
  const RestaurantDetailImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RestaurantBackend>(builder: (controller) {
      return Image.network(
        controller.restaurantModel != null
            ? controller.restaurantModel!.image ??
                "https://images.unsplash.com/photo-1555396273-367ea4eb4db5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8cmVzdGF1cmFudHxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=800&q=60"
            : "https://images.unsplash.com/photo-1555396273-367ea4eb4db5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8cmVzdGF1cmFudHxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=800&q=60",
        width: width(context),
        height: height(context) * .4,
        // fit: BoxFit.cover,
      );
    });
  }
}
