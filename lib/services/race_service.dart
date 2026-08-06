import 'package:f1/services/api_service.dart';
import '../models/race.dart';

class RaceService {
  final ApiService api;
  RaceService(this.api);

  Future<List<Race>> fetchRaces() async {
    final data = await api.get("current/races/");

    final races = data["MRData"]["RaceTable"]["Races"];

    return races.map<Race>((race) => Race.fromJson(race)).toList();
  }
}
