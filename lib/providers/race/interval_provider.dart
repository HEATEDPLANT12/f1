import 'package:f1/providers/app/api_provider.dart';
import 'package:f1/services/openf1/interval_service.dart';
import '../../models/interval.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final intervalServiceProvider = Provider(
  (ref) => IntervalService(ref.watch(apiServiceProvider)),
);

final intervalProvider = FutureProvider<List<Interval>>((ref) async {
  final service = ref.watch(intervalServiceProvider);

  return service.fetchIntervals();
});
