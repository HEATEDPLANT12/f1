/*import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/driver_career_stats.dart';
import '../models/racing_hub_driver.dart';

class RacingHubService {
  static const String _baseUrl = 'https://racinghub.net/api/v1';
  final http.Client client;

  RacingHubService({required this.client});

  /// Fetches the complete driver list to enable dynamic lookup matching
  Future<List<RacingHubDriver>> fetchDrivers() async {
    final response = await client.get(Uri.parse('$_baseUrl/drivers?limit=917'));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final List rawList = body is List
          ? body
          : (body['items'] ?? body['data'] ?? body['drivers'] ?? []);
      return rawList.map((json) => RacingHubDriver.fromJson(json)).toList();
    } else {
      throw Exception(
        'Failed to fetch RacingHub index: ${response.statusCode}',
      );
    }
  }

  /// Fetches career stats using the native RacingHub driver ID
  Future<DriverCareerStats> fetchDriverStats(String racinghubId) async {
    final response = await client.get(
      Uri.parse('$_baseUrl/drivers/$racinghubId'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return DriverCareerStats.fromJson(data);
    } else {
      throw Exception(
        'Failed to fetch career stats for $racinghubId: ${response.statusCode}',
      );
    }
  }
}*/

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/driver_career_stats.dart';
import '../models/racing_hub_driver.dart';

class RacingHubService {
  static const String _baseUrl = 'https://racinghub.net/api/v1';
  final http.Client client;

  RacingHubService({required this.client});

  /// 1. Fetches only the current season driver directory (1 GET request)
  Future<List<RacingHubDriver>> fetchCurrentSeasonDrivers() async {
    final currentYear = DateTime.now().year;
    final response = await client.get(
      Uri.parse('$_baseUrl/seasons/$currentYear/drivers?limit=100'),
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      final List rawList;
      if (decoded is List) {
        rawList = decoded;
      } else if (decoded is Map<String, dynamic>) {
        rawList = decoded['data'] ?? decoded['items'] ?? [];
      } else {
        rawList = [];
      }

      return rawList.map((json) => RacingHubDriver.fromJson(json)).toList();
    } else {
      throw Exception(
        'Failed to fetch $currentYear season drivers: ${response.statusCode}',
      );
    }
  }

  /// 2. Fetches career statistics using the native RacingHub driver ID
  Future<DriverCareerStats> fetchDriverStats(String racingHubId) async {
    final response = await client.get(
      Uri.parse('$_baseUrl/drivers/$racingHubId'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return DriverCareerStats.fromJson(data);
    } else {
      throw Exception(
        'Failed to fetch career stats for $racingHubId: ${response.statusCode}',
      );
    }
  }
}
