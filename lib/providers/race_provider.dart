import 'dart:developer';

import '../models/race.dart';
import '../services/race_service.dart';
import 'package:f1/providers/api_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final raceServiceProvider = Provider(
  (ref) => RaceService(ref.watch(apiServiceProvider)),
);

final raceProvider = FutureProvider<List<Race>>((ref) async {
  final service = ref.watch(raceServiceProvider);
  return service.fetchRaces();
});
