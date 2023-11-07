import 'dart:developer';

import 'package:eight_hundred_cal/backend/order/order_backend.dart';
import 'package:eight_hundred_cal/backend/profile/profile_backend.dart';
import 'package:eight_hundred_cal/backend/subscription/subscription_backend.dart';
import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:eight_hundred_cal/model/profile/profile_model.dart';
import 'package:eight_hundred_cal/services/app_services.dart';
import 'package:eight_hundred_cal/utils/colors.dart';
import 'package:eight_hundred_cal/utils/constants.dart';
import 'package:eight_hundred_cal/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../model/calendar/calendar_model.dart';
import '../../utils/app_text.dart';
import '../../widgets/calendar_appbar.dart';
import '../../widgets/calendar_freeze_button.dart';
import '../../widgets/custom_calendar2.dart';
import '../../widgets/custom_calendar_widget.dart';
import '../../widgets/macros_widget.dart';
import '../home/dish_info_page.dart';

class CalendarConfirmPage extends StatefulWidget {
  const CalendarConfirmPage({super.key});

  @override
  State<CalendarConfirmPage> createState() => _CalendarConfirmPageState();
}

class _CalendarConfirmPageState extends State<CalendarConfirmPage> {
  var c = Get.put(TranslatorBackend());
  var sub = Get.put(SubscriptionBackend());
  String startDate = '';
  String endDate = '';

  _changeLanguage() async {
    startDate = await c.translateText(
        DateFormat('d MMM, y').format(subscriptionModel.startDate));
    endDate = await c.translateText(
        DateFormat('d MMM, y').format(subscriptionModel.endDate));
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _changeLanguage();
    sub.fetchCalendarData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColor.pimaryColor,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 105),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
              height: 60,
              width: 160,
              child: CustomButton(
                  onTap: () {
                    var difference = AppServices().calculateDaysDifference(
                        subscriptionModel.startDate, subscriptionModel.endDate);
                    if (sub.calendarModel!.calendar.length >= difference) {
                      var controller = Get.put(ProfileBackend());
                      ProfileModel model = controller.model!;
                      model.isSubscribed = true;
                      model.subscriptionStartDate =
                          subscriptionModel.startDate.millisecondsSinceEpoch;
                      model.subscriptionEndDate =
                          subscriptionModel.endDate.millisecondsSinceEpoch;
                      model.subscriptionId = Get.put(OrderBackend()).orderId;
                      controller.updateSubscriptionProfile(model);
                    } else {
                      log("Difference: $difference");
                      Fluttertoast.showToast(msg: 'Please pick your food');
                    }
                  },
                  text:
                      c.lang == 'en' ? AppText.confirmEn : AppText.confirmAr)),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 20),
          child: Column(
            children: [
              CalendarConfirmAppBar(),
              heightBox(20),
              CalendarConfirmButton(),
              heightBox(20),
              Text(
                '$startDate - $endDate',
                style: TextStyle(
                  color: AppColor.whiteColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              heightBox(20),
              CustomCalendar2(),
              heightBox(20),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  c.lang == 'en'
                      ? AppText.macroConsumptionduringSubEn
                      : AppText.macroConsumptionduringSubAr,
                  style: TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              heightBox(20),
              GetBuilder<SubscriptionBackend>(builder: (controller) {
                CalendarModel model = controller.calendarModel ??
                    CalendarModel(
                        id: "",
                        timestamp: 0,
                        customer: {},
                        startDate: 0,
                        endDate: 0,
                        duration: 0,
                        includeFridays: true,
                        discount: "",
                        subtotal: 0,
                        shippingCost: 0,
                        total: 0,
                        restaurantCategory: {},
                        email: "",
                        phone: "",
                        name: "",
                        address: "",
                        paymentStatus: "",
                        orderStatus: "",
                        program: {},
                        meals: {},
                        v: 0,
                        calendar: []);
                int protien = model.calendar
                    .map(
                      (e) => int.parse(e['protein']),
                    )
                    .fold(0, (previous, current) => previous + current);
                int calories = model.calendar
                    .map(
                      (e) => int.parse(e['kcal']),
                    )
                    .fold(0, (previous, current) => previous + current);
                int carbs = model.calendar
                    .map(
                      (e) => int.parse(e['carbs']),
                    )
                    .fold(0, (previous, current) => previous + current);
                int fat = model.calendar
                    .map(
                      (e) => int.parse(e['fats']),
                    )
                    .fold(0, (previous, current) => previous + current);
                return MacrosWidget(
                  protiens: '${protien}g',
                  calories: '${calories}kcal',
                  carbs: '${carbs}g',
                  fat: '${fat}g',
                );
              }),
              heightBox(180),
            ],
          ),
        ),
      ),
    ));
  }
}
