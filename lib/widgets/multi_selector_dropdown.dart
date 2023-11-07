import 'package:eight_hundred_cal/backend/subscription/subscription_backend.dart';
import 'package:eight_hundred_cal/backend/theme/theme_backend.dart';
import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:eight_hundred_cal/model/ingredient/ingredient_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/home/dish_info_page.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';

class MultiSelectorDropDown extends StatelessWidget {
  final Function(String value, String id) onTap;
  final List<String> values;
  const MultiSelectorDropDown({
    super.key,
    required this.onTap,
    required this.values,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubscriptionBackend>(builder: (controller) {
      return InkWell(
        onTap: () {
          showDropdown(
              context, controller.ingredientList.map((e) => e.title).toList());
        },
        child: Container(
          width: double.infinity,
          height: 70,
          padding: const EdgeInsets.symmetric(horizontal: 30),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: AppColor.inputBoxBGColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: Row(
            children: [
              Row(
                children: values
                    .map((e) => Row(
                          children: [
                            MultiSlectorDropDownDataCard(
                              text: e,
                            ),
                            widthBox(10),
                          ],
                        ))
                    .toList(),
              ),
              Spacer(),
              RotatedBox(
                  quarterTurns: 3,
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Get.put(ThemeBackend()).isDarkMode
                        ? AppColor.lightGreyColor
                        : AppColor.whiteColor,
                    size: 20,
                  )),
            ],
          ),
        ),
      );
    });
  }

  void showDropdown(BuildContext context, List items) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Overlay.of(context)!.context.findRenderObject() as RenderBox;
    final Offset offset =
        renderBox.localToGlobal(Offset.zero, ancestor: overlay);

    showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx + renderBox.size.width, // left
        offset.dy + renderBox.size.height, // top
        offset.dx, // right
        offset.dy + renderBox.size.height + allergies.length * 40.0, // bottom
      ),
      items: items.map<PopupMenuEntry<String>>((value) {
        return PopupMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    ).then((value) {
      if (value != null) {
        String id = '';
        Get.put(SubscriptionBackend()).ingredientList.forEach((element) {
          if (element.title == value) {
            id = element.id;
          }
        });
        onTap(
          value,
          id,
        );
      }
    });
  }
}
