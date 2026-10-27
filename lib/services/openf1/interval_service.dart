import 'package:f1/services/api_service.dart';
import '../../models/interval.dart';

class IntervalService {
  final ApiService api;
  IntervalService(this.api);

  Future<List<Interval>> fetchIntervals() async {
    final List data = await api.get(
      "https://api.openf1.org/v1/intervals?session_key=latest",
    );
    //print(data.first);
    return data.map<Interval>((i) => Interval.fromJson(i)).toList();
  }
}
