import 'package:f1/models/team.dart';
import 'package:f1/screens/base/base_screen.dart';
import 'package:flutter/material.dart';

class WeatherScreen extends StatelessWidget {
  final Team team;
  const WeatherScreen({super.key, required this.team});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(title: "WEATHER", team: team, child: Text("Yo!"));
  }
}
