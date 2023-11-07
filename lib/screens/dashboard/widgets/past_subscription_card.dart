import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:eight_hundred_cal/model/order/order_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/app_text.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';

class PastSubscriptionCard extends StatelessWidget {
  final OrderModel model;
  const PastSubscriptionCard({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    var c = Get.put(TranslatorBackend());
    return Container(
      width: width(context),
      padding: const EdgeInsets.all(12),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: AppColor.inputBoxBGColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              model.program['logo'],
              width: 56,
              height: 56,
              fit: BoxFit.cover,
            ),
          ),
          widthBox(12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model.program['name']} - ${model.meals['name']}',
                style: TextStyle(
                  color: AppColor.whiteColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              heightBox(5),
              Text(
                '${model.duration} ${c.lang == 'en' ? AppText.daySubscriptionEn : AppText.daySubscriptionAr}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColor.secondaryGreyColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
          Spacer(),
          Container(
            height: 28,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            decoration: ShapeDecoration(
              color: AppColor.secondaryColor.withOpacity(.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(21),
              ),
            ),
            child: Text(
              '${model.program['kcal']}${c.lang == 'en' ? AppText.kcalEn : AppText.kcalAr}',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColor.secondaryColor,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
