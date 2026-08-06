import '../models/weather.dart';
import '../services/weather_service.dart';

class WeatherRepository {
  final WeatherService weatherService;

  WeatherRepository({required this.weatherService});

  Future<Weather?> fetchLatestWeather() async {
    final weather = await weatherService.fetchWeather();

    if (weather.isEmpty) return null;
    return weather.last;
  }
}
