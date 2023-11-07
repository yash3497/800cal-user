import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:eight_hundred_cal/services/app_services.dart';
import 'package:eight_hundred_cal/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../utils/constants.dart';

class SubscribedHomeDateWidget extends StatelessWidget {
  final List calendar;
  const SubscribedHomeDateWidget({
    super.key,
    required this.calendar,
  });

  @override
  Widget build(BuildContext context) {
    calendar.sort((a, b) => a['date'].compareTo(b['date']));
    return SizedBox(
      height: 20,
      child: ListView.separated(
        itemCount: calendar.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return SubscribedHomeDateCardWidget(calendar: calendar[index]);
        },
        separatorBuilder: (context, index) {
          return widthBox(10);
        },
      ),
    );
  }
}

class SubscribedHomeDateCardWidget extends StatefulWidget {
  const SubscribedHomeDateCardWidget({
    super.key,
    required this.calendar,
  });

  final Map calendar;

  @override
  State<SubscribedHomeDateCardWidget> createState() =>
      _SubscribedHomeDateCardWidgetState();
}

class _SubscribedHomeDateCardWidgetState
    extends State<SubscribedHomeDateCardWidget> {
  String date = '';
  var c = Get.put(TranslatorBackend());

  _changeLanguage() async {
    date = await c.translateText(DateFormat('dd MMM')
        .format(DateTime.fromMillisecondsSinceEpoch(widget.calendar['date'])));
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
      '$date',
      style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: widget.calendar['freezed']
              ? AppColor.blueColor
              : DateTime.now().isBefore(DateTime.fromMillisecondsSinceEpoch(
                      widget.calendar['date']))
                  ? AppServices().calculateDaysDifference(
                              DateTime.now(),
                              DateTime.fromMillisecondsSinceEpoch(
                                  widget.calendar['date'])) >
                          2
                      ? AppColor.secondaryColor
                      : AppColor.yellowColor
                  : DateTime.now().isAfter(DateTime.fromMillisecondsSinceEpoch(
                          widget.calendar['date']))
                      ? AppColor.reviewCardTextColor
                      : AppColor.secondaryColor),
    );
  }
}
