import 'package:f1/models/weather.dart';
import 'package:f1/providers/api_provider.dart';
import 'package:f1/services/weather_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final weatherServiceProvider = Provider(
  (ref) => WeatherService(ref.watch(apiServiceProvider)),
);

final weatherProvider = FutureProvider<List<Weather>>((ref) async {
  final service = ref.watch(weatherServiceProvider);

  return service.fetchWeather();
});
