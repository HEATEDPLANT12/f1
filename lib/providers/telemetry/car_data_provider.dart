import 'package:f1/models/car_data.dart';
import 'package:f1/providers/app/api_provider.dart';
import 'package:f1/services/openf1/car_data_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final carDataServiceProvider = Provider(
  (ref) => CarDataService(ref.watch(apiServiceProvider)),
);

final carDataProvider = FutureProvider<List<CarData>>((ref) async {
  final service = ref.watch(carDataServiceProvider);

  return service.fetchCarData();
});
