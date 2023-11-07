// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:eight_hundred_cal/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function()? onTap;
  final double? width;
  final bool isIcon;
  const CustomButton(
      {super.key,
      required this.text,
      this.onTap,
      this.width,
      this.isIcon = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: FittedBox(
          child: Container(
              width: width,
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 15),
              decoration: ShapeDecoration(
                gradient: LinearGradient(
                  begin: const Alignment(1.00, 0.00),
                  end: const Alignment(-1, 0),
                  colors: [AppColor.secondaryColor, AppColor.greenColor],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Center(
                child: isIcon
                    ? Icon(
                        Icons.arrow_forward_ios,
                        color: AppColor.whiteColor,
                        size: 24,
                      )
                    : Text(
                        text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColor.whiteColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              )),
        ),
      ),
    );
  }
}
