import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/openf1_driver.dart';
import '../../services/openf1/openf1_driver_service.dart';
import '../app/api_provider.dart';

final openF1DriverServiceProvider = Provider(
  (ref) => OpenF1DriverService(ref.watch(apiServiceProvider)),
);

final openF1DriversProvider = FutureProvider<List<OpenF1Driver>>((ref) async {
  final service = ref.watch(openF1DriverServiceProvider);

  return service.fetchDrivers();
});
