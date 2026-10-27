/*import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../models/driver_career_stats.dart';
import '../models/racing_hub_driver.dart';
import '../services/racing_hub_service.dart';

/// Standalone HTTP Client Provider
final racingHubClientProvider = Provider<http.Client>((ref) {
  final client = http.Client();
  ref.onDispose(() => client.close());
  return client;
});

/// RacingHub Service Provider
final racingHubServiceProvider = Provider<RacingHubService>((ref) {
  return RacingHubService(client: ref.watch(racingHubClientProvider));
});

/// 1. Caches the full RacingHub driver list once per session
final racingHubDriversProvider = FutureProvider<List<RacingHubDriver>>((ref) {
  return ref.watch(racingHubServiceProvider).fetchDrivers();
});

/// 2. Resolves an OpenF1 permanent number or code to a native RacingHubDriver
final racingHubDriverProvider = FutureProvider.autoDispose
    .family<RacingHubDriver, String>((ref, openF1Identifier) async {
      final rhDrivers = await ref.watch(racingHubDriversProvider.future);
      final query = openF1Identifier.trim().toUpperCase();

      return rhDrivers.firstWhere(
        (d) =>
            d.permanentNumber.toString() == query ||
            (d.code.isNotEmpty && d.code == query),
        orElse: () => throw Exception(
          'Driver not found in RacingHub directory: $openF1Identifier',
        ),
      );
    });

/// 3. Fetches career statistics using the native RacingHub driver ID directly
final driverCareerStatsProvider = FutureProvider.autoDispose
    .family<DriverCareerStats, String>((ref, racingHubId) async {
      final service = ref.watch(racingHubServiceProvider);
      return service.fetchDriverStats(racingHubId);
    });*/

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../models/driver_career_stats.dart';
import '../models/racing_hub_driver.dart';
import '../services/racing_hub_service.dart';

final racingHubClientProvider = Provider<http.Client>((ref) {
  final client = http.Client();
  ref.onDispose(() => client.close());
  return client;
});

final racingHubServiceProvider = Provider<RacingHubService>((ref) {
  return RacingHubService(client: ref.watch(racingHubClientProvider));
});

/// Caches current season grid (~20 drivers) once per session
final racingHubDriversProvider = FutureProvider<List<RacingHubDriver>>((ref) {
  return ref.watch(racingHubServiceProvider).fetchCurrentSeasonDrivers();
});

/// Resolves OpenF1 permanent number or code to native RacingHub driver
/*final racingHubDriverProvider = FutureProvider.autoDispose
    .family<RacingHubDriver, String>((ref, openF1Identifier) async {
      final rhDrivers = await ref.watch(racingHubDriversProvider.future);
      final query = openF1Identifier.trim().toUpperCase();

      return rhDrivers.firstWhere(
        (d) =>
            d.permanentNumber.toString() == query ||
            (d.abbr.isNotEmpty && d.abbr == query),
        orElse: () => throw Exception(
          'Driver $openF1Identifier not found in current season grid',
        ),
      );
    });*/

final racingHubDriverProvider = FutureProvider.autoDispose
    .family<RacingHubDriver, ({String number, String code})>((
      ref,
      query,
    ) async {
      final rhDrivers = await ref.watch(racingHubDriversProvider.future);
      //final query = openF1Identifier.trim().toUpperCase();
      final targetNumber = query.number.trim();
      final targetCode = query.code.trim().toUpperCase();

      return rhDrivers.firstWhere(
        (d) =>
            d.permanentNumber.toString() == targetNumber ||
            (d.abbr.isNotEmpty && d.abbr.toUpperCase() == targetCode),
        orElse: () =>
            throw Exception('Driver  not found in current season grid'),
      );
    });

/// Fetches career stats via native RacingHub ID
final driverCareerStatsProvider = FutureProvider.autoDispose
    .family<DriverCareerStats, String>((ref, racingHubId) async {
      return ref.watch(racingHubServiceProvider).fetchDriverStats(racingHubId);
    });
