import 'dart:developer';

import 'package:eight_hundred_cal/backend/subscription/subscription_backend.dart';
import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:eight_hundred_cal/model/calendar/calendar_model.dart';
import 'package:eight_hundred_cal/screens/subscription/choose_your_meals_page.dart';
import 'package:eight_hundred_cal/services/app_services.dart';
import 'package:eight_hundred_cal/widgets/calendar_date_details_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../backend/bottom_bar/bottom_bar_backend.dart';
import '../utils/app_text.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';

class CustomCalendar2 extends StatelessWidget {
  bool isShowIcon;
  CustomCalendar2({
    super.key,
    this.isShowIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    var c = Get.put(TranslatorBackend());
    return GetBuilder<SubscriptionBackend>(builder: (controller) {
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
      return CalendarCarousel(
        height: height(context) * .72,
        width: width(context),
        locale: c.lang,
        todayButtonColor: Colors.transparent,
        customGridViewPhysics: NeverScrollableScrollPhysics(),
        headerTextStyle: TextStyle(
          fontSize: 22,
          color: AppColor.whiteColor,
          fontWeight: FontWeight.w600,
        ),
        headerMargin: EdgeInsets.symmetric(horizontal: 30),
        leftButtonIcon: Icon(
          Icons.arrow_back_ios,
          color: AppColor.whiteColor,
          size: 18,
        ),
        rightButtonIcon: Icon(
          Icons.arrow_forward_ios,
          color: AppColor.whiteColor,
          size: 18,
        ),
        childAspectRatio: .52,
        customWeekDayBuilder: (weekday, weekdayName) {
          return Container(
            width: width(context) * .115,
            padding: const EdgeInsets.all(10),
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: AppColor.inputBoxBGColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
            ),
            child: Center(
              child: Text(
                '$weekdayName',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColor.whiteColor,
                  fontSize: 8,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        },
        customDayBuilder: (isSelectable, index, isSelectedDay, isToday,
            isPrevMonthDay, textStyle, isNextMonthDay, isThisMonthDay, day) {
          DateFormat format = DateFormat('dd/MM/yyyy');
          List data = model.calendar
              .where((element) =>
                  format
                      .format(
                          DateTime.fromMillisecondsSinceEpoch(element['date']))
                      .toString() ==
                  format.format(day))
              .toList();
          bool isPicked = data.isEmpty;
          bool inBetween = AppServices().isDateInBetween(
              DateTime.fromMillisecondsSinceEpoch(model.startDate),
              DateTime.fromMillisecondsSinceEpoch(model.endDate),
              day,
              model.includeFridays);
          return Padding(
            padding: const EdgeInsets.only(top: 10),
            child: InkWell(
              onTap: () {
                if (isPicked && inBetween) {
                  Get.put(BottomBarBackend()).updateIndex(25);
                  mealDate = day;
                } else if (inBetween) {
                  showCalendarDateDetailsPopup(context, data[0]);
                }
              },
              child: Container(
                // width: 50,
                decoration: ShapeDecoration(
                  color: AppColor.calendarbgColor,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        width: 0.50,
                        color: !AppServices().isDateInBetween(
                                DateTime.fromMillisecondsSinceEpoch(
                                    model.startDate),
                                DateTime.fromMillisecondsSinceEpoch(
                                    model.endDate),
                                day,
                                model.includeFridays)
                            ? AppColor.reviewCardTextColor
                            : isPicked
                                ? AppColor.yellowColor
                                : data.isNotEmpty && data[0]['freezed']
                                    ? AppColor.blueColor
                                    : isToday && isShowIcon
                                        ? AppColor.redColor
                                        : AppColor.secondaryColor),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 3),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: isShowIcon
                            ? MainAxisAlignment.spaceBetween
                            : MainAxisAlignment.center,
                        children: [
                          Text(
                            '${DateFormat('dd').format(day)}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColor.whiteColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          isShowIcon
                              ? !AppServices().isDateInBetween(
                                      DateTime.fromMillisecondsSinceEpoch(
                                          model.startDate),
                                      DateTime.fromMillisecondsSinceEpoch(
                                          model.endDate),
                                      day,
                                      model.includeFridays)
                                  ? Image.asset(
                                      "assets/icons/truck.png",
                                      width: 8,
                                      height: 8,
                                    )
                                  : data.isNotEmpty && data[0]['freezed']
                                      ? Image.asset(
                                          "assets/icons/pause.png",
                                          width: 8,
                                          height: 8,
                                        )
                                      : isToday
                                          ? Image.asset(
                                              "assets/icons/cook.png",
                                              width: 8,
                                              height: 8,
                                            )
                                          : Image.asset(
                                              "assets/icons/yellow_star.png",
                                              width: 8,
                                              height: 8,
                                            )
                              : SizedBox(),
                        ],
                      ),
                      !isPicked || !inBetween
                          ? Image.network(
                              !AppServices().isDateInBetween(
                                      DateTime.fromMillisecondsSinceEpoch(
                                          model.startDate),
                                      DateTime.fromMillisecondsSinceEpoch(
                                          model.endDate),
                                      day,
                                      model.includeFridays)
                                  ? "https://i.postimg.cc/wvpTZgvR/star-buks2.png"
                                  : data[0]['restaurant'] != null
                                      ? data[0]['restaurant']['logo']
                                      : "https://i.postimg.cc/wvpTZgvR/star-buks2.png",
                              width: c.lang == 'en' ? 36 : 26,
                              height: c.lang == 'en' ? 36 : 26,
                              color: !inBetween
                                  ? AppColor.reviewCardTextColor
                                  : data[0]['freezed']
                                      ? AppColor.blueColor
                                      : AppColor.secondaryColor,
                            )
                          : SizedBox(),
                      heightBox(c.lang == 'en' ? 5 : 2),
                      !isPicked || !inBetween
                          ? Text(
                              '${inBetween ? data[0]['kcal'] : 0}${c.lang == 'en' ? AppText.kcalEn : AppText.kcalAr}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: !AppServices().isDateInBetween(
                                        DateTime.fromMillisecondsSinceEpoch(
                                            model.startDate),
                                        DateTime.fromMillisecondsSinceEpoch(
                                            model.endDate),
                                        day,
                                        model.includeFridays)
                                    ? AppColor.reviewCardTextColor
                                    : data.isNotEmpty && data[0]['freezed']
                                        ? AppColor.blueColor
                                        : isToday && isShowIcon
                                            ? AppColor.whiteColor
                                            : AppColor.secondaryColor,
                                fontSize: 7.5,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Text(
                                c.lang == 'en'
                                    ? AppText.pickEn
                                    : AppText.pickAr,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColor.yellowColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
