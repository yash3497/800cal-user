import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../../../widgets/custom_button.dart';

class MealSelectCard extends StatelessWidget {
  const MealSelectCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: AppColor.inputBoxBGColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(children: [
          Align(
            alignment: Alignment.topRight,
            child: Image.asset(
              "assets/icons/leaf2.png",
              width: 20,
              height: 20,
            ),
          ),
          Image.asset(
            "assets/images/pancake.png",
            width: 90,
            height: 90,
          ),
          Text(
            'Pancake',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColor.whiteColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            '1kcal',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColor.reviewCardTextColor,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            '4g protein, 4g carbs',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColor.reviewCardTextColor,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
          heightBox(4),
          SizedBox(width: 70, height: 23, child: CustomButton(text: "Select")),
        ]),
      ),
    );
  }
}
