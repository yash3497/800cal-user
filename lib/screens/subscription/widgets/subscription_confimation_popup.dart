// ignore_for_file: prefer_const_constructors

import 'package:eight_hundred_cal/backend/restaurant/restaurant_backend.dart';
import 'package:eight_hundred_cal/backend/subscription/subscription_backend.dart';
import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:eight_hundred_cal/screens/subscription/subscription_loader_page.dart';
import 'package:eight_hundred_cal/utils/app_text.dart';
import 'package:eight_hundred_cal/utils/constants.dart';
import 'package:eight_hundred_cal/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';

void showSubscriptionConfimationPopup(BuildContext context) async {
  var c = Get.put(TranslatorBackend());
  showDialog(
    context: context,
    builder: (context) {
      return GetBuilder<SubscriptionBackend>(
          init: SubscriptionBackend(),
          builder: (controller) {
            return Dialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              insetPadding: EdgeInsets.symmetric(horizontal: 10),
              backgroundColor: AppColor.inputBoxBGColor,
              child: SizedBox(
                width: width(context),
                height: height(context) * .5,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.thumb_up_alt_outlined,
                            color: AppColor.secondaryColor,
                            size: 20,
                          ),
                          widthBox(10),
                          Text(
                            c.lang == 'en'
                                ? AppText.subscriptionCompletedlEn
                                : AppText.subscriptionCompletedlAr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColor.whiteColor,
                              fontSize: 22,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      heightBox(18),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              controller.autofill = !controller.autofill;
                              controller.update();
                            },
                            child: Container(
                              width: 21,
                              height: 21,
                              decoration: ShapeDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment(1.00, 0.00),
                                  end: Alignment(-1, 0),
                                  colors: [
                                    controller.autofill
                                        ? AppColor.secondaryColor
                                        : AppColor.inputBoxBGColor,
                                    controller.autofill
                                        ? AppColor.greenColor
                                        : AppColor.inputBoxBGColor,
                                  ],
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    side: BorderSide(
                                      color: controller.autofill
                                          ? AppColor.secondaryColor
                                          : AppColor.whiteColor,
                                    )),
                              ),
                              child: Center(
                                child: controller.autofill
                                    ? Icon(
                                        Icons.check,
                                        color: AppColor.whiteColor,
                                        size: 18,
                                      )
                                    : SizedBox(),
                              ),
                            ),
                          ),
                          widthBox(18),
                          Text(
                            c.lang == 'en'
                                ? AppText.subscriptionCompletedPopupDescEn
                                : AppText.subscriptionCompletedPopupDescAr,
                            style: TextStyle(
                              color: AppColor.whiteColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      heightBox(18),
                      Text(
                        c.lang == 'en'
                            ? AppText.subscriptionCompletedPopupDesc2En
                            : AppText.subscriptionCompletedPopupDesc2Ar,
                        style: TextStyle(
                          color: AppColor.whiteColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      heightBox(10),
                      Container(
                        width: width(context),
                        height: 70,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: AppColor.whiteColor, width: 0.5),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: TextFormField(
                              initialValue:
                                  "${controller.calories} ${c.lang == 'en' ? AppText.kcalEn : AppText.kcalAr}",
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
                      heightBox(18),
                      Center(
                          child: CustomButton(
                        text: c.lang == 'en' ? AppText.yesEn : AppText.yesAr,
                        onTap: () async {
                          if (controller.autofill) {
                            await Get.put(RestaurantBackend())
                                .fetchAllRestaurants()
                                .then((value) =>
                                    Get.to(() => SubscriptionLoaderPage(
                                          auto: true,
                                        )));
                          } else {
                            Get.to(() => SubscriptionLoaderPage(
                                  auto: false,
                                ));
                          }
                        },
                      )),
                    ],
                  ),
                ),
              ),
            );
          });
    },
  );
}
