// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:eight_hundred_cal/backend/bottom_bar/bottom_bar_backend.dart';
import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:eight_hundred_cal/utils/app_text.dart';
import 'package:eight_hundred_cal/utils/colors.dart';
import 'package:eight_hundred_cal/utils/constants.dart';
import 'package:eight_hundred_cal/widgets/custom_button.dart';
import 'package:eight_hundred_cal/widgets/macros_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../backend/subscription/subscription_backend.dart';
import '../../model/calendar/calendar_model.dart';
import '../../model/pie_chart/char_data_model.dart';
import '../../widgets/calendar_freeze_button.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({super.key});

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  var c = Get.put(TranslatorBackend());
  CalendarModel model =
      Get.put(SubscriptionBackend()).calendarModel ?? dummyCalendarModel;

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
                SubscriptionPageAppBar(),
                heightBox(20),
                SubscriptionPageDateWidget(),
                heightBox(20),
                CustomDonutChart(),
                heightBox(100),
                SubscriptionColorMeansWidget(),
                heightBox(20),
                Center(
                  child: Text(
                    '${controller.pending} ${c.lang == 'en' ? AppText.daysPendingOutOfEn : AppText.daysPendingOutOfAr} ${model.duration}',
                    style: TextStyle(
                      color: AppColor.whiteColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                heightBox(20),
                Center(
                    child: CustomButton(
                        onTap: () {
                          Get.put(BottomBarBackend()).updateIndex(3);
                        },
                        text: c.lang == 'en'
                            ? AppText.viewCalendarEn
                            : AppText.viewCalendarAr)),
                heightBox(20),
                Text(
                  c.lang == 'en'
                      ? AppText.macroConsumptionTillDateEn
                      : AppText.macroConsumptionTillDateAr,
                  style: TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                heightBox(20),
                MacrosWidget(
                  protiens:
                      '${controller.protienT}${c.lang == 'en' ? AppText.gEn : AppText.gAr}',
                  calories:
                      '${controller.caloriesT}${c.lang == 'en' ? AppText.kcalEn : AppText.kcalAr}',
                  carbs:
                      '${controller.carbsT}${c.lang == 'en' ? AppText.gEn : AppText.gAr}',
                  fat:
                      '${controller.fatT}${c.lang == 'en' ? AppText.gEn : AppText.gAr}',
                ),
                heightBox(20),
                Text(
                  c.lang == 'en'
                      ? AppText.macroConsumptionduringSubEn
                      : AppText.macroConsumptionduringSubAr,
                  style: TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                heightBox(20),
                MacrosWidget(
                  protiens:
                      '${controller.protien}${c.lang == 'en' ? AppText.gEn : AppText.gAr}',
                  calories:
                      '${controller.calorie}${c.lang == 'en' ? AppText.kcalEn : AppText.kcalAr}',
                  carbs:
                      '${controller.carbs}${c.lang == 'en' ? AppText.gEn : AppText.gAr}',
                  fat:
                      '${controller.fat}${c.lang == 'en' ? AppText.gEn : AppText.gAr}',
                ),
                heightBox(20),
                Center(
                    child: CustomButton(
                        onTap: () {
                          Get.put(BottomBarBackend()).updateIndex(20);
                        },
                        text: c.lang == 'en'
                            ? AppText.cancelSubscriptionEn
                            : AppText.cancelSubscriptionAr)),
                heightBox(120),
              ],
            ),
          ),
        );
      }),
    ));
  }
}

class SubscriptionColorMeansWidget extends StatelessWidget {
  const SubscriptionColorMeansWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var c = Get.put(TranslatorBackend());
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: AppColor.yellowColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                widthBox(10),
                Text(
                  c.lang == 'en' ? AppText.pendingEn : AppText.pendingAr,
                  style: TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: AppColor.secondaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                widthBox(10),
                Text(
                  c.lang == 'en' ? AppText.swappableEn : AppText.swappableAr,
                  style: TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: AppColor.blueColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                widthBox(10),
                Text(
                  c.lang == 'en' ? AppText.freezedEn : AppText.freezedAr,
                  style: TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
        heightBox(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 30,
              height: 30,
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: AppColor.reviewCardTextColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
            widthBox(10),
            Text(
              c.lang == 'en' ? AppText.deliveredEn : AppText.deliveredAr,
              style: TextStyle(
                color: AppColor.whiteColor,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class SubscriptionPageDateWidget extends StatefulWidget {
  const SubscriptionPageDateWidget({
    super.key,
  });

  @override
  State<SubscriptionPageDateWidget> createState() =>
      _SubscriptionPageDateWidgetState();
}

class _SubscriptionPageDateWidgetState
    extends State<SubscriptionPageDateWidget> {
  var c = Get.put(TranslatorBackend());
  String startDate = '';
  String endDate = '';
  CalendarModel model =
      Get.put(SubscriptionBackend()).calendarModel ?? dummyCalendarModel;
  _changeLanguage() async {
    startDate = await c.translateText(DateFormat('d MMM, y')
        .format(DateTime.fromMillisecondsSinceEpoch(model.startDate)));
    endDate = await c.translateText(DateFormat('d MMM, y')
        .format(DateTime.fromMillisecondsSinceEpoch(model.endDate)));
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
    return Text(
      '$startDate - $endDate',
      style: TextStyle(
        color: AppColor.whiteColor,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class SubscriptionPageAppBar extends StatelessWidget {
  const SubscriptionPageAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var c = Get.put(TranslatorBackend());
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          c.lang == 'en' ? AppText.subscriptionEn : AppText.subscriptionAr,
          style: TextStyle(
            color: AppColor.whiteColor,
            fontSize: 32,
            fontWeight: FontWeight.w600,
          ),
        ),
        CalendarConfirmButton(),
      ],
    );
  }
}

class CustomDonutChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200, // Adjust the size as needed
        height: 200,
        child: CustomPaint(
          painter: DonutChartPainter(),
        ),
      ),
    );
  }
}

class DonutChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 1.5;
    final holeRadius = size.width / 4; // Adjust the hole size as needed

    var gapAngle = 0.12; // Adjust the gap size between segments

    double startAngle = -pi / 2;

    for (var segment in segments) {
      final sweepAngle = (segment.percent / 100) * 2 * pi;

      if (sweepAngle <= gapAngle) {
        startAngle += sweepAngle; // Skip very small segments
        continue;
      }

      final endAngle = startAngle + sweepAngle;

      final path = Path()
        ..moveTo(centerX, centerY)
        ..arcTo(
          Rect.fromCircle(
              center: Offset(centerX, centerY), radius: size.width / 1.5),
          startAngle,
          sweepAngle - gapAngle,
          false,
        )
        ..arcTo(
          Rect.fromCircle(
              center: Offset(centerX, centerY),
              radius: size.width / 2 -
                  30), // Adjust the space between segments here
          endAngle - gapAngle, // Adjust to leave a gap
          -(sweepAngle - gapAngle),
          false,
        )
        ..close();

      final paint = Paint()
        ..color = segment.color
        ..style = PaintingStyle.fill;

      canvas.drawPath(path, paint);

      startAngle = endAngle;
    }

    final holePaint = Paint()
      ..color = AppColor.pimaryColor // Color for the center hole
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(centerX, centerY), holeRadius, holePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
