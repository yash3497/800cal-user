import 'package:eight_hundred_cal/utils/colors.dart';
import 'package:flutter/material.dart';

Future<DateTime> customDatePicker(
    BuildContext context, DateTime startDate, DateTime endDate) async {
  DateTime date = DateTime.now();
  await showDatePicker(
          context: context,
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary: AppColor.secondaryColor,
                  onPrimary: AppColor.whiteColor,
                ),
              ),
              child: child!,
            );
          },
          initialDate: startDate,
          firstDate: startDate,
          lastDate: endDate)
      .then((value) {
    date = value!;
  });
  return date;
}
