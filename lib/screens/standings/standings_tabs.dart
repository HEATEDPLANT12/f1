import 'package:f1/data/teams.dart';
import 'package:f1/models/team.dart';
import 'package:f1/providers/app/team_provider.dart';
import 'package:f1/providers/standings/constructor_provider.dart';
import 'package:f1/providers/standings/standings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

class StandingsSection extends ConsumerWidget {
  final Team team;

  //const StandingsSection({Key? key}) : super(key: key);
  const StandingsSection({super.key, required this.team});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final standings = ref.watch(standingsProvider);
    final teamstandings = ref.watch(constructorStandingsProvider);
    final color = ref.watch(teamProvider).tileColor;
    return
    //color: const Color(0xFFFF7A00), // App background orange
    DefaultTabController(
      length: 2,
      child: Column(
        children: [
          // Tabs
          TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            dividerColor: Colors.transparent,
            overlayColor: WidgetStatePropertyAll(Colors.transparent),
            indicatorColor: Colors.white,
            indicatorWeight: 3,
            labelColor: Colors.white,
            unselectedLabelColor: Color(0xFF4A2500), // Darker orange/brown
            labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            tabs: [
              Tab(text: "DRIVERS"),
              Tab(text: "CONSTRUCTORS"),
            ],
          ),

          const SizedBox(height: 12),

          // Fixed Header Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 9),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A), // Dark header background
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      'POS',
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: Builder(
                      builder: (context) {
                        final tabController = DefaultTabController.of(context);
                        return AnimatedBuilder(
                          animation: tabController,
                          builder: (context, child) {
                            return Text(
                              tabController.index == 0 ? 'DRIVERS' : 'TEAMS',
                              style: TextStyle(
                                color: color,
                                fontWeight: FontWeight.w600,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),

                  Expanded(
                    flex: 1,
                    child: Text(
                      'PTS',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Scrollable List Area
          Expanded(
            child: TabBarView(
              children: [
                // Drivers List
                /*ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [_buildEmptyContainer(), _buildEmptyContainer()],
                ),*/
                standings.when(
                  loading: () {
                    return Skeletonizer(
                      enabled: true,
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: 8,
                        itemBuilder: (context, index) {
                          return _driverRow(
                            position: 22,
                            firstName: 'Andrea',
                            lastName: 'Kimi Antonelli',
                            permanentNumber: '99',
                            points: 888,
                            teamColor: Colors.grey,
                            color: Colors.grey,
                          );
                        },
                      ),
                    );
                  },
                  error: (error, stackTrace) => Text('Error'),
                  data: (drivers) {
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: drivers.length,
                      itemBuilder: (context, index) {
                        final driver = drivers[index];
                        //return _buildEmptyContainer();

                        final matchedTeam = teams
                            .where(
                              (t) => driver.team.toLowerCase().contains(
                                t.name.toLowerCase(),
                              ),
                            )
                            .firstOrNull;

                        return _driverRow(
                          position: driver.position,
                          firstName: driver.firstName,
                          lastName: driver.lastName,
                          permanentNumber: driver.permanentNumber,
                          points: driver.points,
                          teamColor: matchedTeam?.tileColor ?? Colors.grey,
                          color: color,
                        );
                      },
                    );
                  },
                ),

                // Constructors List (Placeholder for now)
                /*ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [_buildEmptyContainer(), _buildEmptyContainer()],
                ),*/
                teamstandings.when(
                  loading: () {
                    return Skeletonizer(
                      enabled: true,
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: 8,
                        itemBuilder: (context, index) {
                          return _constructorRow(
                            teamColor: Colors.grey,
                            teamName: 'Kimi Andrea Antonelli',
                            points: 888,
                            position: 22,
                            color: Colors.grey,
                          );
                        },
                      ),
                    );
                  },
                  error: (error, stackTrace) => Text('Error'),
                  data: (apiTeams) {
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: apiTeams.length,
                      itemBuilder: (context, index) {
                        //return _buildEmptyContainer();
                        final apiTeam = apiTeams[index];

                        final matchedTeam = teams
                            .where(
                              (t) => apiTeam.name.toLowerCase().contains(
                                t.name.toLowerCase(),
                              ),
                            )
                            .firstOrNull;

                        return _constructorRow(
                          teamColor: matchedTeam?.tileColor ?? Colors.grey,
                          teamName: apiTeam.name,
                          points: apiTeam.points,
                          position: apiTeam.position,
                          color: color,
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper method for the requested empty containers
  /*Widget _buildEmptyContainer() {
    return Container(
      height: 80,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black54, width: 2),
      ),
    );
  }*/

  Widget _driverRow({
    required int position,
    required String firstName,
    required String lastName,
    required String permanentNumber,
    required int points,
    required Color teamColor,
    required Color color,
  }) {
    return Container(
      height: 66,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 13),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '$position',
                style: TextStyle(
                  color: color,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          Expanded(
            flex: 8,
            //child: Row(
            //children: [
            /*Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.person,
                      color: Colors.white70,
                    ),
                  ),
                ),*/
            //const SizedBox(width: 12),

            //Expanded(
            /*child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$firstName $lastName',
                  style: const TextStyle(color: Colors.white, fontSize: 17),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '#$permanentNumber',
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),*/
            //),
            //],
            //),
            child: Row(
              children: [
                Container(width: 4, height: 38, color: teamColor),
                const SizedBox(width: 7),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$firstName $lastName',
                      style: const TextStyle(color: Colors.white, fontSize: 17),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '#$permanentNumber',
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),

          //const Expanded(flex: 3, child: SizedBox.shrink()),
          Expanded(
            flex: 2,
            child: Text(
              '$points',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: color,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _constructorRow({
  required Color teamColor,
  required int position,
  required String teamName,
  required int points,
  required Color color,
}) {
  return Container(
    height: 66,
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.symmetric(horizontal: 13),
    decoration: BoxDecoration(
      color: const Color(0xFF1E1E1E),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.black, width: 2),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '$position',
              style: TextStyle(
                color: color,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 8,
          child: Row(
            children: [
              Container(width: 4, height: 38, color: teamColor),
              const SizedBox(width: 7),
              Text(
                teamName,
                style: const TextStyle(color: Colors.white, fontSize: 17),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            '$points',
            textAlign: TextAlign.right,
            style: TextStyle(
              color: color,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}
