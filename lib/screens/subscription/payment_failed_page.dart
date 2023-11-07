import 'package:eight_hundred_cal/backend/bottom_bar/bottom_bar_backend.dart';
import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:eight_hundred_cal/utils/colors.dart';
import 'package:eight_hundred_cal/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/app_text.dart';

class PaymentFailedPage extends StatefulWidget {
  const PaymentFailedPage({super.key});

  @override
  State<PaymentFailedPage> createState() => _PaymentFailedPageState();
}

class _PaymentFailedPageState extends State<PaymentFailedPage> {
  _showConfirmationPopup() async {
    await Future.delayed(Duration(seconds: 3));
    Get.put(BottomBarBackend()).updateIndex(0);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _showConfirmationPopup();
  }

  @override
  Widget build(BuildContext context) {
    var c = Get.put(TranslatorBackend());
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColor.pimaryColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding)
            .copyWith(top: 100, bottom: 50),
        child: Column(
          children: [
            Center(
              child: Image.asset(
                "assets/icons/payment_failed.png",
                height: 200,
              ),
            ),
            heightBox(45),
            Center(
              child: Text(
                c.lang == 'en'
                    ? AppText.paymentFailedEn
                    : AppText.paymentFailedAr,
                style: TextStyle(
                  color: AppColor.whiteColor,
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
