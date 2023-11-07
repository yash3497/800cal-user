import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}

class DonutSegment {
  final double percent;
  final Color color;

  DonutSegment(this.percent, this.color);
}

List<DonutSegment> segments = [
  DonutSegment(50.0, AppColor.reviewCardTextColor),
  DonutSegment(10.0, AppColor.blueColor),
  DonutSegment(15.0, AppColor.yellowColor),
  DonutSegment(25.0, AppColor.secondaryColor),
];
