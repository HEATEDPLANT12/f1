import 'api_service.dart';
import '../models/stint.dart';

class StintService {
  final ApiService api;
  StintService(this.api);

  Future<List<Stint>> fetchStints() async {
    final List data = await api.get(
      "https://api.openf1.org/v1/stints?session_key=latest",
    );

    return data.map<Stint>((s) => Stint.fromJson(s)).toList();
  }
}
