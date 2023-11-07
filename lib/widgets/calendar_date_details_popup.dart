// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:eight_hundred_cal/backend/food/food_backend.dart';
import 'package:eight_hundred_cal/backend/restaurant/restaurant_backend.dart';
import 'package:eight_hundred_cal/backend/subscription/subscription_backend.dart';
import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:eight_hundred_cal/model/food/food_model.dart';
import 'package:eight_hundred_cal/screens/home/restaurant_detail_page.dart';
import 'package:eight_hundred_cal/screens/subscription/choose_your_meals_page.dart';
import 'package:eight_hundred_cal/utils/app_text.dart';
import 'package:eight_hundred_cal/utils/colors.dart';
import 'package:eight_hundred_cal/utils/constants.dart';
import 'package:eight_hundred_cal/widgets/custom_button.dart';
import 'package:eight_hundred_cal/widgets/macros_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../backend/bottom_bar/bottom_bar_backend.dart';
import 'macros_data_widget.dart';

void showCalendarDateDetailsPopup(BuildContext context, Map data) {
  var c = Get.put(TranslatorBackend());
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        insetPadding: EdgeInsets.all(10),
        backgroundColor: AppColor.inputBoxBGColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: SizedBox(
          height: height(context) * .75,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            child: Column(
              children: [
                CalendarDateDetailPopupRestaLogoWidget(
                  data: data,
                ),
                heightBox(10),
                CalendarDateDetailPopupDateSelectorWidget(
                  data: data,
                ),
                heightBox(20),
                ListView.separated(
                  itemCount: data['food'].length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return CalendarDateDetailPopupFoodItemCard(
                      data: data,
                      foodId: data['food'][index],
                      index: index,
                    );
                  },
                  separatorBuilder: (context, index) => heightBox(20),
                ),
                heightBox(10),
                MacrosWidget(
                  protiens: "${data['protein']}g",
                  calories: "${data['kcal']}",
                  carbs: "${data['carbs']}g",
                  fat: "${data['fats']}g",
                ),
                heightBox(30),
                CustomButton(
                  text: c.lang == 'en' ? AppText.okEn : AppText.okAr,
                  onTap: () {
                    Get.back();
                  },
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

class CalendarDateDetailPopupFoodItemCard extends StatefulWidget {
  final Map data;
  final String foodId;
  final int index;
  const CalendarDateDetailPopupFoodItemCard(
      {super.key,
      required this.data,
      required this.foodId,
      required this.index});

  @override
  State<CalendarDateDetailPopupFoodItemCard> createState() =>
      _CalendarDateDetailPopupFoodItemCardState();
}

class _CalendarDateDetailPopupFoodItemCardState
    extends State<CalendarDateDetailPopupFoodItemCard> {
  var c = Get.put(TranslatorBackend());
  FoodModel model = dummyFoodModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.put(FoodBackend()).fetchFoodById(widget.foodId).then((value) {
      setState(() {
        model = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              model.image != '' && model.image != null
                  ? model.image
                  : 'https://plus.unsplash.com/premium_photo-1663858367001-89e5c92d1e0e?auto=format&fit=crop&q=60&w=800&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Zm9vZHxlbnwwfHwwfHx8MA%3D%3D',
              width: 64,
              height: 64,
              fit: BoxFit.cover,
            ),
          ),
          widthBox(10),
          Column(
            children: [
              Text(
                '${model.name}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColor.whiteColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              heightBox(5),
              Text(
                '${model.calories}, ${model.protien} ${c.lang == 'en' ? AppText.profileEn : AppText.protiensAr}, ${model.carbs} ${c.lang == 'en' ? AppText.carbsEn : AppText.carbsAr}, ${model.fat} ${c.lang == 'en' ? AppText.fatEn : AppText.fatAr}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColor.reviewCardTextColor,
                  fontSize: 8,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Spacer(),
          InkWell(
            onTap: () {
              Get.back();
              Get.put(BottomBarBackend()).updateIndex(17);
              restaurantId = widget.data['restaurant']['_id'];
              var controller = Get.put(RestaurantBackend());
              controller.edit = true;
              mealDate =
                  DateTime.fromMillisecondsSinceEpoch(widget.data['date']);
            },
            child: Container(
              width: 23,
              height: 23,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.pimaryColor,
              ),
              child: Center(
                child: Icon(
                  Icons.edit_outlined,
                  color: AppColor.secondaryColor,
                  size: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CalendarDateDetailPopupDateSelectorWidget extends StatefulWidget {
  final Map data;
  const CalendarDateDetailPopupDateSelectorWidget({
    super.key,
    required this.data,
  });

  @override
  State<CalendarDateDetailPopupDateSelectorWidget> createState() =>
      _CalendarDateDetailPopupDateSelectorWidgetState();
}

class _CalendarDateDetailPopupDateSelectorWidgetState
    extends State<CalendarDateDetailPopupDateSelectorWidget> {
  var c = Get.put(TranslatorBackend());
  String date = '';

  _changeLanguage() async {
    date = await c.translateText(
        '${DateFormat('d MMM, yyyy').format(DateTime.fromMillisecondsSinceEpoch(widget.data['date']))}');
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon(
          //   Icons.arrow_back_ios,
          //   size: 16,
          //   color: AppColor.whiteColor,
          // ),
          Text(
            date,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColor.whiteColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          // Icon(
          //   Icons.arrow_forward_ios,
          //   size: 16,
          //   color: AppColor.whiteColor,
          // ),
        ],
      ),
    );
  }
}

class CalendarDateDetailPopupRestaLogoWidget extends StatelessWidget {
  final Map data;
  const CalendarDateDetailPopupRestaLogoWidget({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    var c = Get.put(TranslatorBackend());
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Image.network(
            data['restaurant'] != null
                ? data['restaurant']['logo']
                : "https://i.postimg.cc/wvpTZgvR/star-buks2.png",
            width: 90,
            height: 90,
          ),
        ),
        Positioned(
          bottom: 20,
          left: 190,
          child: InkWell(
            onTap: () {
              Get.back();
              var controller = Get.put(RestaurantBackend());
              controller.edit = true;
              mealDate = DateTime.fromMillisecondsSinceEpoch(data['date']);
              Get.put(BottomBarBackend()).updateIndex(25);
            },
            child: Container(
              width: 23,
              height: 23,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.pimaryColor,
              ),
              child: Center(
                child: Icon(
                  Icons.edit_outlined,
                  color: AppColor.secondaryColor,
                  size: 14,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          right: 0,
          top: 10,
          child: InkWell(
            onTap: () {
              Get.put(SubscriptionBackend())
                  .freezeDate(!data['freezed'], data['order'], data['_id']);
              Get.back();
            },
            child: Row(
              children: [
                Icon(
                  data['freezed'] ? Icons.play_arrow : Icons.pause,
                  color: AppColor.blueColor,
                  size: 8,
                ),
                widthBox(10),
                Text(
                  c.lang == 'en' ? AppText.freezeEn : AppText.freezeAr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
