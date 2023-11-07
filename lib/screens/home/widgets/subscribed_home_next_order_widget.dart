import 'package:eight_hundred_cal/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../backend/translator/translator_backend.dart';
import '../../../utils/app_text.dart';
import '../../../utils/colors.dart';

class SubscribedHomeNextOrderWidget extends StatefulWidget {
  final Map data;
  const SubscribedHomeNextOrderWidget({
    super.key,
    required this.data,
  });

  @override
  State<SubscribedHomeNextOrderWidget> createState() =>
      _SubscribedHomeNextOrderWidgetState();
}

class _SubscribedHomeNextOrderWidgetState
    extends State<SubscribedHomeNextOrderWidget> {
  var c = Get.put(TranslatorBackend());
  String name = '';
  String date = '';

  _changeLang() async {
    name = await c.translateText(widget.data['restaurant']['title']);
    date = await c
        .translateText(DateFormat('EEEE, d MMMM').format(DateTime.now()));
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _changeLang();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColor.inputBoxBGColor,
      ),
      padding: EdgeInsets.symmetric(horizontal: 19, vertical: 10),
      child: Row(
        children: [
          Image.network(
            widget.data['restaurant']['logo'],
            width: 65,
            height: 65,
          ),
          widthBox(20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                c.lang == 'en'
                    ? AppText.nextOrderComingFromEn
                    : AppText.nextOrderComingFromAr,
                style: TextStyle(
                  color: AppColor.whiteColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '$name',
                style: TextStyle(
                  color: AppColor.secondaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '$date',
                style: TextStyle(
                  color: AppColor.reviewCardTextColor,
                  fontSize: 12,
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
