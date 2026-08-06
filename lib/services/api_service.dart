import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://api.jolpi.ca/ergast/f1";

  Future<dynamic> get(String endpoint) async {
    final uri = endpoint.startsWith("http")
        ? Uri.parse(endpoint)
        : Uri.parse("$baseUrl/$endpoint");
    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception("Request failed: ${response.statusCode}");
    }

    return jsonDecode(response.body);
  }
}
