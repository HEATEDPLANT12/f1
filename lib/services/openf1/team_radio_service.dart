import '../../models/team_radio.dart';
import '../api_service.dart';

class TeamRadioService {
  final ApiService api;
  TeamRadioService(this.api);

  Future<List<TeamRadio>> fetchTeamRadio() async {
    final List data = await api.get(
      "https://api.openf1.org/v1/team_radio?session_key=latest",
    );

    return data.map<TeamRadio>((e) => TeamRadio.fromJson(e)).toList();
  }
}
