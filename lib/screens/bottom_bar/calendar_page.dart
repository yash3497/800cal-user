// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:eight_hundred_cal/backend/restaurant/restaurant_backend.dart';
import 'package:eight_hundred_cal/backend/subscription/subscription_backend.dart';
import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:flutter/material.dart';

import 'package:eight_hundred_cal/utils/colors.dart';
import 'package:eight_hundred_cal/utils/constants.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../model/calendar/calendar_model.dart';
import '../../utils/app_text.dart';
import '../../widgets/calendar_appbar.dart';
import '../../widgets/calendar_freeze_button.dart';
import '../../widgets/custom_calendar2.dart';
import '../../widgets/macros_widget.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  var c = Get.put(TranslatorBackend());
  String startDate = '';
  String endDate = '';
  int protien = 0;
  int calories = 0;
  int carbs = 0;
  int fat = 0;
  int protienT = 0;
  int caloriesT = 0;
  int carbsT = 0;
  int fatT = 0;

  CalendarModel model =
      Get.put(SubscriptionBackend()).calendarModel ?? dummyCalendarModel;

  _changeLanguage() async {
    startDate = await c.translateText(DateFormat('d MMM, y')
        .format(DateTime.fromMillisecondsSinceEpoch(model.startDate)));
    endDate = await c.translateText(DateFormat('d MMM, y')
        .format(DateTime.fromMillisecondsSinceEpoch(model.endDate)));
    setState(() {});
  }

  _calloriCalc() {
    protien = model.calendar
        .map(
          (e) => int.parse(e['protein']),
        )
        .fold(0, (previous, current) => previous + current);
    calories = model.calendar
        .map(
          (e) => int.parse(e['kcal']),
        )
        .fold(0, (previous, current) => previous + current);
    carbs = model.calendar
        .map(
          (e) => int.parse(e['carbs']),
        )
        .fold(0, (previous, current) => previous + current);
    fat = model.calendar
        .map(
          (e) => int.parse(e['fats']),
        )
        .fold(0, (previous, current) => previous + current);

    protienT = model.calendar
        .map(
          (e) => DateTime.fromMillisecondsSinceEpoch(e['date'])
                  .isBefore(DateTime.now())
              ? int.parse(e['protein'])
              : 0,
        )
        .fold(0, (previous, current) => previous + current);
    caloriesT = model.calendar
        .map(
          (e) => DateTime.fromMillisecondsSinceEpoch(e['date'])
                  .isBefore(DateTime.now())
              ? int.parse(e['kcal'])
              : 0,
        )
        .fold(0, (previous, current) => previous + current);
    carbsT = model.calendar
        .map(
          (e) => DateTime.fromMillisecondsSinceEpoch(e['date'])
                  .isBefore(DateTime.now())
              ? int.parse(e['carbs'])
              : 0,
        )
        .fold(0, (previous, current) => previous + current);
    fatT = model.calendar
        .map(
          (e) => DateTime.fromMillisecondsSinceEpoch(e['date'])
                  .isBefore(DateTime.now())
              ? int.parse(e['fats'])
              : 0,
        )
        .fold(0, (previous, current) => previous + current);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _changeLanguage();
    _calloriCalc();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColor.pimaryColor,
      body: GetBuilder<SubscriptionBackend>(builder: (controller) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding, vertical: 20),
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
                CustomCalendar2(
                  isShowIcon: true,
                ),
                heightBox(20),
                CalendarSubscriptionDetailsWidget(
                  calendar: model.calendar,
                ),
                heightBox(20),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    c.lang == 'en'
                        ? AppText.totalMacroConsumptionTillDateEn
                        : AppText.totalMacroConsumptionTillDateAr,
                    style: TextStyle(
                      color: AppColor.whiteColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                heightBox(20),
                MacrosWidget(
                  protiens:
                      '${protienT}${c.lang == 'en' ? AppText.gEn : AppText.gAr}',
                  calories:
                      '${caloriesT}${c.lang == 'en' ? AppText.kcalEn : AppText.kcalAr}',
                  carbs:
                      '${carbsT}${c.lang == 'en' ? AppText.gEn : AppText.gAr}',
                  fat: '${fatT}${c.lang == 'en' ? AppText.gEn : AppText.gAr}',
                ),
                heightBox(20),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    c.lang == 'en'
                        ? AppText.totalMacroConsumptionduringSubEn
                        : AppText.totalMacroConsumptionduringSubAr,
                    style: TextStyle(
                      color: AppColor.whiteColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                heightBox(20),
                MacrosWidget(
                  protiens:
                      '${protien}${c.lang == 'en' ? AppText.gEn : AppText.gAr}',
                  calories:
                      '${calories}${c.lang == 'en' ? AppText.kcalEn : AppText.kcalAr}',
                  carbs:
                      '${carbs}${c.lang == 'en' ? AppText.gEn : AppText.gAr}',
                  fat: '${fat}${c.lang == 'en' ? AppText.gEn : AppText.gAr}',
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

class CalendarSubscriptionDetailsWidget extends StatefulWidget {
  final List calendar;
  const CalendarSubscriptionDetailsWidget({
    super.key,
    required this.calendar,
  });

  @override
  State<CalendarSubscriptionDetailsWidget> createState() =>
      _CalendarSubscriptionDetailsWidgetState();
}

class _CalendarSubscriptionDetailsWidgetState
    extends State<CalendarSubscriptionDetailsWidget> {
  var c = Get.put(TranslatorBackend());
  int pending = 0;
  int frozen = 0;

  _check() {
    widget.calendar.forEach((element) {
      if (element['freezed']) {
        frozen++;
      }
      if (DateTime.fromMillisecondsSinceEpoch(element['date'])
          .isAfter(DateTime.now())) {
        pending++;
      }
    });
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _check();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text:
                        '${c.lang == 'en' ? AppText.pendingEn : AppText.pendingAr}: ',
                    style: TextStyle(
                      color: AppColor.whiteColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text:
                        '$pending ${c.lang == 'en' ? AppText.daysEn : AppText.daysAr}',
                    style: TextStyle(
                      color: AppColor.secondaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            widthBox(10),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text:
                        '${c.lang == 'en' ? AppText.deliveredEn : AppText.deliveredAr}: ',
                    style: TextStyle(
                      color: AppColor.whiteColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text:
                        '${widget.calendar.length - pending - frozen} ${c.lang == 'en' ? AppText.daysEn : AppText.daysAr}',
                    style: TextStyle(
                      color: AppColor.reviewCardTextColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        heightBox(4),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text:
                    '${c.lang == 'en' ? AppText.frozenEn : AppText.frozenAr}: ',
                style: TextStyle(
                  color: AppColor.whiteColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(
                text:
                    '$frozen ${c.lang == 'en' ? AppText.daysEn : AppText.daysAr}',
                style: TextStyle(
                  color: AppColor.blueColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
