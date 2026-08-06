import 'package:f1/models/position.dart';
import 'package:f1/providers/api_provider.dart';
import 'package:f1/services/position_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final positionServiceProvider = Provider(
  (ref) => PositionService(ref.watch(apiServiceProvider)),
);

final positionProvider = FutureProvider<List<Position>>((ref) async {
  final service = ref.watch(positionServiceProvider);
  return service.fetchPositions();
});
