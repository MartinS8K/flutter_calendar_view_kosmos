// Copyright (c) 2021 Simform Solutions. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import '../calendar_view.dart';
import 'constants.dart';

/// Paints 24 hour lines.
class HourLinePainter extends CustomPainter {
  /// Color of hour line
  final Color lineColor;

  /// Height of hour line
  final double lineHeight;

  /// Offset of hour line from left.
  final double offset;

  /// Height occupied by one minute of time stamp.
  final double minuteHeight;

  /// Flag to display vertical line at left or not.
  final bool showVerticalLine;

  /// left offset of vertical line.
  final double verticalLineOffset;

  /// Style of the hour and vertical line
  final LineStyle lineStyle;

  /// Line dash width when using the [LineStyle.dashed] style
  final double dashWidth;

  /// Line dash space width when using the [LineStyle.dashed] style
  final double dashSpaceWidth;

  /// Emulates offset of vertical line from hour line starts.
  final double emulateVerticalOffsetBy;

  /// Defines the maximum, minimum Hour time display in day view and ajust the size of the big container.
  final MinMax minMax;

  /// Paints 24 hour lines.
  HourLinePainter({
    required this.lineColor,
    required this.lineHeight,
    required this.minuteHeight,
    required this.offset,
    required this.showVerticalLine,
    required this.emulateVerticalOffsetBy,
    this.minMax = const MinMax(),
    this.verticalLineOffset = 10,
    this.lineStyle = LineStyle.solid,
    this.dashWidth = 4,
    this.dashSpaceWidth = 4,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final dx = offset + emulateVerticalOffsetBy;
    final paint = Paint()
      ..color = lineColor
      ..strokeWidth = lineHeight;

    for (var i = 0; i < (minMax.difference ?? Constants.hoursADay); i++) {
      final dy = i * minuteHeight * 60;
      if (lineStyle == LineStyle.dashed) {
        var startX = dx;
        while (startX < size.width) {
          canvas.drawLine(Offset(startX, dy), Offset(startX + dashWidth, dy), paint);
          startX += dashWidth + dashSpaceWidth;
        }
      } else {
        canvas.drawLine(Offset(dx, dy), Offset(size.width, dy), paint);
      }
    }

    if (showVerticalLine) if (lineStyle == LineStyle.dashed) {
      var startY = 0.0;
      while (startY < size.height) {
        canvas.drawLine(Offset(offset + verticalLineOffset, startY),
            Offset(offset + verticalLineOffset, startY + dashWidth), paint);
        startY += dashWidth + dashSpaceWidth;
      }
    } else {
      canvas.drawLine(Offset(offset + verticalLineOffset, 0), Offset(offset + verticalLineOffset, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is HourLinePainter &&
        (oldDelegate.lineColor != lineColor ||
            oldDelegate.offset != offset ||
            lineHeight != oldDelegate.lineHeight ||
            minuteHeight != oldDelegate.minuteHeight ||
            showVerticalLine != oldDelegate.showVerticalLine);
  }
}

class HalfHourLinePainter extends CustomPainter {
  /// Color of half hour line
  final Color lineColor;

  /// Height of half hour line
  final double lineHeight;

  /// Offset of half hour line from left.
  final double offset;

  /// Height occupied by one minute of time stamp.
  final double minuteHeight;

  /// Style of the half hour line
  final LineStyle lineStyle;

  /// Line dash width when using the [LineStyle.dashed] style
  final double dashWidth;

  /// Line dash space width when using the [LineStyle.dashed] style
  final double dashSpaceWidth;

  /// Defines the maximum, minimum Hour time display in day view and ajust the size of the big container.
  final MinMax minMax;

  /// Paint half hour lines
  HalfHourLinePainter({
    required this.lineColor,
    required this.lineHeight,
    required this.offset,
    required this.minuteHeight,
    required this.lineStyle,
    this.minMax = const MinMax(),
    this.dashWidth = 4,
    this.dashSpaceWidth = 4,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor
      ..strokeWidth = lineHeight;

    for (var i = 0 + (minMax.min ?? 0); i < (minMax.max ?? Constants.hoursADay); i++) {
      final dy = (i - (minMax.min ?? 0)) * minuteHeight * 60 + (minuteHeight * 30);
      if (lineStyle == LineStyle.dashed) {
        var startX = offset;
        while (startX < size.width) {
          canvas.drawLine(Offset(startX, dy), Offset(startX + dashWidth, dy), paint);
          startX += dashWidth + dashSpaceWidth;
        }
      } else {
        canvas.drawLine(Offset(offset, dy), Offset(size.width, dy), paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is HourLinePainter &&
        (oldDelegate.lineColor != lineColor ||
            oldDelegate.offset != offset ||
            lineHeight != oldDelegate.lineHeight ||
            minuteHeight != oldDelegate.minuteHeight);
  }
}

//using HalfHourIndicatorSettings for this too
class QuarterHourLinePainter extends CustomPainter {
  /// Color of quarter hour line
  final Color lineColor;

  /// Height of quarter hour line
  final double lineHeight;

  /// Offset of quarter hour line from left.
  final double offset;

  /// Height occupied by one minute of time stamp.
  final double minuteHeight;

  /// Style of the quarter hour line
  final LineStyle lineStyle;

  /// Line dash width when using the [LineStyle.dashed] style
  final double dashWidth;

  /// Line dash space width when using the [LineStyle.dashed] style
  final double dashSpaceWidth;

  /// Defines the maximum, minimum Hour time display in day view and ajust the size of the big container.
  final MinMax minMax;

  /// Paint quarter hour lines
  QuarterHourLinePainter({
    required this.lineColor,
    required this.lineHeight,
    required this.offset,
    required this.minuteHeight,
    required this.lineStyle,
    this.minMax = const MinMax(),
    this.dashWidth = 4,
    this.dashSpaceWidth = 4,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor
      ..strokeWidth = lineHeight;

    for (var i = 0 + (minMax.min ?? 0); i < (minMax.max ?? Constants.hoursADay); i++) {
      final dy1 = (i - (minMax.min ?? 0)) * minuteHeight * 60 + (minuteHeight * 15);
      final dy2 = (i - (minMax.min ?? 0)) * minuteHeight * 60 + (minuteHeight * 45);

      if (lineStyle == LineStyle.dashed) {
        var startX = offset;
        while (startX < size.width) {
          canvas.drawLine(Offset(startX, dy1), Offset(startX + dashWidth, dy1), paint);
          startX += dashWidth + dashSpaceWidth;

          canvas.drawLine(Offset(startX, dy2), Offset(startX + dashWidth, dy2), paint);
          startX += dashWidth + dashSpaceWidth;
        }
      } else {
        // canvas.drawLine(Offset(offset, dy1), Offset(size.width, dy1), paint);
        // canvas.drawLine(Offset(offset, dy2), Offset(size.width, dy2), paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is HourLinePainter &&
        (oldDelegate.lineColor != lineColor ||
            oldDelegate.offset != offset ||
            lineHeight != oldDelegate.lineHeight ||
            minuteHeight != oldDelegate.minuteHeight);
  }
}

/// Paints a single horizontal line at [offset].
class CurrentTimeLinePainter extends CustomPainter {
  /// Color of time indicator.
  final Color color;

  /// Height of time indicator.
  final double height;

  /// offset of time indicator.
  final Offset offset;

  /// Flag to show bullet at left side or not.
  final bool showBullet;

  /// Radius of bullet.
  final double bulletRadius;

  /// Paints a single horizontal line at [offset].
  CurrentTimeLinePainter({
    required this.color,
    required this.height,
    required this.offset,
    this.showBullet = true,
    this.bulletRadius = 5,
  });

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(
      Offset(offset.dx, offset.dy),
      Offset(size.width, offset.dy),
      Paint()
        ..color = color
        ..strokeWidth = height,
    );

    if (showBullet) canvas.drawCircle(Offset(offset.dx, offset.dy), bulletRadius, Paint()..color = color);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>
      oldDelegate is CurrentTimeLinePainter &&
      (color != oldDelegate.color || height != oldDelegate.height || offset != oldDelegate.offset);
}

class HourRectPainter<T> extends CustomPainter {
  /// Color of hour line
  final Color lineColor;

  /// Height of hour line
  final double lineHeight;

  /// Offset of hour line from left.
  final double offset;

  /// Height occupied by one minute of time stamp.
  final double minuteHeight;

  /// Defines the maximum, minimum Hour time display in day view and ajust the size of the big container.
  final MinMax minMax;

  /// Define distance between rect.
  final double distanceBetweenRect;

  ///
  final MinuteSlotSize minuteSlotSize;

  final EventController<T> controller;

  final DateTime currentDate;

  /// Paints 24 hour rect.
  HourRectPainter(
      {required this.lineColor,
      required this.lineHeight,
      required this.minuteHeight,
      required this.offset,
      this.minuteSlotSize = MinuteSlotSize.minutes60,
      this.distanceBetweenRect = 2.5,
      this.minMax = const MinMax(),
      required this.controller,
      required this.currentDate});

  @override
  void paint(Canvas canvas, Size size) {
    var eventDoubles = controller.getEventsIntOnDay(currentDate);
    int minutes = minuteSlotSize == MinuteSlotSize.minutes15
        ? 15
        : minuteSlotSize == MinuteSlotSize.minutes30
            ? 30
            : 60;
    final paint = Paint()
      ..color = lineColor
      ..strokeWidth = lineHeight;

    if (minuteSlotSize == MinuteSlotSize.minutes30)
      for (var i = minMax.min ?? 0; i < (minMax.max ?? Constants.hoursADay); i++) {
        if (!eventDoubles.contains((i.toDouble() + 0.5)))
        {final dy = (i - (minMax.min ?? 0)) * minuteHeight * 60 + (minuteHeight * 30);

        RRect roundedRect = RRect.fromRectAndRadius(
            Rect.fromLTWH(offset, dy + distanceBetweenRect, size.width - (offset + (distanceBetweenRect * 2)),
                (minutes * minuteHeight) - distanceBetweenRect * 2),
            Radius.circular(7));
        canvas.drawRRect(roundedRect, paint..style = PaintingStyle.stroke);}
      }

    for (var i = 0; i < (minMax.difference ?? Constants.hoursADay); i++) {
      if (!eventDoubles.contains(i + minMax.min!)) {
        final dy = i * minuteHeight * 60;
        RRect roundedRect = RRect.fromRectAndRadius(
            Rect.fromLTWH(offset, dy + distanceBetweenRect, size.width - (offset + (distanceBetweenRect * 2)),
                (minutes * minuteHeight) - distanceBetweenRect * 2),
            Radius.circular(7));
        canvas.drawRRect(roundedRect, paint..style = PaintingStyle.stroke);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is HourRectPainter &&
        (oldDelegate.lineColor != lineColor ||
            oldDelegate.offset != offset ||
            lineHeight != oldDelegate.lineHeight ||
            minuteHeight != oldDelegate.minuteHeight);
  }
}

class MinMax {
  final int? min;
  final int? max;
  final bool isFixed;

  int? get difference {
    if (max != null && min != null) {
      return max! - min!;
    } else {
      return null;
    }
  }

  const MinMax({this.min, this.max, this.isFixed = false});
}
