import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:eight_hundred_cal/widgets/calendar_date_details_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../backend/bottom_bar/bottom_bar_backend.dart';
import '../utils/app_text.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';

class CustomCalendar extends StatelessWidget {
  bool isShowIcon;
  CustomCalendar({
    super.key,
    this.isShowIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    var c = Get.put(TranslatorBackend());
    return CalendarCarousel(
      height: height(context) * .715,
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
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
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
        return Padding(
          padding: const EdgeInsets.only(top: 10),
          child: InkWell(
            onTap: () {
              if (isToday) {
                Get.put(BottomBarBackend()).updateIndex(17);
              } else {
                showCalendarDateDetailsPopup(context, {});
              }
            },
            child: Container(
              // width: 50,
              decoration: ShapeDecoration(
                color: AppColor.calendarbgColor,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      width: 0.50,
                      color: isPrevMonthDay || isNextMonthDay
                          ? AppColor.reviewCardTextColor
                          : isToday
                              ? AppColor.yellowColor
                              : AppColor.secondaryColor),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 3),
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
                            ? isPrevMonthDay || isNextMonthDay
                                ? Image.asset(
                                    "assets/icons/truck.png",
                                    width: 8,
                                    height: 8,
                                  )
                                : !isToday
                                    ? Image.asset(
                                        "assets/icons/yellow_star.png",
                                        width: 8,
                                        height: 8,
                                      )
                                    : SizedBox()
                            : SizedBox(),
                      ],
                    ),
                    !isToday
                        ? Image.asset(
                            isPrevMonthDay || isNextMonthDay
                                ? "assets/icons/star_buks2.png"
                                : "assets/icons/star_bucks.png",
                            width: 36,
                            height: 36,
                            fit: BoxFit.cover,
                          )
                        : SizedBox(),
                    heightBox(c.lang == 'en' ? 5 : 2),
                    !isToday
                        ? Text(
                            '100${c.lang == 'en' ? AppText.kcalEn : AppText.kcalAr}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: isPrevMonthDay || isNextMonthDay
                                  ? AppColor.reviewCardTextColor
                                  : AppColor.secondaryColor,
                              fontSize: 7.5,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Text(
                              c.lang == 'en' ? AppText.pickEn : AppText.pickAr,
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
  }
}
