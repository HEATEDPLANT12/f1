import 'package:flutter/material.dart';

double contextWidth(BuildContext context, double fraction) {
  return MediaQuery.sizeOf(context).width * fraction;
}

double contextHeight(BuildContext context, double fraction) {
  return MediaQuery.sizeOf(context).height * fraction;
}

double responsiveFont(BuildContext context, double base) {
  final width = MediaQuery.sizeOf(context).width;
  final scale = (width / 390).clamp(0.88, 1.12);
  return base * scale;
}
