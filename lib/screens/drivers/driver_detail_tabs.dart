import 'package:flutter/material.dart';
import 'package:f1/models/openf1_driver.dart';
import 'overview_tab.dart';
import 'season_tab.dart';

class DriverDetailTabs extends StatelessWidget {
  final OpenF1Driver openF1Driver;
  final String driverNumber;
  final String driverCode;
  final Color accentColor;

  const DriverDetailTabs({
    super.key,
    required this.openF1Driver,
    required this.driverNumber,
    required this.driverCode,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(
            indicatorColor: Colors.redAccent,
            indicatorWeight: 3,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white38,
            dividerColor: Colors.white10,
            labelStyle: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 13,
              letterSpacing: 1.2,
            ),
            tabs: [
              Tab(text: "OVERVIEW"),
              Tab(text: "SEASON"),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                OverviewTab(driverNumber: driverNumber, driverCode: driverCode),
                SeasonTab(driverId: driverNumber, accentColor: accentColor),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/*class OverviewTab extends StatelessWidget {
  final JolpicaDriver driver;

  const OverviewTab({super.key, required this.driver});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      physics: const BouncingScrollPhysics(),
      children: [
        _StatRow(label: "TEAM", value: driver.constructorName.toUpperCase()),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _StatCardWithFlag(
                label: "NATIONALITY",
                value: driver.nationality,
                isDemonym: true,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _StatCard(
                label: "CODE",
                value: driver.code.isNotEmpty ? driver.code : "N/A",
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _StatCard(label: "RANK", value: "P${driver.position}"),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _StatCard(
                label: "POINTS",
                value: "${driver.points.toInt()} PTS",
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _StatRow(
          label: "DATE OF BIRTH",
          value: driver.dateOfBirth.isNotEmpty ? driver.dateOfBirth : "N/A",
        ),
      ],
    );
  }
}

class _StatRow extends StatelessWidget {
  final String label;
  final String value;

  const _StatRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;

  const _StatCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 16,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _StatCardWithFlag extends StatelessWidget {
  final String label;
  final String value;
  final bool isDemonym;

  const _StatCardWithFlag({
    required this.label,
    required this.value,
    required this.isDemonym,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              FlagWidget(query: value, isDemonym: isDemonym, fontSize: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 15,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}*/
