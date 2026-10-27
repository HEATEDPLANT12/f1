import '../../models/pit_stop.dart';
import '../api_service.dart';

class PitService {
  final ApiService api;
  PitService(this.api);

  Future<List<PitStop>> fetchPitStops() async {
    final List data = await api.get(
      "https://api.openf1.org/v1/pit?session_key=latest",
    );

    return data.map<PitStop>((e) => PitStop.fromJson(e)).toList();
  }
}
