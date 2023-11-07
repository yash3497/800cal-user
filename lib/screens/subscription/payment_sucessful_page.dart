// ignore_for_file: use_build_context_synchronously

import 'package:eight_hundred_cal/backend/order/order_backend.dart';
import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:eight_hundred_cal/screens/subscription/widgets/subscription_confimation_popup.dart';
import 'package:eight_hundred_cal/utils/colors.dart';
import 'package:eight_hundred_cal/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/app_text.dart';

class PaymentSuccessFulPage extends StatefulWidget {
  const PaymentSuccessFulPage({super.key});

  @override
  State<PaymentSuccessFulPage> createState() => _PaymentSuccessFulPageState();
}

class _PaymentSuccessFulPageState extends State<PaymentSuccessFulPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _showConfirmationPopup();
  }

  _showConfirmationPopup() async {
    await Future.delayed(Duration(seconds: 5));
    showSubscriptionConfimationPopup(context);
  }

  @override
  Widget build(BuildContext context) {
    var c = Get.put(TranslatorBackend());

    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColor.pimaryColor,
      body: GetBuilder<OrderBackend>(builder: (controller) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding)
              .copyWith(top: 100, bottom: 50),
          child: Column(
            children: [
              Center(
                child: Image.asset(
                  "assets/icons/payment_sucess.png",
                  height: 200,
                ),
              ),
              heightBox(45),
              Center(
                child: Text(
                  c.lang == 'en'
                      ? AppText.paymentSuccessfulEn
                      : AppText.paymentSuccessfulAr,
                  style: TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Spacer(),
              Text(
                '${c.lang == 'en' ? AppText.invoiceNoEn : AppText.invoiceNoAr}: ${controller.invoiceNo} ',
                style: TextStyle(
                  color: AppColor.reviewCardTextColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              heightBox(5),
              Text(
                '${c.lang == 'en' ? AppText.orderNoEn : AppText.orderNoAr}: ${controller.orderId} ',
                style: TextStyle(
                  color: AppColor.reviewCardTextColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      }),
    ));
  }
}
