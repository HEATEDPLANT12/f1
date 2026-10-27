import '../api_service.dart';
import '../../models/position.dart';

class PositionService {
  final ApiService api;
  PositionService(this.api);

  Future<List<Position>> fetchPositions() async {
    final List data = await api.get(
      "https://api.openf1.org/v1/position?session_key=latest",
    );

    return data.map<Position>((e) => Position.fromJson(e)).toList();
  }
}
