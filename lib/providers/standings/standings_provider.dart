import 'package:f1/providers/app/api_provider.dart';

import '../../models/driver_standing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/jolpi/standings_service.dart';

final standingsServiceProvider = Provider(
  (ref) => StandingsService(ref.watch(apiServiceProvider)),
);

final standingsProvider = FutureProvider<List<DriverStanding>>((ref) async {
  final service = ref.watch(standingsServiceProvider);
  return service.fetchDriverStandings();
});
