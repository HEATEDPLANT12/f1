import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:f1/providers/jolpica_providers.dart';

class SeasonTab extends ConsumerStatefulWidget {
  final String driverId;
  final Color accentColor;

  const SeasonTab({
    super.key,
    required this.driverId,
    required this.accentColor,
  });

  @override
  ConsumerState<SeasonTab> createState() => _SeasonTabState();
}

class _SeasonTabState extends ConsumerState<SeasonTab>
    with AutomaticKeepAliveClientMixin {
  int? expandedIndex;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final resultsAsync = ref.watch(
      driverSeasonResultsProvider(widget.driverId),
    );

    return resultsAsync.when(
      loading: () =>
          Center(child: CircularProgressIndicator(color: widget.accentColor)),
      error: (err, stack) => const Center(
        child: Text(
          "Failed to load season data",
          style: TextStyle(color: Colors.white54),
        ),
      ),
      data: (results) {
        if (results.isEmpty) {
          return const Center(
            child: Text(
              "No race results available for this season.",
              style: TextStyle(color: Colors.white54),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16.0),
          physics: const BouncingScrollPhysics(),
          itemCount: results.length,
          itemBuilder: (context, index) {
            final race = results[index];
            final isExpanded = expandedIndex == index;

            return Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    expandedIndex = isExpanded ? null : index;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF14161D),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isExpanded ? widget.accentColor : Colors.white10,
                      width: isExpanded ? 1.5 : 1.0,
                    ),
                  ),
                  child: Column(
                    children: [
                      // --- CLOSED CARD HEADER ---
                      Row(
                        children: [
                          /*FlagWidget(
                            query: race.country,
                            isDemonym: false,
                            fontSize: 20,
                          ),
                          const SizedBox(width: 10),*/
                          Expanded(
                            child: Text(
                              race.raceName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: widget.accentColor.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: widget.accentColor.withValues(
                                  alpha: 0.4,
                                ),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              "P${race.position}",
                              style: TextStyle(
                                color: widget.accentColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          AnimatedRotation(
                            turns: isExpanded ? 0.25 : 0.0,
                            duration: const Duration(milliseconds: 200),
                            child: const Icon(
                              Icons.chevron_right,
                              color: Colors.white38,
                              size: 20,
                            ),
                          ),
                        ],
                      ),

                      // --- EXPANDED DETAILS GRID ---
                      AnimatedSize(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.fastOutSlowIn,
                        child: isExpanded
                            ? Padding(
                                padding: const EdgeInsets.only(top: 16.0),
                                child: Column(
                                  children: [
                                    const Divider(
                                      color: Colors.white10,
                                      height: 1,
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        _buildStatBlock(
                                          "GRID",
                                          "P${race.grid}",
                                          Colors.white,
                                        ),
                                        _buildStatBlock(
                                          "POINTS",
                                          "+${race.points}",
                                          widget.accentColor,
                                          isHero: true,
                                        ),
                                        _buildStatBlock(
                                          "LAPS",
                                          race.laps.toString(),
                                          Colors.white,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        _buildStatBlock(
                                          "FASTEST LAP",
                                          race.fastestLapTime ?? "N/A",
                                          Colors.white,
                                        ),
                                        _buildStatBlock(
                                          "STATUS",
                                          race.status,
                                          _getStatusColor(race.status),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildStatBlock(
    String label,
    String value,
    Color valueColor, {
    bool isHero = false,
  }) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white54,
            fontSize: 10,
            letterSpacing: 1.1,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: valueColor,
            fontSize: isHero ? 20 : 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    final lower = status.toLowerCase();
    if (lower == 'finished') return Colors.greenAccent;
    if (lower.contains('lap')) return Colors.white;
    return Colors.redAccent;
  }
}
