import '../../models/race_control.dart';
import '../api_service.dart';

class RaceControlService {
  final ApiService api;
  RaceControlService(this.api);

  Future<List<RaceControl>> fetchRaceControl() async {
    final List data = await api.get(
      "https://api.openf1.org/v1/race_control?session_key=latest",
    );

    return data.map<RaceControl>((e) => RaceControl.fromJson(e)).toList();
  }
}
