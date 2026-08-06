import 'package:f1/providers/api_provider.dart';
import 'package:f1/services/stint_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/stint.dart';

final stintServiceProvider = Provider(
  (ref) => StintService(ref.watch(apiServiceProvider)),
);

final stintProvider = FutureProvider<List<Stint>>((ref) async {
  final service = ref.watch(stintServiceProvider);
  return service.fetchStints();
});
