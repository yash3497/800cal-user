// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:eight_hundred_cal/backend/bottom_bar/bottom_bar_backend.dart';
import 'package:eight_hundred_cal/backend/profile/profile_backend.dart';
import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:eight_hundred_cal/model/profile/profile_model.dart';
import 'package:eight_hundred_cal/screens/profile/widgets/add_profile_widget.dart';
import 'package:eight_hundred_cal/screens/profile/widgets/profile_widget.dart';
import 'package:eight_hundred_cal/screens/splash.dart';
import 'package:eight_hundred_cal/services/storage_service.dart';
import 'package:eight_hundred_cal/utils/app_text.dart';
import 'package:eight_hundred_cal/utils/colors.dart';
import 'package:eight_hundred_cal/utils/constants.dart';
import 'package:eight_hundred_cal/utils/db_keys.dart';
import 'package:eight_hundred_cal/widgets/custom_appbar.dart';
import 'package:eight_hundred_cal/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../backend/order/order_backend.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var c = Get.put(TranslatorBackend());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.put(ProfileBackend()).fetchProfileData();
    Get.put(OrderBackend()).fetchOrder();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColor.pimaryColor,
      body: GetBuilder<ProfileBackend>(builder: (controller) {
        ProfileModel model = controller.model ?? dummyProfileModel;
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding)
                .copyWith(top: 20),
            child: Column(
              children: [
                CustomAppBar(
                  text: c.lang == 'en' ? AppText.profileEn : AppText.profileAr,
                  showProfile: false,
                ),
                heightBox(10),
                ProfileMultiProfileWidget(
                  model: model,
                ),
                heightBox(10),
                NameAdressWidget(
                  name: model.firstname,
                  address: model.address,
                ),
                heightBox(20),
                ProfileInformationCard(
                  model: model,
                ),
                heightBox(20),
                CustomButton(
                  text: c.lang == 'en'
                      ? AppText.updateProfileEn
                      : AppText.updateProfileAr,
                  width: width(context),
                  onTap: () {
                    Get.put(BottomBarBackend()).updateIndex(11);
                  },
                ),
                heightBox(20),
                ProfileSavedAddressWidget(
                  address: model.address,
                ),
                heightBox(20),
                ProfilePastSubscriptionWidget(),
                heightBox(100),
              ],
            ),
          ),
        );
      }),
    ));
  }
}

class ProfilePastSubscriptionWidget extends StatelessWidget {
  const ProfilePastSubscriptionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var c = Get.put(TranslatorBackend());
    return GetBuilder<OrderBackend>(builder: (controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              c.lang == 'en'
                  ? AppText.pastSubscriptionsEn
                  : AppText.pastSubscriptionsAr,
              style: TextStyle(
                color: AppColor.whiteColor,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          heightBox(10),
          ListView.separated(
            itemCount: controller.orderList.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
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
                    Container(
                      width: 64,
                      height: 64,
                      decoration: ShapeDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              controller.orderList[index].program['logo']),
                          fit: BoxFit.fill,
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                    widthBox(12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${controller.orderList[index].program['name']} - ${controller.orderList[index].meals['name']}',
                          style: TextStyle(
                            color: AppColor.whiteColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '${controller.orderList[index].duration} ${c.lang == 'en' ? AppText.daySubscriptionEn : AppText.daySubscriptionAr}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColor.textgreyColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return heightBox(10);
            },
          ),
        ],
      );
    });
  }
}

class ProfileSavedAddressWidget extends StatelessWidget {
  final String address;
  const ProfileSavedAddressWidget({
    super.key,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    var c = Get.put(TranslatorBackend());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            c.lang == 'en'
                ? AppText.savedAddressesEn
                : AppText.savedAddressesAr,
            style: TextStyle(
              color: AppColor.whiteColor,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        heightBox(10),
        Container(
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
              Container(
                width: 64,
                height: 64,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: AppColor.secondaryColor),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.location_on_outlined,
                    color: AppColor.secondaryColor,
                  ),
                ),
              ),
              widthBox(12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    c.lang == 'en' ? AppText.homeEn : AppText.homeAr,
                    style: TextStyle(
                      color: AppColor.whiteColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    address,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColor.textgreyColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ProfileInformationCard extends StatelessWidget {
  final ProfileModel model;
  const ProfileInformationCard({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    var c = Get.put(TranslatorBackend());
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColor.inputBoxBGColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            c.lang == 'en' ? AppText.informationEn : AppText.informationAr,
            style: TextStyle(
              color: AppColor.whiteColor,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          heightBox(15),
          ProfileInformationCardDataWidget(
            icon: Icons.email_outlined,
            title: c.lang == 'en' ? AppText.emailEn : AppText.emailAr,
            data: model.email,
          ),
          heightBox(15),
          ProfileInformationCardDataWidget(
            icon: Icons.phone_outlined,
            title: c.lang == 'en' ? AppText.phoneEn : AppText.phoneAr,
            data: model.phonenumber,
          ),
          heightBox(15),
          ProfileInformationCardDataWidget(
            icon: Icons.calendar_month_outlined,
            title:
                c.lang == 'en' ? AppText.dateofbirthEn : AppText.dateofbirthAr,
            data:
                "${DateFormat("dd MMM, yyyy").format(DateTime.parse(model.dob))}",
          ),
        ],
      ),
    );
  }
}

class ProfileInformationCardDataWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String data;
  const ProfileInformationCardDataWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: AppColor.secondaryColor,
              size: 14,
            ),
            widthBox(10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColor.whiteColor,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
        Text(
          data,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColor.whiteColor,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        )
      ],
    );
  }
}

class NameAdressWidget extends StatelessWidget {
  final String name;
  final String address;
  const NameAdressWidget({
    super.key,
    required this.name,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    var c = Get.put(TranslatorBackend());
    return Column(
      children: [
        Text(
          name,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColor.whiteColor,
            fontSize: 28,
            fontWeight: FontWeight.w600,
          ),
        ),
        heightBox(7),
        Text(
          c.lang == 'en' ? AppText.shareEn : AppText.shareAr,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColor.secondaryColor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        heightBox(7),
        Text(
          address,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColor.whiteColor,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

class ProfileMultiProfileWidget extends StatelessWidget {
  final ProfileModel model;
  ProfileMultiProfileWidget({
    super.key,
    required this.model,
  });

  var controller = PageController(
    initialPage: 1,
    viewportFraction: 0.4,
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: width(context) * .62,
      child: PageView.builder(
        physics: NeverScrollableScrollPhysics(),
        controller: controller,
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return FittedBox(
              fit: BoxFit.scaleDown,
              child: index == 1
                  ? ProfileWidget(
                      token: Get.put(ProfileBackend()).userToken,
                    )
                  : model.subusers != null && model.subusers.length > 0
                      ? InkWell(
                          onTap: () {
                            StorageService()
                                .write(DbKeys.authToken, model.subusers[0]);
                            Get.offAll(() => SplashScreen());
                          },
                          child: ProfileWidget(
                            token: model.subusers[0],
                          ),
                        )
                      : model.subusers != null && model.subusers.length > 1
                          ? InkWell(
                              onTap: () {
                                StorageService()
                                    .write(DbKeys.authToken, model.subusers[1]);
                                Get.offAll(() => SplashScreen());
                              },
                              child: ProfileWidget(
                                token: model.subusers[1],
                              ),
                            )
                          : AddProfileWidget());
        },
      ),
    );
  }
}
