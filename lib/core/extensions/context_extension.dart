import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  Size get size => MediaQuery.sizeOf(this);

  double get w => size.width;
  double get h => size.height;

  double wp(double percent) => w * percent;
  double hp(double percent) => h * percent;
}
