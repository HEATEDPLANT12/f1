import 'package:f1/models/driver_status.dart';
import 'package:f1/models/position.dart';
import 'package:f1/providers/race/interval_provider.dart';
import 'package:f1/providers/race/stint_provider.dart';

import 'openf1_driver_provider.dart';
import '../race/position_provider.dart';
//import '../../repositories/driver_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final driverStatusProvider = FutureProvider<List<DriverStatus>>((ref) async {
  final drivers = await ref.watch(openF1DriversProvider.future);
  final positions = await ref.watch(positionProvider.future);
  final intervals = await ref.watch(intervalProvider.future);
  final stints = await ref.watch(stintProvider.future);

  return drivers.map((driver) {
    final position = positions
        .where((p) => p.drivernumber == driver.driverNumber)
        .fold<Position?>(null, (latest, current) {
          if (latest == null) return current;
          return current.date.compareTo(latest.date) > 0 ? current : latest;
        });

    final interval = intervals
        .where((i) => i.driverNumber == driver.driverNumber)
        .lastOrNull;

    final stint = stints
        .where((s) => s.driverNumber == driver.driverNumber)
        .lastOrNull;

    return DriverStatus(
      driver: driver,
      position: position,
      interval: interval,
      stint: stint,
    );
  }).toList();
});
