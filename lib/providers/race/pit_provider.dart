import 'package:f1/models/pit_stop.dart';
import 'package:f1/providers/app/api_provider.dart';
import 'package:f1/services/openf1/pit_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pitServiceProvider = Provider(
  (ref) => PitService(ref.watch(apiServiceProvider)),
);

final pitProvider = FutureProvider<List<PitStop>>((ref) async {
  final service = ref.watch(pitServiceProvider);

  return service.fetchPitStops();
});
