import '../../models/race.dart';
import '../../services/jolpi/race_service.dart';
import 'package:f1/providers/app/api_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final raceServiceProvider = Provider(
  (ref) => RaceService(ref.watch(apiServiceProvider)),
);

final raceProvider = FutureProvider<List<Race>>((ref) async {
  final service = ref.watch(raceServiceProvider);
  return service.fetchRaces();
});

final completedRacesProvider = Provider<AsyncValue<List<Race>>>((ref) {
  return ref.watch(raceProvider).whenData((races) => races.completed);
});
