import '../models/stint.dart';
import '../models/weather.dart';

import '../services/stint_service.dart';
import '../services/weather_service.dart';

class StrategyRepository {
  final StintService stintService;
  final WeatherService weatherService;

  StrategyRepository({
    required this.stintService,
    required this.weatherService,
  });

  Future<List<Stint>> fetchStints() => stintService.fetchStints();

  Future<Weather?> latestWeather() async {
    final weather = await weatherService.fetchWeather();

    if (weather.isEmpty) return null;
    return weather.last;
  }
}
