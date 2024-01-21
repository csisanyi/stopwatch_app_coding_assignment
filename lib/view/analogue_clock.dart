import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stopwatch/provider/data_provider.dart';
import 'package:stopwatch/provider/theme_provider.dart';

class AnalogueClock extends StatelessWidget {
  final double width;
  final double height;

  const AnalogueClock({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    return SizedBox(
      height: height,
      width: width,
      child: CustomPaint(
        painter: ClockPainter(dataProvider.hours, dataProvider.minutes,
            dataProvider.seconds, themeProvider, false),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  int seconds;
  int minutes;
  int hours;
  bool landscape;
  final ThemeProvider themeProvider;

  ClockPainter(this.hours, this.minutes, this.seconds, this.themeProvider,
      this.landscape);

  @override
  void paint(Canvas canvas, Size size) {
    double secRad = ((pi / 2) - (pi / 30) * this.seconds) % (2 * pi);
    double minRad = ((pi / 2) - (pi / 30) * this.minutes) % (2 * pi);
    double hourRad = ((pi / 2) - (pi / 6) * this.hours) % (2 * pi);

    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var center = Offset(centerX, centerY);
    var radius = min(centerX, centerY);

    var secHeight = radius / 2 + 40;
    var minHeight = radius / 2 + 20;
    var hoursHeight = radius / 2 - 25;

    var seconds = Offset(
        centerX + secHeight * cos(secRad), centerY - secHeight * sin(secRad));
    var minutes = Offset(
        centerX + cos(minRad) * minHeight, centerY - sin(minRad) * minHeight);
    var hours = Offset(centerX + cos(hourRad) * hoursHeight,
        centerY - sin(hourRad) * hoursHeight);

    var circleBorderBrush = Paint()
      ..color = themeProvider.strokeColor!
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke;

    var centerDotBrush = Paint()..color = themeProvider.strokeColor!;

    var secHandBrush = Paint()
      ..color = themeProvider.strokeColor!
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4
      ..strokeJoin = StrokeJoin.round;

    var minHandBrush = Paint()
      ..color = themeProvider.strokeColor!
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 8
      ..strokeJoin = StrokeJoin.round;

    var hourHandBrush = Paint()
      ..color = themeProvider.strokeColor!
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 14
      ..strokeJoin = StrokeJoin.round;

    var dialPaint = Paint()
      ..color = themeProvider.strokeColor!
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4;

    var textStyle = TextStyle(
        color: themeProvider.strokeColor,
        fontWeight: FontWeight.bold,
        fontSize: themeProvider.isLargeScreen! ? 60 : 30,
        fontStyle: FontStyle.italic,
        fontFamily: 'Montserrat');

    drawDial(canvas, center, radius, 12, dialPaint, textStyle);
    drawDial(canvas, center, radius, 3, dialPaint, textStyle);
    drawDial(canvas, center, radius, 6, dialPaint, textStyle);
    drawDial(canvas, center, radius, 9, dialPaint, textStyle);

    canvas.drawCircle(center, radius, circleBorderBrush);
    canvas.drawLine(center, seconds, secHandBrush);
    canvas.drawLine(center, minutes, minHandBrush);
    canvas.drawLine(center, hours, hourHandBrush);
    canvas.drawCircle(center, 8, centerDotBrush);
  }

  void drawDial(Canvas canvas, Offset center, double radius, int hour,
      Paint paint, TextStyle textStyle) {
    const double dialLength = 15.0;
    const double dialTextDistance = 20.0;

    double dialRad = ((pi / 2) - (pi / 6) * hour) % (2 * pi);
    var dialEnd = Offset(
      center.dx + radius * cos(dialRad),
      center.dy - radius * sin(dialRad),
    );

    var dialStart = Offset(
      center.dx + (radius - dialLength) * cos(dialRad),
      center.dy - (radius - dialLength) * sin(dialRad),
    );
    canvas.drawLine(dialStart, dialEnd, paint);

    TextSpan dialText = TextSpan(
      text: hour.toString(),
      style: textStyle,
    );

    TextPainter textPainter = TextPainter(
      text: dialText,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    Offset textPosition;

    switch (hour) {
      case 12:
        textPosition = themeProvider.isLargeScreen!
            ? Offset(
                dialEnd.dx - textPainter.width / 2 + dialTextDistance - 20,
                dialEnd.dy - textPainter.height / 2 + 50,
              )
            : Offset(
                dialEnd.dx - textPainter.width / 2,
                dialEnd.dy + dialTextDistance - 5,
              );
        break;
      case 3:
        textPosition = themeProvider.isLargeScreen!
            ? Offset(
                dialEnd.dx - textPainter.width / 2 + dialTextDistance - 60,
                dialEnd.dy - textPainter.height / 2,
              )
            : Offset(
                dialEnd.dx - textPainter.width / 2 - dialTextDistance - 10,
                dialEnd.dy - textPainter.height / 2,
              );
        break;
      case 6:
        textPosition = themeProvider.isLargeScreen!
            ? Offset(
                dialEnd.dx - textPainter.width / 2 + dialTextDistance - 20,
                dialEnd.dy - textPainter.height / 2 - 60,
              )
            : Offset(
                dialEnd.dx - textPainter.width / 2,
                dialEnd.dy - dialLength - dialLength - 20,
              );
        break;
      case 9:
        textPosition = themeProvider.isLargeScreen!
            ? Offset(
                dialEnd.dx - textPainter.width / 2 + dialTextDistance + 20,
                dialEnd.dy - textPainter.height / 2,
              )
            : Offset(
                dialEnd.dx - textPainter.width / 2 + dialTextDistance + 10,
                dialEnd.dy - textPainter.height / 2,
              );
        break;
      default:
        textPosition = const Offset(0, 0);
    }

    textPainter.paint(canvas, textPosition);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
