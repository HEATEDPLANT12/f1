import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:f1/models/openf1_driver.dart';
import 'package:f1/models/team.dart';
import 'package:f1/providers/drivers/openf1_driver_provider.dart';
import 'animated_driver_card.dart';
import 'driver_detail_tabs.dart';

class DriverSelectionScreen extends ConsumerStatefulWidget {
  final Team team;
  const DriverSelectionScreen({super.key, required this.team});

  @override
  ConsumerState<DriverSelectionScreen> createState() =>
      _DriverSelectionScreenState();
}

class _DriverSelectionScreenState extends ConsumerState<DriverSelectionScreen> {
  int? expandedDriverId;

  @override
  Widget build(BuildContext context) {
    // 1. Fetch OpenF1 drivers exclusively for cards & team filtering
    final driversAsync = ref.watch(openF1DriversProvider);

    final dummyDriver = OpenF1Driver(
      driverNumber: 81,
      fullName: "CHARLES LECLERC",
      teamName: widget.team.name,
      broadcastName: "C Leclerc",
      code: "16",
      countryCode: "MON",
      teamColour: "FF0000",
    );

    return driversAsync.when(
      loading: () => Skeletonizer(
        enabled: true,
        child: Column(
          children: List.generate(
            2,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: AnimatedDriverCard(
                driver: dummyDriver,
                accentColor: widget.team.accentColor,
                isHeaderMode: false,
                onTap: () {},
              ),
            ),
          ),
        ),
      ),
      error: (err, stack) => const Center(
        child: Text(
          "Error loading drivers",
          style: TextStyle(color: Colors.white54),
        ),
      ),
      data: (allDrivers) {
        // Filter drivers matching selected local team name safely with null checks
        final matchedDrivers = allDrivers.where((driver) {
          final String apiTeam = (driver.teamName ?? '').toLowerCase();
          final String localTeam = widget.team.name.toLowerCase();
          return apiTeam.contains(localTeam) || localTeam.contains(apiTeam);
        }).toList();

        if (matchedDrivers.isEmpty) {
          return const Center(
            child: Text(
              "No drivers found for this team",
              style: TextStyle(color: Colors.white54),
            ),
          );
        }

        return Column(
          children: matchedDrivers.map((driver) {
            final isSelected = expandedDriverId == driver.driverNumber;
            final isAnyExpanded = expandedDriverId != null;
            final isVisible = !isAnyExpanded || isSelected;

            if (!isVisible) {
              return const AnimatedSize(
                duration: Duration(milliseconds: 400),
                curve: Curves.fastOutSlowIn,
                alignment: Alignment.topCenter,
                child: SizedBox.shrink(),
              );
            }

            if (isSelected) {
              return Expanded(
                child: Column(
                  children: [
                    AnimatedDriverCard(
                      driver: driver,
                      accentColor: widget.team.accentColor,
                      isHeaderMode: true,
                      onTap: () {
                        setState(() {
                          expandedDriverId = null;
                        });
                      },
                    ),
                    Expanded(
                      child: DriverDetailTabs(
                        accentColor: widget.team.accentColor,
                        openF1Driver: driver,
                        driverNumber: driver.driverNumber.toString(),
                        driverCode: driver.code,
                      ),
                    ),
                  ],
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: AnimatedDriverCard(
                driver: driver,
                accentColor: widget.team.accentColor,
                isHeaderMode: false,
                onTap: () {
                  setState(() {
                    expandedDriverId = driver.driverNumber;
                  });
                },
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
