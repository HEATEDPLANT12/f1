import '../models/session.dart';
import 'api_service.dart';

class SessionService {
  final ApiService api;
  SessionService(this.api);

  Future<List<Session>> fetchSessions() async {
    final List data = await api.get(
      "https://api.openf1.org/v1/sessions?year=2026",
    );

    return data.map<Session>((session) => Session.fromJson(session)).toList();
  }
}
