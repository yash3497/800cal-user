import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:eight_hundred_cal/utils/app_text.dart';
import 'package:eight_hundred_cal/utils/colors.dart';
import 'package:eight_hundred_cal/utils/constants.dart';
import 'package:eight_hundred_cal/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dashboard_page.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var c = Get.put(TranslatorBackend());
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColor.pimaryColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding)
            .copyWith(top: 20),
        child: Column(
          children: [
            CustomAppBar(
                text:
                    c.lang == 'en' ? AppText.contactUsEn : AppText.contactUsAr),
            heightBox(20),
            DashboardCardWidget(
              image: "assets/icons/phone.png",
              title: c.lang == 'en'
                  ? AppText.contactNumberEn
                  : AppText.contactNumberAr,
              onTap: () async {
                String url = 'tel:${AppText.contactUsEn}';
                if (await canLaunchUrl(Uri.parse(url))) {
                  await launchUrl(Uri.parse(url));
                }
              },
            ),
            heightBox(20),
            DashboardCardWidget(
              image: "assets/icons/email.png",
              title: c.lang == 'en'
                  ? AppText.contactEmailEn
                  : AppText.contactEmailAr,
              onTap: () async {
                String url =
                    'mailto:${AppText.contactEmailEn}?subject=App Feedback&body='
                    '';
                if (await canLaunchUrl(Uri.parse(url))) {
                  await launchUrl(Uri.parse(url));
                }
              },
            ),
          ],
        ),
      ),
    ));
  }
}
