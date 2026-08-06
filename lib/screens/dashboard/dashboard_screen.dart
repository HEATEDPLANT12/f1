import 'package:flutter/material.dart';

import 'widgets/current_session_card.dart';
import 'widgets/dashboard_header.dart';
import 'widgets/next_session_card.dart';
import 'widgets/session_info_card.dart';
import 'widgets/strategy_card.dart';
import 'widgets/team_status_card.dart';
import 'widgets/weather_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DashboardHeader(),

              SizedBox(height: 24),

              //CurrentSessionCard(),
              SizedBox(height: 32),

              // TeamStatusCard(),
              SizedBox(height: 32),

              //SessionInfoCard(),
              SizedBox(height: 32),

              //WeatherCard(),
              SizedBox(height: 32),

              // StrategyCard(),
              SizedBox(height: 32),

              //NextSessionCard(),

              //SizedBox(height: 40,),
            ],
          ),
        ),
      ),
    );
  }
}
