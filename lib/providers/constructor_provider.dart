import 'package:f1/providers/api_provider.dart';

import '../services/constructor_service.dart';
import '../models/constructor_standing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cosntructorServiceProvider = Provider(
  (ref) => ConstructorService(ref.watch(apiServiceProvider)),
);

final constructorStandingsProvider = FutureProvider<List<ConstructorStanding>>((
  ref,
) async {
  final service = ref.watch(cosntructorServiceProvider);

  return service.fetchConstructorStandings();
});
