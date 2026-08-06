import 'dart:convert';
import 'package:f1/services/api_service.dart';
import 'package:http/http.dart' as http;

import '../models/constructor_standing.dart';

class ConstructorService {
  final ApiService api;
  ConstructorService(this.api);

  Future<List<ConstructorStanding>> fetchConstructorStandings() async {
    final data = await api.get("current/constructorstandings/");

    //final Map<String, dynamic> data = jsonDecode(response.body);

    final standings =
        data["MRData"]["StandingsTable"]["StandingsLists"][0]["ConstructorStandings"];

    return standings
        .map<ConstructorStanding>((team) => ConstructorStanding.fromJson(team))
        .toList();
  }
}
