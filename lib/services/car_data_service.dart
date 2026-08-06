import '../models/car_data.dart';
import 'api_service.dart';

class CarDataService {
  final ApiService api;
  CarDataService(this.api);

  Future<List<CarData>> fetchCarData() async {
    final List data = await api.get(
      "https://api.openf1.org/v1/car_data?session_key=latest",
    );

    return data.map<CarData>((e) => CarData.fromJson(e)).toList();
  }
}
