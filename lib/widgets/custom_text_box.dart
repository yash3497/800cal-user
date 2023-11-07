import 'package:eight_hundred_cal/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomTextBox extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final bool? obscureText;
  final bool showBorder;
  final bool readOnly;
  final Function()? onTap;
  final Function(String)? onChanged;
  final String? initialValue;
  const CustomTextBox({
    super.key,
    this.controller,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText,
    this.showBorder = false,
    this.readOnly = false,
    this.onTap,
    this.onChanged,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      onChanged: onChanged,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: AppColor.textgreyColor,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        fillColor: AppColor.inputBoxBGColor,
        filled: true,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: showBorder
              ? BorderSide(color: AppColor.whiteColor, width: 0.50)
              : BorderSide.none,
        ),
      ),
      style: TextStyle(
        color: AppColor.whiteColor,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
