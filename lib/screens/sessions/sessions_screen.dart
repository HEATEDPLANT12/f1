import 'package:f1/providers/race/stint_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/standings/constructor_provider.dart';

class SessionsScreen extends ConsumerWidget {
  const SessionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final drivers = ref.watch(stintProvider);

    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        title: const Text("Drivers"),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        foregroundColor: const Color.fromARGB(255, 254, 166, 2),
      ),

      body: drivers.when(
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

        data: (drivers) {
          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(constructorStandingsProvider);
            },

            child: ListView.separated(
              padding: const EdgeInsets.all(16),

              itemCount: drivers.length,

              separatorBuilder: (_, _) => const SizedBox(height: 10),

              itemBuilder: (context, index) {
                final driver = drivers[index];

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
                          driver.driverNumber.toString(),
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
                              //driver.gapToLeader?.toStringAsFixed(3) ?? "--",
                              driver.compound ?? "--",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),

                            const SizedBox(height: 4),

                            Text(
                              driver.lapStart.toString(),
                              style: const TextStyle(color: Colors.white70),
                            ),
                            Text(
                              driver.lapEnd.toString(),
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
                            //driver.interval?.toStringAsFixed(3) ?? "--",
                            driver.tyreAgeAtStart.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),

                          /*Text(
                            driver.countryCode,
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 11,
                            ),
                          ),*/
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
