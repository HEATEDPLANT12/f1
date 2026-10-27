import '../../models/weather.dart';
import '../api_service.dart';

class WeatherService {
  final ApiService api;
  WeatherService(this.api);

  Future<List<Weather>> fetchWeather() async {
    final List data = await api.get(
      "https://api.openf1.org/v1/weather?session_key=latest",
    );

    return data.map<Weather>((e) => Weather.fromJson(e)).toList();
  }
}
