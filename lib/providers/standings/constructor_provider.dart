import 'package:f1/providers/app/api_provider.dart';

import '../../services/jolpi/constructor_service.dart';
import '../../models/constructor_standing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final constructorServiceProvider = Provider(
  (ref) => ConstructorService(ref.watch(apiServiceProvider)),
);

final constructorStandingsProvider = FutureProvider<List<ConstructorStanding>>((
  ref,
) async {
  final service = ref.watch(constructorServiceProvider);

  return service.fetchConstructorStandings();
});
