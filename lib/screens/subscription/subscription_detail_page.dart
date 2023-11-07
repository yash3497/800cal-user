// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:developer';

import 'package:eight_hundred_cal/backend/bottom_bar/bottom_bar_backend.dart';
import 'package:eight_hundred_cal/backend/subscription/subscription_backend.dart';
import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:eight_hundred_cal/services/app_services.dart';
import 'package:eight_hundred_cal/utils/colors.dart';
import 'package:eight_hundred_cal/utils/constants.dart';
import 'package:eight_hundred_cal/widgets/custom_button.dart';
import 'package:eight_hundred_cal/widgets/custom_date_calendar_picker.dart';
import 'package:eight_hundred_cal/widgets/custom_text_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../backend/profile/profile_backend.dart';
import '../../utils/app_text.dart';
import '../../widgets/multi_selector_dropdown.dart';
import '../home/dish_info_page.dart';

class SubscriptionDetailPage extends StatefulWidget {
  const SubscriptionDetailPage({super.key});

  @override
  State<SubscriptionDetailPage> createState() => _SubscriptionDetailPageState();
}

class _SubscriptionDetailPageState extends State<SubscriptionDetailPage> {
  bool isFriday = true;
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  String mealName = '';
  String mealDescription = '';
  var c = Get.put(TranslatorBackend());
  List<String> allergies = [];
  List<String> dislikes = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _changeLanguage();
    _fetchList();

    startDateController.text =
        "${DateFormat('dd-MM-yyyy').format(subscriptionModel.startDate)}";
    subscriptionModel.endDate = subscriptionModel.startDate.add(Duration(
        days: (int.parse(subscriptionModel.duration.split(" ")[0]) * 7) - 1));
    endDateController.text =
        "${DateFormat('dd-MM-yyyy').format(subscriptionModel.endDate)}";
    subscriptionModel.includeFriday = isFriday;
    // subscriptionModel.allergies = Get.put(ProfileBackend()).model!.allergy as List<String>;
    // subscriptionModel.dislikes = Get.put(ProfileBackend()).model!. as List<String>;
  }

  _changeLanguage() async {
    mealDescription =
        await c.translateText(subscriptionModel.meal.description.join(", "));
    mealName = await c.translateText(subscriptionModel.meal.name);

    setState(() {});
  }

  _fetchList() async {
    await Get.put(SubscriptionBackend()).fetchIngredientList();
    subscriptionModel.allergies.forEach((element) async {
      allergies.add(await c.translateText(element));
    });
    subscriptionModel.dislikes.forEach((element) async {
      dislikes.add(await c.translateText(element));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColor.pimaryColor,
      body: GetBuilder<SubscriptionBackend>(builder: (controller) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding)
                .copyWith(top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  c.lang == 'en' ? AppText.detailsEn : AppText.detailsAr,
                  style: TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                heightBox(20),
                SubcriptionTitleImageCard(
                    image: subscriptionModel.program.logo,
                    title: subscriptionModel.program.name,
                    subtitle:
                        '${c.lang == 'en' ? AppText.durationEn : AppText.durationAr}: ${int.parse(subscriptionModel.duration.split(" ")[0]) * 7} ${c.lang == 'en' ? AppText.daysEn : AppText.daysAr}'),
                heightBox(20),
                SubcriptionTitleImageCard(
                    image: subscriptionModel.meal.logo,
                    title: mealDescription,
                    subtitle: mealName),
                heightBox(20),
                SubcriptionTitleImageCard(
                    image:
                        "https://plus.unsplash.com/premium_photo-1663858367001-89e5c92d1e0e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8Zm9vZHxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=800&q=60",
                    title: c.lang == 'en'
                        ? AppText.restaurantGroupEn
                        : AppText.restaurantGroupAr,
                    subtitle: subscriptionModel.groupRestaurantCategory ==
                            'Silver'
                        ? c.lang == 'en'
                            ? AppText.silverEn
                            : AppText.silverAr
                        : subscriptionModel.groupRestaurantCategory == 'Gold'
                            ? c.lang == 'en'
                                ? AppText.goldEn
                                : AppText.goldAr
                            : c.lang == 'en'
                                ? AppText.platinumEn
                                : AppText.platinumAr),
                heightBox(20),
                Text(
                  c.lang == 'en' ? AppText.startDateEn : AppText.startDateAr,
                  style: TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                heightBox(10),
                CustomTextBox(
                  hintText: "Date",
                  controller: startDateController,
                  suffixIcon: Icon(
                    Icons.calendar_month_outlined,
                    color: AppColor.mediumGreyColor,
                  ),
                  readOnly: true,
                  onTap: () async {
                    DateTime value = await customDatePicker(
                        context,
                        DateTime.now(),
                        DateTime.now().add(Duration(days: 5000)));
                    if (value != null) {
                      startDateController.text =
                          DateFormat('dd-MM-yyyy').format(value);
                      subscriptionModel.startDate = value;
                      subscriptionModel.endDate = subscriptionModel.startDate
                          .add(Duration(
                              days: (int.parse(subscriptionModel.duration
                                          .split(" ")[0]) *
                                      7) -
                                  1));
                      int friday = AppServices().countFridaysBetweenDates(
                          subscriptionModel.startDate,
                          subscriptionModel.endDate);
                      if (!isFriday) {
                        subscriptionModel.endDate = subscriptionModel.endDate
                            .add(Duration(days: friday));
                      }
                      endDateController.text =
                          "${DateFormat('dd-MM-yyyy').format(subscriptionModel.endDate)}";
                    }
                  },
                ),
                heightBox(20),
                Text(
                  c.lang == 'en'
                      ? AppText.includeFridayEn
                      : AppText.includeFridayAr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                heightBox(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InculdeFridayChooseButton(
                      isSelected: isFriday,
                      text: c.lang == 'en' ? AppText.yesEn : AppText.yesAr,
                      onTap: () {
                        setState(() {
                          isFriday = true;
                          subscriptionModel.includeFriday = isFriday;
                          int friday = AppServices().countFridaysBetweenDates(
                              subscriptionModel.startDate,
                              subscriptionModel.endDate);
                          log(friday.toString());
                          subscriptionModel.endDate = subscriptionModel.endDate
                              .add(Duration(days: -friday));
                          endDateController.text =
                              "${DateFormat('dd-MM-yyyy').format(subscriptionModel.endDate)}";
                        });
                      },
                    ),
                    InculdeFridayChooseButton(
                      isSelected: !isFriday,
                      text: c.lang == 'en' ? AppText.noEn : AppText.noAr,
                      onTap: () {
                        setState(() {
                          isFriday = false;
                          subscriptionModel.includeFriday = isFriday;
                          int friday = AppServices().countFridaysBetweenDates(
                              subscriptionModel.startDate,
                              subscriptionModel.endDate);

                          subscriptionModel.endDate = subscriptionModel.endDate
                              .add(Duration(days: friday));

                          endDateController.text =
                              "${DateFormat('dd-MM-yyyy').format(subscriptionModel.endDate)}";
                        });
                      },
                    ),
                  ],
                ),
                heightBox(20),
                Text(
                  c.lang == 'en' ? AppText.endDateEn : AppText.endDateAr,
                  style: TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                heightBox(10),
                CustomTextBox(
                  hintText: "Date",
                  controller: endDateController,
                  suffixIcon: Icon(
                    Icons.calendar_month_outlined,
                    color: AppColor.mediumGreyColor,
                  ),
                  readOnly: true,
                ),
                heightBox(20),
                Text(
                  c.lang == 'en' ? AppText.allergiesEn : AppText.allergiesAr,
                  style: TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                heightBox(10),
                MultiSelectorDropDown(
                  values: allergies,
                  onTap: (value, id) async {
                    String a = await c.translateTextInEn(value);
                    allergies.add(value);
                    setState(() {
                      subscriptionModel.allergies.add(a);
                      subscriptionModel.allergiesID.add(id);
                    });
                  },
                ),
                heightBox(20),
                Text(
                  c.lang == 'en' ? AppText.dislikesEn : AppText.dislikesAr,
                  style: TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                heightBox(10),
                MultiSelectorDropDown(
                  values: dislikes,
                  onTap: (value, id) async {
                    String a = await c.translateTextInEn(value);
                    dislikes.add(value);
                    setState(() {
                      subscriptionModel.dislikes.add(a);
                      subscriptionModel.dislikesID.add(id);
                    });
                  },
                ),
                heightBox(20),
                CustomButton(
                  text: c.lang == 'en' ? AppText.confirmEn : AppText.confirmAr,
                  width: width(context),
                  onTap: () {
                    Get.put(BottomBarBackend()).updateIndex(14);
                  },
                ),
                heightBox(120),
              ],
            ),
          ),
        );
      }),
    ));
  }
}

class InculdeFridayChooseButton extends StatelessWidget {
  final bool isSelected;
  final String text;
  final Function()? onTap;
  const InculdeFridayChooseButton({
    super.key,
    required this.isSelected,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width(context) * .42,
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
        decoration: ShapeDecoration(
          color: AppColor.inputBoxBGColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(
                width: 0.50,
                color: isSelected
                    ? AppColor.whiteColor
                    : AppColor.inputBoxBGColor),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: AppColor.whiteColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class SubcriptionTitleImageCard extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  const SubcriptionTitleImageCard(
      {super.key,
      required this.image,
      required this.title,
      required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width(context),
      padding: const EdgeInsets.all(12),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: AppColor.inputBoxBGColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: ShapeDecoration(
              image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.fill,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
          ),
          widthBox(12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: AppColor.whiteColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColor.lightGreyColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
