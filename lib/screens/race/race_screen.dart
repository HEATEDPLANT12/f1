import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/race/race_provider.dart';

class RaceScreen extends ConsumerWidget {
  const RaceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final standings = ref.watch(raceProvider);

    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        title: const Text("Race Calendar"),
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
                    ref.invalidate(raceProvider);
                  },
                  child: const Text("Retry"),
                ),
              ],
            ),
          ),
        ),

        data: (races) {
          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(raceProvider);
            },

            child: ListView.separated(
              padding: const EdgeInsets.all(16),

              itemCount: races.length,

              separatorBuilder: (_, _) => const SizedBox(height: 10),

              itemBuilder: (context, index) {
                final race = races[index];

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
                          race.raceName.toString(),
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
                              race.circuitName,
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
                              race.locality,
                              style: const TextStyle(
                                color: Colors.white54,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              race.country,
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
                            race.date,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),

                          Text(
                            race.time,
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
