import 'package:f1/models/driver_status.dart';
import 'package:f1/providers/interval_provider.dart';
import 'package:f1/providers/stint_provider.dart';

import 'openf1_driver_provider.dart';
import 'position_provider.dart';
import '../repositories/driver_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final driverRepositoryProvider = Provider<DriverRepository>((ref) {
  return DriverRepository(
    driverService: ref.watch(openF1DriverServiceProvider),
    positionService: ref.watch(positionServiceProvider),
    intervalService: ref.watch(intervalServiceProvider),
    stintService: ref.watch(stintServiceProvider),
  );
});

final driverStatusProvider = FutureProvider<List<DriverStatus>>((ref) async {
  final repository = ref.watch(driverRepositoryProvider);

  return repository.fetchDriverStatus();
});
