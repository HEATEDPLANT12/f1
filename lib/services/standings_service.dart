import 'dart:convert';
import 'package:f1/services/api_service.dart';

import '../models/driver_standing.dart';
import 'package:http/http.dart' as http;

class StandingsService {
  final ApiService api;
  StandingsService(this.api);

  Future<List<DriverStanding>> fetchDriverStandings() async {
    final data = await api.get("current/driverstandings/");

    final standings =
        data["MRData"]["StandingsTable"]["StandingsLists"][0]["DriverStandings"];
    return standings
        .map<DriverStanding>((driver) => DriverStanding.fromJson(driver))
        .toList();
  }
}
