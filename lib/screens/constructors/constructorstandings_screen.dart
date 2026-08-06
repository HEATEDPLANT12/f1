import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/constructor_provider.dart';

class ConstructorstandingsScreen extends ConsumerWidget {
  const ConstructorstandingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final standings = ref.watch(constructorStandingsProvider);

    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        title: const Text("Constructor Standings"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),

      body: standings.when(
        loading: () => const Center(child: CircularProgressIndicator()),

        error: (error, stackTrace) => Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 60),

                const SizedBox(height: 20),

                Text(
                  error.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),

                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () {
                    ref.invalidate(constructorStandingsProvider);
                  },
                  child: const Text("Retry"),
                ),
              ],
            ),
          ),
        ),

        data: (teams) {
          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(constructorStandingsProvider);
            },

            child: ListView.separated(
              padding: const EdgeInsets.all(16),

              itemCount: teams.length,

              separatorBuilder: (_, _) => const SizedBox(height: 10),

              itemBuilder: (context, index) {
                final team = teams[index];

                return Container(
                  padding: const EdgeInsets.all(16),

                  decoration: BoxDecoration(
                    color: const Color(0xFF151515),
                    borderRadius: BorderRadius.circular(18),
                  ),

                  child: Row(
                    children: [
                      SizedBox(
                        width: 40,

                        child: Text(
                          team.position.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(width: 15),

                      /*CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.redAccent,
                        child: Text(
                          team.code,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(width: 16),*/
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text(
                              team.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),

                            const SizedBox(height: 4),

                            /*Text(
                              driver.team,
                              style: const TextStyle(color: Colors.white70),
                            ),*/
                            Text(
                              team.nationality,
                              style: const TextStyle(
                                color: Colors.white38,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Column(
                        children: [
                          Text(
                            "${team.points}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),

                          const Text(
                            "PTS",
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
