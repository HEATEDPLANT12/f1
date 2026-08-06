import 'package:f1/providers/replay_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/team.dart';

class ReplayScreen extends ConsumerStatefulWidget {
  final Team team;

  const ReplayScreen({super.key, required this.team});

  @override
  ConsumerState<ReplayScreen> createState() => _ReplayScreenState();
}

class _ReplayScreenState extends ConsumerState<ReplayScreen> {
  //int currentLap = 24;

  //final int totalLaps = 57;

  @override
  Widget build(BuildContext context) {
    final replay = ref.watch(replayProvider);
    return Scaffold(
      backgroundColor: Colors.black,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              const Text(
                "REPLAY",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                widget.team.name,
                style: TextStyle(color: widget.team.tileColor, fontSize: 16),
              ),

              const SizedBox(height: 32),

              const Text(
                "Australian Grand Prix",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                "Lap ${replay.currentLap} / ${ReplayNotifier.totalLaps}",
                style: const TextStyle(color: Colors.white54),
              ),

              const SizedBox(height: 40),

              _sectionTitle("TEAM STATUS"),

              const SizedBox(height: 20),

              _statusRow("NOR", "P2"),

              const SizedBox(height: 16),

              _statusRow("PIA", "P4"),

              const SizedBox(height: 40),

              _sectionTitle("TIMELINE"),

              const SizedBox(height: 20),

              Expanded(child: ListView(children: _timelineEvents(replay))),

              const SizedBox(height: 20),

              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 16,
                ),

                decoration: BoxDecoration(
                  color: const Color(0xFF151515),

                  borderRadius: BorderRadius.circular(20),
                ),

                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        ref.read(replayProvider.notifier).previousLap();
                      },

                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),

                    Expanded(
                      child: Center(
                        child: Text(
                          "LAP ${replay.currentLap}",
                          style: TextStyle(
                            color: widget.team.tileColor,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    IconButton(
                      onPressed: () {
                        ref.read(replayProvider.notifier).nextLap();
                      },

                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white54,
            fontSize: 13,
            letterSpacing: 2,
          ),
        ),

        const SizedBox(height: 8),

        Container(width: 80, height: 2, color: widget.team.tileColor),
      ],
    );
  }

  Widget _statusRow(String driver, String position) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [
        Text(
          driver,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        Text(
          position,
          style: const TextStyle(color: Colors.white70, fontSize: 16),
        ),
      ],
    );
  }

  List<Widget> _timelineEvents(ReplayState replay) {
    final events = [
      "DRS Enabled",
      "Fastest Lap - Norris",
      "Gap To Leader +1.824",
      "Pit Window Open",
      "Tyre Degradation Increasing",
    ];

    return List.generate(events.length, (index) {
      final lap = replay.currentLap - events.length + index + 1;

      return Container(
        margin: const EdgeInsets.only(bottom: 16),

        padding: const EdgeInsets.all(18),

        decoration: BoxDecoration(
          color: const Color(0xFF151515),

          borderRadius: BorderRadius.circular(18),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              "Lap $lap",
              style: TextStyle(
                color: widget.team.tileColor,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(events[index], style: const TextStyle(color: Colors.white)),
          ],
        ),
      );
    });
  }
}
