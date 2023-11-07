import 'dart:math';

import 'package:flutter/material.dart';

import '../../../model/pie_chart/char_data_model.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';

class SubscribedHomeDonutChart extends StatelessWidget {
  final String text;
  const SubscribedHomeDonutChart({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: width(context) * .4, // Adjust the size as needed
        height: 0,
        child: CustomPaint(
          painter: DonutChartPainter(text),
        ),
      ),
    );
  }
}

class DonutChartPainter extends CustomPainter {
  final String text;
  DonutChartPainter(this.text);

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 1.5;
    final holeRadius = size.width / 4;
    var gapAngle = 0.12;
    double startAngle = -pi / 2;

    for (var segment in segments) {
      final sweepAngle = (segment.percent / 100) * 2 * pi;

      if (sweepAngle <= gapAngle) {
        startAngle += sweepAngle;
        continue;
      }

      final endAngle = startAngle + sweepAngle;

      final path = Path()
        ..moveTo(centerX, centerY)
        ..arcTo(
          Rect.fromCircle(
            center: Offset(centerX, centerY),
            radius: size.width / 2,
          ),
          startAngle,
          sweepAngle - gapAngle,
          false,
        )
        ..arcTo(
          Rect.fromCircle(
            center: Offset(centerX, centerY),
            radius: size.width / 2 - 30,
          ),
          endAngle - gapAngle,
          -(sweepAngle - gapAngle),
          false,
        )
        ..close();

      final paint = Paint()
        ..color = segment.color
        ..style = PaintingStyle.fill;

      canvas.drawPath(path, paint);

      startAngle = endAngle;
    }

    final holePaint = Paint()
      ..color = AppColor.pimaryColor
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(centerX, centerY), holeRadius, holePaint);

    // Text to display in the center
    final textStyle = TextStyle(
      color: AppColor.whiteColor,
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
    );

    final textSpan = TextSpan(
      text: text,
      style: textStyle,
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(minWidth: 0, maxWidth: size.width);
    textPainter.paint(
      canvas,
      Offset(centerX - textPainter.width / 2, centerY - textPainter.height / 2),
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
