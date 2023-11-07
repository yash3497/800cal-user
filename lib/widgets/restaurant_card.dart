import 'package:eight_hundred_cal/backend/bottom_bar/bottom_bar_backend.dart';
import 'package:eight_hundred_cal/model/restaurant/restaurant_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/home/restaurant_detail_page.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';

class RestaurantCard extends StatelessWidget {
  bool showBubble;
  final RestaurantModel model;
  RestaurantCard({
    super.key,
    required this.model,
    this.showBubble = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 196,
      padding: const EdgeInsets.symmetric(
        horizontal: 11,
      ).copyWith(top: 11),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: AppColor.inputBoxBGColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment:
            showBubble ? MainAxisAlignment.start : MainAxisAlignment.center,
        children: [
          showBubble
              ? Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    width: 20,
                    height: 20,
                    padding: const EdgeInsets.all(3),
                    decoration: ShapeDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(1.00, 0.00),
                        end: Alignment(-1, 0),
                        colors: [AppColor.secondaryColor, AppColor.greenColor],
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(27),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '1/4',
                        style: TextStyle(
                          color: AppColor.whiteColor,
                          fontSize: 8,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                )
              : SizedBox(),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              model.logo ??
                  "https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cmVzdGF1cmFudHxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=800&q=60",
              width: 90,
              height: 90,
              // fit: BoxFit.fill,
            ),
          ),
          heightBox(0),
          Text(
            "${model.title}",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColor.whiteColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 10,
            child: ListView.builder(
              itemCount: model.rating.toInt(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Icon(
                  index >= model.rating ? Icons.star_border : Icons.star,
                  color: AppColor.secondaryColor,
                  size: 10,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
