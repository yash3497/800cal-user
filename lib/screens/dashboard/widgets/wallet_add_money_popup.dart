import 'package:eight_hundred_cal/backend/payments/payment_gateway.dart';
import 'package:eight_hundred_cal/backend/profile/profile_backend.dart';
import 'package:eight_hundred_cal/backend/wallet/wallet_backend.dart';
import 'package:eight_hundred_cal/model/profile/profile_model.dart';
import 'package:eight_hundred_cal/widgets/show_loader_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../backend/translator/translator_backend.dart';
import '../../../utils/app_text.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../../../widgets/custom_button.dart';

walletAddMoneyDialog(BuildContext context) {
  var c = Get.put(TranslatorBackend());
  ProfileModel? model = Get.put(WalletBackend()).model;
  final controller = TextEditingController();
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        backgroundColor: AppColor.inputBoxBGColor,
        child: SizedBox(
          width: width(context),
          height: height(context) * .3,
          child: Padding(
            padding: EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  c.lang == 'en' ? AppText.addBalanceEn : AppText.addBalanceAr,
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
                    border: Border.all(color: AppColor.whiteColor, width: 0.5),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: TextFormField(
                        controller: controller,
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColor.whiteColor,
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: InputDecoration(
                          hintText: c.lang == 'en'
                              ? AppText.addAmountEn
                              : AppText.addAmountAr,
                          hintStyle: TextStyle(
                            color: AppColor.lightGreyColor,
                            fontWeight: FontWeight.w100,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
                heightBox(18),
                Center(
                  child: SizedBox(
                      width: 133,
                      height: 60,
                      child: CustomButton(
                        text: c.lang == 'en' ? AppText.addEn : AppText.addAr,
                        onTap: () {
                          if (controller.text.isNotEmpty) {
                            Get.put(PaymentGateway()).requestPayments(
                                context: context,
                                amount: controller.text,
                                description: "Amount added to wallet",
                                debited: false,
                                customerName: model!.firstname,
                                customerEmail: model.email,
                                customerPhone: model.phonenumber);
                          }
                        },
                      )),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
