import 'package:f1/models/race_control.dart';
import 'package:f1/providers/api_provider.dart';
import 'package:f1/services/race_control_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final raceControlServiceProvider = Provider(
  (ref) => RaceControlService(ref.watch(apiServiceProvider)),
);

final raceControlProvider = FutureProvider<List<RaceControl>>((ref) async {
  final service = ref.watch(raceControlServiceProvider);

  return service.fetchRaceControl();
});
