import 'package:f1/models/team.dart';
import 'package:f1/providers/app/team_provider.dart';
import 'package:f1/screens/dashboard/dashboard_sections/dashboard_header.dart';
//import 'package:f1/screens/standings/standings_screen.dart';
import 'package:f1/screens/standings/standings_tabs.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//import '../../models/team.dart';
import '../dashboard/dashboard_screen.dart';
import '../drivers/driverselection_screen.dart';
import '../engineer/engineer_screen.dart';
import '../replay/replay_screen.dart';
//import '../../providers/team_provider.dart';

class MainShell extends ConsumerStatefulWidget {
  const MainShell({super.key});

  @override
  ConsumerState<MainShell> createState() => _MainShellState();
}

class _MainShellState extends ConsumerState<MainShell> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final team = ref.watch(teamProvider);

    final pages = [
      DashboardScreen(team: team),
      DriverSelectionScreen(team: team),
      StandingsSection(team: team),
      EngineerScreen(team: team),
      ReplayScreen(team: team),
    ];

    final screenTitles = [
      "DASHBOARD",
      "DRIVERS",
      "STANDINGS",
      "ENGINEER",
      "REPLAY",
    ];

    return Scaffold(
      backgroundColor: team.accentColor,
      //body: IndexedStack(index: currentIndex, children: pages),
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
              child: Text(
                screenTitles[currentIndex],
                textAlign: TextAlign.start,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),

            //const SizedBox(height: 8),
            Expanded(
              child: IndexedStack(index: currentIndex, children: pages),
            ),
          ],
        ),
      ),

      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          height: 72,
          decoration: BoxDecoration(
            color: Colors.black,
            border: Border(
              top: BorderSide(color: team.tileColor.withValues(alpha: 0.12)),
            ),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final tabWidth = constraints.maxWidth / 5;

              return Stack(
                children: [
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOutCubic,

                    left: (currentIndex * tabWidth) + (tabWidth / 2) - 16,
                    top: 6,
                    child: Container(
                      width: 32,
                      height: 3,
                      decoration: BoxDecoration(
                        color: team.tileColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),

                  Row(
                    children: [
                      _navItem(
                        team: team,
                        icon: Icons.home_rounded,
                        label: "Dashboard",
                        index: 0,
                      ),

                      _navItem(
                        team: team,
                        icon: Icons.people_alt_rounded,
                        label: "Drivers",
                        index: 1,
                      ),

                      _navItem(
                        team: team,
                        icon: Icons.analytics_rounded,
                        label: "Strategy",
                        index: 2,
                      ),

                      _navItem(
                        team: team,
                        icon: Icons.smart_toy_rounded,
                        label: "Engineer",
                        index: 3,
                      ),

                      _navItem(
                        team: team,
                        icon: Icons.play_circle_fill_rounded,
                        label: "Replay",
                        index: 4,
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _navItem({
    required Team team,
    required IconData icon,
    required String label,
    required int index,
  }) {
    final selected = currentIndex == index;
    //final team = ref.watch(selectedTeamProvider);
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            currentIndex = index;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(vertical: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: selected ? team.tileColor : Colors.white54,
                size: selected ? 26 : 22,
              ),

              const SizedBox(height: 4),

              AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),

                child: selected
                    ? Text(
                        label,
                        key: ValueKey(index),
                        style: TextStyle(
                          color: team.tileColor,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    : const SizedBox(height: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
