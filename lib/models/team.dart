import 'package:flutter/material.dart';

class Team {
  final String id;
  final String name;
  final String logoPath;
  final String iconPath;
  final Color accentColor;
  final Color tileColor;
  final List<String> driverCodes;

  const Team({
    required this.id,
    required this.name,
    required this.logoPath,
    required this.iconPath,
    required this.accentColor,
    required this.tileColor,
    required this.driverCodes,
  });
}
