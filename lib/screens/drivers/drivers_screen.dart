import '../../providers/driver_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../models/team.dart';
import '../../models/driver.dart';
import '../../data/drivers.dart';

class DriversScreen extends ConsumerStatefulWidget {
  final Team team;

  const DriversScreen({super.key, required this.team});

  @override
  ConsumerState<DriversScreen> createState() => _DriversScreenState();
}

class _DriversScreenState extends ConsumerState<DriversScreen> {
  //String? selectedDriver;
  //Driver? activeDriver;
  Driver? comparisonDriver;

  bool showAnalysis = false;
  bool showComparison = false;

  void _showComparisonDriverSheet() {
    final activeDriver = ref.read(driverProvider);
    final teammate = getDriversForTeam(
      widget.team,
    ).firstWhere((d) => d.code != activeDriver!.code);

    final otherDrivers = allDrivers
        .where((d) => d.code != activeDriver!.code && d.code != teammate.code)
        .toList();

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF111111),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 24),

              const Text(
                "COMPARE WITH",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      const Text(
                        "TEAMMATE",
                        style: TextStyle(
                          color: Colors.white54,
                          letterSpacing: 2,
                        ),
                      ),

                      const SizedBox(height: 16),

                      _opponentTile(teammate),

                      const SizedBox(height: 32),

                      const Text(
                        "OTHER DRIVERS",
                        style: TextStyle(
                          color: Colors.white54,
                          letterSpacing: 2,
                        ),
                      ),

                      const SizedBox(height: 16),

                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),

                        itemCount: otherDrivers.length,

                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 1.5,
                            ),

                        itemBuilder: (context, index) {
                          return _opponentTile(otherDrivers[index]);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final activeDriver = ref.watch(driverProvider);
    return Scaffold(
      backgroundColor: Colors.black,

      body: SafeArea(
        child: Stack(
          children: [
            _driverSelectionView(),

            if (activeDriver != null) _focusedDriverView(),
          ],
        ),
      ),
    );
  }

  Widget _driverSelectionView() {
    final teamDrivers = getDriversForTeam(widget.team);
    return Padding(
      key: const ValueKey('selection'),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "DRIVERS",
            style: TextStyle(
              color: Colors.white,
              fontSize: 34,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.team.name,
                style: TextStyle(color: widget.team.tileColor, fontSize: 16),
              ),

              IconButton(
                onPressed: () {
                  context.go('/team_selection');
                },
                icon: const Icon(Icons.swap_horiz_rounded, color: Colors.white),
              ),
            ],
          ),

          const SizedBox(height: 40),

          //
          Expanded(
            child: ListView.separated(
              itemCount: teamDrivers.length,

              separatorBuilder: (_, _) => Container(
                height: 1,
                margin: const EdgeInsets.symmetric(vertical: 24),
                color: widget.team.tileColor.withValues(alpha: 0.35),
              ),

              itemBuilder: (context, index) {
                final driver = teamDrivers[index];

                return DriverHeroRow(
                  driver: driver,
                  color: widget.team.tileColor,
                  onTap: () {
                    ref.read(driverProvider.notifier).selectDriver(driver);
                    setState(() {
                      showAnalysis = true;
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _focusedDriverView() {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 600),

      curve: Curves.easeInOutCubic,

      top: 0,
      left: 0,
      right: 0,
      bottom: 0,

      child: Container(
        color: Colors.black,

        child: Column(
          children: [
            _stickyDriverHeader(),

            Expanded(child: _analysisList()),
          ],
        ),
      ),
    );
  }

  Widget _stickyDriverHeader() {
    final activeDriver = ref.watch(driverProvider);
    return GestureDetector(
      onTap: () {
        setState(() {
          showAnalysis = false;
        });

        Future.delayed(const Duration(milliseconds: 400), () {
          if (!mounted) return;

          ref.read(driverProvider.notifier).clearSelection();
        });
      },

      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),

        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,

              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: widget.team.tileColor, width: 2),
              ),

              child: ClipOval(
                child: Image.asset(activeDriver!.imagePath, fit: BoxFit.cover),
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    showComparison
                        ? "${activeDriver.lastName} VS ${comparisonDriver!.lastName}"
                        : "${activeDriver.firstName} ${activeDriver.lastName}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    "#${activeDriver.number}",
                    style: TextStyle(
                      color: widget.team.tileColor,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _opponentTile(Driver driver) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),

      onTap: () {
        Navigator.pop(context);

        setState(() {
          comparisonDriver = driver;
          showComparison = true;
        });
      },

      child: Container(
        padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),

          borderRadius: BorderRadius.circular(16),
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Text(
              driver.code,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              driver.lastName,
              style: const TextStyle(color: Colors.white54, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _analysisList() {
    return AnimatedOpacity(
      opacity: showAnalysis ? 1 : 0,

      duration: const Duration(milliseconds: 700),

      child: showComparison
          ? _comparisonView()
          : ListView(
              padding: const EdgeInsets.only(top: 24, bottom: 32),

              children: [
                _analysisTile("Position", "P2"),

                _analysisTile("Gap", "+1.824"),

                _analysisTile("Last Lap", "1.19.823"),

                _analysisTile("Best Lap", "1.19.511"),

                const SizedBox(height: 40),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),

                  child: ElevatedButton(
                    onPressed: () {
                      _showComparisonDriverSheet();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: widget.team.tileColor,
                      foregroundColor: Colors.black,
                    ),

                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 18),

                      child: Text("COMPARE DRIVER"),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _comparisonView() {
    return ListView(
      children: [
        const SizedBox(height: 20),

        ComparisonRow(label: "Last Lap", leftValue: "P2", rightValue: "P1"),

        const SizedBox(height: 32),
      ],
    );
  }

  Widget _analysisTile(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 22),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.white54, fontSize: 15),
          ),

          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class DriverHeroRow extends StatelessWidget {
  final Driver driver;
  final Color color;
  final VoidCallback onTap;

  const DriverHeroRow({
    super.key,
    required this.driver,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,

      child: SizedBox(
        height: 240,

        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Hero(
                tag: driver.code,
                child: Image.asset(driver.imagePath, fit: BoxFit.contain),
              ),
            ),

            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.only(right: 12),

                child: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    Text(
                      driver.number,
                      style: TextStyle(
                        color: color.withValues(alpha: 0.3),
                        fontSize: 133,
                        height: 1,
                        fontWeight: FontWeight.w900,
                      ),
                    ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          driver.firstName,
                          style: const TextStyle(
                            color: Colors.white60,
                            fontSize: 16,
                            letterSpacing: 2,
                          ),
                        ),

                        Text(
                          driver.lastName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 26.1,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ComparisonRow extends StatelessWidget {
  final String label;
  final String leftValue;
  final String rightValue;

  const ComparisonRow({
    super.key,
    required this.label,
    required this.leftValue,
    required this.rightValue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),

      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 13,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: Text(
                  leftValue,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Expanded(
                child: Text(
                  rightValue,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          const Divider(color: Colors.white12, height: 1),
        ],
      ),
    );
  }
}
