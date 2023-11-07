// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:eight_hundred_cal/widgets/macros_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:eight_hundred_cal/backend/bottom_bar/bottom_bar_backend.dart';
import 'package:eight_hundred_cal/backend/restaurant/restaurant_backend.dart';
import 'package:eight_hundred_cal/screens/home/restaurant_detail_page.dart';
import 'package:eight_hundred_cal/utils/colors.dart';

import '../../utils/app_text.dart';
import '../../utils/constants.dart';
import '../../widgets/bottom_sheet_divider.dart';

class DishInfoPage extends StatelessWidget {
  const DishInfoPage({super.key});

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
                height: height(context) * 1.4,
              ),
              DishInfoImageCard(
                image: controller.menuDetail['image'],
              ),
              DishInforBackButton(),
              RestaurantDetailLogo(
                logo: controller.menuDetail['restaurant']['logo'],
              ),
              DishInfoBottomSheet(
                menu: controller.menuDetail,
              ),
            ],
          ),
        );
      }),
    ));
  }
}

class DishInforBackButton extends StatelessWidget {
  const DishInforBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 20,
      top: 20,
      child: InkWell(
        onTap: () {
          Get.put(BottomBarBackend()).updateIndex(8);
        },
        child: Container(
          width: 24,
          height: 24,
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: AppColor.whiteColor.withOpacity(0.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: Center(
            child: Icon(
              Icons.arrow_back_ios_rounded,
              color: AppColor.whiteColor,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}

class DishInfoBottomSheet extends StatefulWidget {
  final Map menu;
  const DishInfoBottomSheet({
    Key? key,
    required this.menu,
  }) : super(key: key);

  @override
  State<DishInfoBottomSheet> createState() => _DishInfoBottomSheetState();
}

class _DishInfoBottomSheetState extends State<DishInfoBottomSheet> {
  var c = Get.put(TranslatorBackend());
  String name = '';

  _checkLanguage() async {
    name = await c.translateText(widget.menu['name']);
    log("${widget.menu['description']}");
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkLanguage();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      top: height(context) * .37,
      child: Container(
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
            widget.menu['popular'] ? PopularCard() : SizedBox(),
            heightBox(20),
            Text(
              c.lang == 'en' ? AppText.macrosEn : AppText.macrosAr,
              style: TextStyle(
                color: AppColor.whiteColor,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            heightBox(10),
            MacrosWidget(
              protiens: widget.menu['protien'],
              carbs: widget.menu['carbs'],
              calories: widget.menu['calories'],
              fat: widget.menu['fat'],
            ),
            heightBox(20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/icons/leaf.png",
                      width: 20,
                      height: 20,
                    ),
                    widthBox(10),
                    widget.menu['badge'] == 'spicy'
                        ? Image.asset(
                            "assets/icons/chilli.png",
                            width: 20,
                            height: 20,
                          )
                        : SizedBox(),
                  ],
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
                  '${widget.menu['restaurant']['rating']} ${c.lang == 'en' ? AppText.ratingEn : AppText.ratingAr}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColor.textgreyColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                widthBox(25),
                // Image.asset(
                //   "assets/icons/order.png",
                //   width: 20,
                //   height: 20,
                // ),
                // widthBox(5),
                // Text(
                //   '2000+ Order',
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
              '${c.lang == 'en' ? AppText.ingredientsEn : AppText.ingredientsAr}',
              style: TextStyle(
                color: AppColor.whiteColor,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            heightBox(10),
            SizedBox(
              height: 90,
              child: ListView.separated(
                itemCount: widget.menu['ingredients'].length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return IngrediantsCard(
                      image: widget.menu['ingredients'][index]['image'],
                      title: widget.menu['ingredients'][index]['title']);
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    width: 10,
                  );
                },
              ),
            ),
            heightBox(20),
            Text(
              "${widget.menu['description']}",
              style: TextStyle(
                color: AppColor.reviewCardTextColor,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
            heightBox(20),
            // Text(
            //   'Dislikes',
            //   style: TextStyle(
            //     color: AppColor.whiteColor,
            //     fontSize: 18,
            //     fontWeight: FontWeight.w400,
            //   ),
            // ),
            // heightBox(5),
            // Container(
            //   width: double.infinity,
            //   height: 70,
            //   padding: const EdgeInsets.symmetric(horizontal: 30),
            //   clipBehavior: Clip.antiAlias,
            //   decoration: ShapeDecoration(
            //     color: AppColor.inputBoxBGColor,
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(15),
            //     ),
            //   ),
            //   child: Row(
            //     children: [
            //       MultiSlectorDropDownDataCard(
            //         text: 'Onion',
            //       ),
            //       widthBox(10),
            //       MultiSlectorDropDownDataCard(
            //         text: 'Spinach',
            //       ),
            //       Spacer(),
            //       RotatedBox(
            //           quarterTurns: 3,
            //           child: Icon(
            //             Icons.arrow_back_ios,
            //             color: AppColor.lightGreyColor,
            //             size: 20,
            //           )),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class MultiSlectorDropDownDataCard extends StatelessWidget {
  final String text;
  const MultiSlectorDropDownDataCard({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 26,
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      decoration: ShapeDecoration(
        color: AppColor.whiteColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(
              color: AppColor.textgreyColor,
              fontSize: 16,
              fontFamily: GoogleFonts.quicksand().fontFamily,
              fontWeight: FontWeight.w600,
            ),
          ),
          // widthBox(5),
          // Icon(
          //   Icons.close,
          //   color: AppColor.textgreyColor,
          //   size: 16,
          // ),
        ],
      ),
    );
  }
}

class IngrediantsCard extends StatefulWidget {
  final String image;
  final String title;
  const IngrediantsCard({
    super.key,
    required this.image,
    required this.title,
  });

  @override
  State<IngrediantsCard> createState() => _IngrediantsCardState();
}

class _IngrediantsCardState extends State<IngrediantsCard> {
  var c = Get.put(TranslatorBackend());
  String name = '';
  String logo = '';

  _changeLanguage() async {
    name = await c.translateText(widget.title);
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
    return Column(
      children: [
        Container(
          width: 70,
          height: 70,
          padding: const EdgeInsets.all(5),
          decoration: ShapeDecoration(
            color: AppColor.inputBoxBGColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: Center(
            child: Image.network(
              widget.image,
              width: 60,
              height: 60,
            ),
          ),
        ),
        Text(
          name,
          style: TextStyle(
            color: AppColor.whiteColor,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}

class MacrosCard extends StatelessWidget {
  final String title;
  final String logo;
  final String description;
  const MacrosCard({
    super.key,
    required this.title,
    required this.logo,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    var c = Get.put(TranslatorBackend());
    return Container(
      width: 80,
      height: 80,
      decoration: ShapeDecoration(
        color: AppColor.inputBoxBGColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(80),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColor.secondaryColor,
              fontSize: c.lang == 'en' ? 18 : 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                logo,
                width: 14,
                height: 14,
              ),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColor.whiteColor,
                  fontSize: 9,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class DishInfoImageCard extends StatelessWidget {
  final String image;
  const DishInfoImageCard({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      image,
      width: width(context),
      height: height(context) * .4,
      fit: BoxFit.cover,
    );
  }
}
