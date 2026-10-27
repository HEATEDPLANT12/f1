import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/jolpica_driver.dart';
import '../models/race_result.dart';

class JolpicaService {
  static const String _baseUrl = 'https://api.jolpi.ca/ergast/f1';

  final http.Client client;

  JolpicaService({required this.client});

  Future<List<JolpicaDriver>> fetchDriverStandings() async {
    final url = Uri.parse('$_baseUrl/current/driverStandings.json');
    final response = await client.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List standingsJson =
          data['MRData']['StandingsTable']['StandingsLists'][0]['DriverStandings'];
      return standingsJson
          .map((json) => JolpicaDriver.fromStandingJson(json))
          .toList();
    } else {
      throw Exception('Failed to load standings: ${response.statusCode}');
    }
  }

  Future<List<RaceResult>> fetchDriverSeasonResults(String driverId) async {
    final url = Uri.parse('$_baseUrl/current/drivers/$driverId/results.json');
    final response = await client.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List racesJson = data['MRData']['RaceTable']['Races'] ?? [];
      return racesJson.map((json) => RaceResult.fromJson(json)).toList();
    } else {
      throw Exception(
        'Failed to load driver race results: ${response.statusCode}',
      );
    }
  }

  Future<RaceResult?> fetchDriverDebut(String driverId) async {
    final url = Uri.parse('$_baseUrl/drivers/$driverId/results.json?limit=1');
    final response = await client.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List racesJson = data['MRData']['RaceTable']['Races'] ?? [];
      if (racesJson.isNotEmpty) {
        return RaceResult.fromJson(racesJson.first);
      }
      return null;
    } else {
      throw Exception('Failed to load driver debut: ${response.statusCode}');
    }
  }
}
