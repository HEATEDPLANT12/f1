import '../models/driver_status.dart';
import '../services/openf1_driver_service.dart';
import '../services/position_service.dart';
import '../services/interval_service.dart';
import '../services/stint_service.dart';

class DriverRepository {
  final OpenF1DriverService driverService;
  final PositionService positionService;
  final IntervalService intervalService;
  final StintService stintService;

  const DriverRepository({
    required this.driverService,
    required this.intervalService,
    required this.positionService,
    required this.stintService,
  });

  Future<List<DriverStatus>> fetchDriverStatus() async {
    final drivers = await driverService.fetchDrivers();
    final positions = await positionService.fetchPositions();
    final intervals = await intervalService.fetchIntervals();
    final stints = await stintService.fetchStints();

    return drivers.map((driver) {
      return DriverStatus(
        driver: driver,

        position: positions
            .where((p) => p.drivernumber == driver.driverNumber)
            .firstOrNull,

        interval: intervals
            .where((i) => i.driverNumber == driver.driverNumber)
            .firstOrNull,

        stint: stints
            .where((s) => s.driverNumber == driver.driverNumber)
            .firstOrNull,
      );
    }).toList();
  }
}
