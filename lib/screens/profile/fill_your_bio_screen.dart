import 'package:eight_hundred_cal/backend/login/register_backend.dart';
import 'package:eight_hundred_cal/model/profile/profile_model.dart';

import 'package:eight_hundred_cal/services/storage_service.dart';
import 'package:eight_hundred_cal/utils/app_text.dart';
import 'package:eight_hundred_cal/utils/colors.dart';
import 'package:eight_hundred_cal/utils/constants.dart';
import 'package:eight_hundred_cal/utils/db_keys.dart';
import 'package:eight_hundred_cal/widgets/custom_button.dart';
import 'package:eight_hundred_cal/widgets/custom_text_box.dart';
import 'package:eight_hundred_cal/widgets/show_loader_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../backend/translator/translator_backend.dart';
import '../../widgets/custom_date_calendar_picker.dart';

class FillYourBioScreen extends StatefulWidget {
  const FillYourBioScreen({super.key});

  @override
  State<FillYourBioScreen> createState() => _FillYourBioScreenState();
}

class _FillYourBioScreenState extends State<FillYourBioScreen> {
  String dob = "";
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final dobController = TextEditingController();
  final genderController = TextEditingController();
  final emailController = TextEditingController();
  final passwordsController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final addressController = TextEditingController();

  var c = Get.put(TranslatorBackend());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColor.pimaryColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding)
              .copyWith(top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                c.lang == 'en'
                    ? AppText.fillYourBioToGetStartedEn
                    : AppText.fillYourBioToGetStartedAr,
                style: TextStyle(
                  color: AppColor.whiteColor,
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                ),
              ),
              heightBox(10),
              Text(
                c.lang == 'en'
                    ? AppText.fillYourBioDescEn
                    : AppText.fillYourBioDescAr,
                style: TextStyle(
                  color: AppColor.secondaryGreyColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              heightBox(20),
              CustomTextBox(
                  controller: nameController,
                  hintText: c.lang == 'en'
                      ? AppText.firstNameEn
                      : AppText.firstNameAr),
              heightBox(20),
              CustomTextBox(
                  controller: surnameController,
                  hintText:
                      c.lang == 'en' ? AppText.lastNameEn : AppText.lastNameAr),
              heightBox(20),
              CustomTextBox(
                controller: dobController,
                hintText: c.lang == 'en'
                    ? AppText.dateofbirthEn
                    : AppText.dateofbirthAr,
                readOnly: true,
                onTap: () async {
                  DateTime value = await customDatePicker(
                      context, DateTime(1900), DateTime(2025));
                  dob = value.toString();
                  dobController.text =
                      "${DateFormat('dd MMM, yyyy').format(value)}";
                },
              ),
              heightBox(20),
              CustomTextBox(
                  controller: genderController,
                  hintText:
                      c.lang == 'en' ? AppText.genderEn : AppText.genderAr),
              heightBox(20),
              CustomTextBox(
                  controller: addressController,
                  hintText:
                      c.lang == 'en' ? AppText.addressEn : AppText.addressAr),
              heightBox(20),
              CustomTextBox(
                  controller: emailController,
                  hintText: c.lang == 'en' ? AppText.emailEn : AppText.emailAr),
              heightBox(20),
              CustomTextBox(
                  controller: passwordsController,
                  hintText:
                      c.lang == 'en' ? AppText.passwordEn : AppText.passwordAr),
              heightBox(20),
              CustomTextBox(
                  controller: phoneNumberController,
                  hintText: c.lang == 'en'
                      ? AppText.phoneNumberEn
                      : AppText.phoneNumberAr),
              heightBox(20),
              CustomTextBox(
                  controller: heightController,
                  hintText: c.lang == 'en'
                      ? AppText.enterYourHeightEn
                      : AppText.enterYourHeightAr),
              heightBox(20),
              CustomTextBox(
                  controller: weightController,
                  hintText: c.lang == 'en'
                      ? AppText.enterYourWeightEn
                      : AppText.enterYourWeightAr),
              heightBox(20),
              CustomButton(
                text: c.lang == 'en' ? AppText.nextEn : AppText.nextAr,
                width: width(context),
                onTap: () async {
                  if (nameController.text.isNotEmpty &&
                      surnameController.text.isNotEmpty &&
                      dobController.text.isNotEmpty &&
                      genderController.text.isNotEmpty &&
                      addressController.text.isNotEmpty &&
                      emailController.text.isNotEmpty &&
                      phoneNumberController.text.isNotEmpty &&
                      heightController.text.isNotEmpty &&
                      weightController.text.isNotEmpty &&
                      passwordsController.text.isNotEmpty) {
                    ProfileModel model = ProfileModel(
                        username: emailController.text,
                        email: emailController.text,
                        password: passwordsController.text,
                        verified: true,
                        role: "user",
                        firstname: nameController.text,
                        lastname: surnameController.text,
                        dob: dob,
                        gender: genderController.text,
                        weight: int.parse(weightController.text),
                        height: int.parse(heightController.text),
                        allergy: [],
                        dislikes: [],
                        image:
                            'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8YXZhdGFyfGVufDB8fDB8fHww',
                        phonenumber: phoneNumberController.text,
                        address: addressController.text,
                        balance: 0,
                        isSubscribed: false,
                        subscriptionStartDate: 0,
                        subscriptionEndDate: 0,
                        subscriptionId: '',
                        subusers: [
                          await StorageService().read(DbKeys.authToken),
                        ]);
                    showLoaderDialog(context);
                    Get.put(RegisterBackend()).registerSubProfile(model);
                  }
                },
              ),
              heightBox(120),
            ],
          ),
        ),
      ),
    ));
  }
}
