import 'package:eight_hundred_cal/backend/subscription/subscription_backend.dart';
import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:eight_hundred_cal/utils/app_text.dart';
import 'package:eight_hundred_cal/widgets/custom_button.dart';
import 'package:eight_hundred_cal/widgets/custom_date_calendar_picker.dart';
import 'package:eight_hundred_cal/widgets/text_box_with_heading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../utils/colors.dart';
import '../../../utils/constants.dart';

void showFreezeOfTheDayPopup(BuildContext context) {
  var c = Get.put(TranslatorBackend());
  var calen = Get.put(SubscriptionBackend());
  var controller = TextEditingController(
      text: DateFormat('dd/MM/yyyy').format(DateTime.now()));
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        insetPadding: EdgeInsets.symmetric(horizontal: 10),
        backgroundColor: AppColor.inputBoxBGColor,
        child: SizedBox(
          width: width(context),
          height: height(context) * .4,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    c.lang == 'en'
                        ? AppText.freezeTheDayEn
                        : AppText.freezeTheDayAr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColor.whiteColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                heightBox(20),
                Text(
                  "${c.lang == 'en' ? AppText.chooseTheDateEn : AppText.chooseTheDateAr}:",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                heightBox(10),
                Container(
                  width: width(context),
                  height: 70,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColor.whiteColor, width: 0.5),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: TextFormField(
                        controller: controller,
                        readOnly: true,
                        onTap: () async {
                          DateTime value = await customDatePicker(
                              context,
                              DateTime.fromMillisecondsSinceEpoch(
                                  calen.calendarModel!.startDate),
                              DateTime.fromMillisecondsSinceEpoch(
                                  calen.calendarModel!.endDate));
                          if (value != null) {
                            controller.text =
                                DateFormat('dd/MM/yyyy').format(value);
                          }
                        },
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColor.whiteColor,
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
                heightBox(20),
                Center(
                    child: CustomButton(
                        onTap: () {
                          List dataList = calen.calendarModel!.calendar
                              .where((element) =>
                                  DateFormat('dd/MM/yyyy')
                                      .format(
                                          DateTime.fromMillisecondsSinceEpoch(
                                              element['date']))
                                      .toString() ==
                                  controller.text)
                              .toList();
                          if (dataList.isNotEmpty) {
                            calen.freezeDate(!dataList[0]['freezed'],
                                dataList[0]['order'], dataList[0]['_id']);
                          }
                          Get.back();
                        },
                        text: c.lang == 'en'
                            ? AppText.freezeEn
                            : AppText.freezeAr)),
              ],
            ),
          ),
        ),
      );
    },
  );
}
