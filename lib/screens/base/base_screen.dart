import 'package:f1/models/team.dart';
import 'package:f1/screens/dashboard/dashboard_sections/dashboard_header.dart';
import 'package:flutter/material.dart';

class BaseScreen extends StatelessWidget {
  final String title;
  final Widget child;
  final Team team;
  //final bool showBackButton;

  const BaseScreen({
    required this.child,
    //required this.showBackButton,
    required this.team,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: team.accentColor,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
              child: DashboardHeader(team: team),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 2),
              child: Text(title),
            ),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}
