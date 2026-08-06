import '../models/openf1_driver.dart';
import 'api_service.dart';

class OpenF1DriverService {
  final ApiService api;
  OpenF1DriverService(this.api);

  Future<List<OpenF1Driver>> fetchDrivers() async {
    final List data = await api.get(
      "https://api.openf1.org/v1/drivers?session_key=latest",
    );

    return data
        .map<OpenF1Driver>((driver) => OpenF1Driver.fromJson(driver))
        .toList();
  }
}
