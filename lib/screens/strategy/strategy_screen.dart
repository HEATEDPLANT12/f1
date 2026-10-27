import 'package:f1/providers/standings/standings_provider.dart';
import 'package:f1/providers/strategy/strategy_provider.dart';
//import 'package:f1/providers/weather_provider.dart';
import 'package:flutter/material.dart';
import '../../models/team.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StrategyScreen extends ConsumerStatefulWidget {
  final Team team;

  const StrategyScreen({super.key, required this.team});

  @override
  ConsumerState<StrategyScreen> createState() => _StrategyScreenState();
}

class _StrategyScreenState extends ConsumerState<StrategyScreen> {
  //double selectedPitLap = 30;

  @override
  Widget build(BuildContext context) {
    //final strategy = ref.watch(strategyProvider);
    final standings = ref.watch(standingsProvider);
    //final weather = ref.watch(weatherProvider);
    return Scaffold(
      backgroundColor: Colors.black,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              const Text(
                "STRATEGY",
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

              const SizedBox(height: 6),

              const Text(
                "Lap 24 / 57",
                style: TextStyle(color: Colors.white54),
              ),

              const SizedBox(height: 40),

              _sectionTitle("CURRENT PLAN"),

              const SizedBox(height: 20),

              _strategyRow("NOR", "MEDIUM → HARD"),

              const SizedBox(height: 16),

              _strategyRow("PIA", "HARD → MEDIUM"),

              const SizedBox(height: 40),

              _sectionTitle("PIT WINDOWS"),

              const SizedBox(height: 20),

              _strategyRow("NOR", "LAP 30"),

              const SizedBox(height: 16),

              _strategyRow("PIA", "LAP 36"),

              const SizedBox(height: 40),

              _sectionTitle("TYRE LIFE"),

              const SizedBox(height: 20),

              _strategyRow("MEDIUM", "18 / 24 LAPS"),

              const SizedBox(height: 16),

              _strategyRow("HARD", "12 / 35 LAPS"),

              const SizedBox(height: 40),

              _sectionTitle("WEATHER RISK"),

              const SizedBox(height: 20),

              standings.when(
                loading: () => const Center(child: CircularProgressIndicator()),

                error: (e, _) => const Text("Failed"),

                data: (drivers) {
                  /*return Row(
                    children: [
                      Text(
                        "${weatherData.rainChance}%",
                        style: TextStyle(
                          color: widget.team.tileColor,
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(width: 16),

                      Text(
                        weatherData.condition,
                        style: TextStyle(color: Colors.white70, fontSize: 36),
                      ),
                    ],
                  );*/

                  return Text(
                    drivers.first.firstName,
                    style: const TextStyle(color: Colors.white, fontSize: 24),
                  );
                },
              ),

              const SizedBox(height: 40),

              _sectionTitle("AI RECOMMENDATION"),

              const SizedBox(height: 20),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  color: const Color(0xFF151515),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: widget.team.tileColor.withValues(alpha: 0.25),
                  ),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      "PIT NORRIS ON LAP 30",
                      style: TextStyle(
                        color: widget.team.tileColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      "Current tyre degradation suggests "
                      "an optimal undercut opportunity "
                      "between laps 29 and 31.",
                      style: TextStyle(color: Colors.white70, height: 1.5),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,

                child: ElevatedButton(
                  onPressed: _showStrategySimulator,

                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.team.tileColor,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                  ),

                  child: const Text(
                    "RUN SIMULATION",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 40),
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

  Widget _strategyRow(String left, String right) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [
        Text(
          left,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        Text(
          right,
          style: const TextStyle(color: Colors.white70, fontSize: 16),
        ),
      ],
    );
  }

  Widget _simRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Text(title, style: const TextStyle(color: Colors.white54)),

          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void _showStrategySimulator() {
    //final strategy = ref.read(strategyProvider);

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF111111),
      isScrollControlled: true,

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),

      builder: (context) {
        return Consumer(
          builder: (context, ref, child) {
            final strategy = ref.watch(strategyProvider);
            final notifier = ref.read(strategyProvider.notifier);
            return Padding(
              padding: const EdgeInsets.all(24),

              child: Column(
                mainAxisSize: MainAxisSize.min,

                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Center(
                    child: Container(
                      width: 50,
                      height: 4,

                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    "STRATEGY SIMULATOR",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 30),

                  Text(
                    "Pit Lap ${strategy.pitLap.round()}",
                    style: TextStyle(
                      color: widget.team.tileColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Slider(
                    value: strategy.pitLap.toDouble(),
                    min: 24,
                    max: 40,
                    activeColor: widget.team.tileColor,

                    onChanged: (value) {
                      ref
                          .read(strategyProvider.notifier)
                          .changePitLap(value.round());
                    },
                  ),

                  const SizedBox(height: 20),

                  _simRow("Current Tyre", "MEDIUM"),

                  _simRow("Predicted Finish", notifier.predictedPosition),

                  _simRow("Tyre Wear", notifier.predictedWear),

                  _simRow("Weather Risk", "15%"),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,

                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: widget.team.tileColor,
                        foregroundColor: Colors.black,
                      ),

                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),

                        child: Text("APPLY STRATEGY"),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
