import '../app/api_provider.dart';
import '../../models/lap.dart';
import '../../services/openf1/lap_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final lapServiceProvider = Provider(
  (ref) => LapService(ref.watch(apiServiceProvider)),
);

final lapProvider = FutureProvider<List<Lap>>((ref) async {
  final service = ref.watch(lapServiceProvider);

  return service.fetchLaps();
});
