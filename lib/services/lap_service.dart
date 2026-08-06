import '../models/lap.dart';
import 'api_service.dart';

class LapService {
  final ApiService api;
  LapService(this.api);

  Future<List<Lap>> fetchLaps() async {
    final List data = await api.get(
      "https://api.openf1.org/v1/laps?session_key=latest",
    );

    return data.map<Lap>((e) => Lap.fromJson(e)).toList();
  }
}
