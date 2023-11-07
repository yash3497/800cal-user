import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:eight_hundred_cal/backend/wallet/wallet_backend.dart';
import 'package:eight_hundred_cal/screens/dashboard/widgets/past_subscription_card.dart';
import 'package:eight_hundred_cal/screens/dashboard/widgets/wallet_add_money_popup.dart';
import 'package:eight_hundred_cal/services/app_services.dart';
import 'package:eight_hundred_cal/utils/colors.dart';
import 'package:eight_hundred_cal/utils/constants.dart';
import 'package:eight_hundred_cal/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/profile/profile_model.dart';
import '../../utils/app_text.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  var c = Get.put(TranslatorBackend());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.put(WalletBackend()).fetchProfileData();
    Get.put(WalletBackend()).fetchTransaction();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColor.pimaryColor,
      body: GetBuilder<WalletBackend>(builder: (controller) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding)
                .copyWith(top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBar(
                    text: c.lang == 'en' ? AppText.walletEn : AppText.walletAr),
                heightBox(20),
                WalletBalanceCard(),
                heightBox(30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      c.lang == 'en'
                          ? AppText.latestTransactionsEn
                          : AppText.latestTransactionsAr,
                      style: TextStyle(
                        color: AppColor.whiteColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      c.lang == 'en' ? AppText.viewAllEn : AppText.viewAllAr,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: AppColor.secondaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
                heightBox(20),
                ListView.separated(
                  itemCount: controller.transactionList.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    var d = controller.transactionList[index];
                    return WalletLatestTransactionCard(
                      debited: d.debited,
                      price: d.amount.toString(),
                      date: AppServices()
                          .getTimeDifferenceString(d.timestamp.toInt()),
                      description: d.description,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Divider(
                        color: AppColor.reviewCardTextColor,
                      ),
                    );
                  },
                ),
                heightBox(120),
              ],
            ),
          ),
        );
      }),
    ));
  }
}

class WalletLatestTransactionCard extends StatefulWidget {
  final bool debited;
  final String date;
  final String price;
  final String description;
  const WalletLatestTransactionCard(
      {super.key,
      required this.debited,
      required this.date,
      required this.price,
      required this.description});

  @override
  State<WalletLatestTransactionCard> createState() =>
      _WalletLatestTransactionCardState();
}

class _WalletLatestTransactionCardState
    extends State<WalletLatestTransactionCard> {
  var c = Get.put(TranslatorBackend());
  String desc = '';
  String date = '';

  _changeLanguage() async {
    desc = await c.translateText(widget.description);
    date = await c.translateText(widget.date);
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: ShapeDecoration(
            color: AppColor.inputBoxBGColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(13),
            ),
          ),
          child: Center(
            child: Image.asset(
              "assets/icons/purse.png",
              width: 22,
              height: 22,
            ),
          ),
        ),
        widthBox(20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              desc,
              style: TextStyle(
                color: AppColor.whiteColor,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            heightBox(5),
            Text(
              date,
              style: TextStyle(
                color: AppColor.secondaryColor,
                fontSize: 10,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
        Spacer(),
        Text(
          '${widget.debited ? '-' : '+'}${c.lang == 'en' ? AppText.kdEn : AppText.kdAr}${widget.price}',
          textAlign: TextAlign.right,
          style: TextStyle(
            color: widget.debited ? AppColor.redColor : AppColor.secondaryColor,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
        widthBox(5),
        Icon(
          Icons.arrow_forward_ios,
          size: 12,
          color: AppColor.lightGreyColor,
        ),
      ],
    );
  }
}

class WalletBalanceCard extends StatelessWidget {
  const WalletBalanceCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var c = Get.put(TranslatorBackend());
    return GetBuilder<WalletBackend>(builder: (controller) {
      ProfileModel model = controller.model ??
          ProfileModel(
            username: "",
            email: "",
            password: "",
            verified: true,
            role: "",
            firstname: "",
            lastname: "",
            dob: "${DateTime.now()}",
            gender: "",
            weight: 0,
            height: 0,
            allergy: [],
            dislikes: [],
            image: "",
            phonenumber: "",
            address: "",
            balance: 0,
            isSubscribed: false,
            subscriptionStartDate: 0,
            subscriptionEndDate: 0,
            subscriptionId: '',
            subusers: [],
          );
      return Container(
        decoration: ShapeDecoration(
          gradient: LinearGradient(
            begin: Alignment(1.00, 0.00),
            end: Alignment(-1, 0),
            colors: [AppColor.secondaryColor, AppColor.greenColor],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(29),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        c.lang == 'en'
                            ? AppText.mainBalanceEn
                            : AppText.mainBalanceAr,
                        style: TextStyle(
                          color: AppColor.inputBoxBGColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  c.lang == 'en' ? AppText.kdEn : AppText.kdAr,
                              style: TextStyle(
                                color: AppColor.pimaryColor,
                                fontSize: 36,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: '${model.balance}',
                              style: TextStyle(
                                color: AppColor.pimaryColor,
                                fontSize: 36,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            // TextSpan(
                            //   text: '.34',
                            //   style: TextStyle(
                            //     color: AppColor.pimaryColor,
                            //     fontSize: 18,
                            //     fontWeight: FontWeight.w400,
                            //   ),
                            // ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                  Image.asset(
                    "assets/icons/safeguard.png",
                    width: 33,
                    height: 38,
                  ),
                ],
              ),
              heightBox(25),
              // InkWell(
              //   onTap: () {
              //     walletAddMoneyDialog(context);
              //   },
              //   child: FittedBox(
              //     child: Container(
              //       padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              //       decoration: ShapeDecoration(
              //         color: AppColor.inputBoxBGColor,
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(30),
              //         ),
              //       ),
              //       child: Row(
              //         children: [
              //           Image.asset(
              //             "assets/icons/upload-line.png",
              //             width: 16,
              //             height: 16,
              //           ),
              //           widthBox(5),
              //           Text(
              //             c.lang == 'en' ? AppText.topUpEn : AppText.topUpAr,
              //             textAlign: TextAlign.center,
              //             style: TextStyle(
              //               color: AppColor.whiteColor,
              //               fontSize: 12,
              //               fontWeight: FontWeight.w400,
              //             ),
              //           )
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      );
    });
  }
}
