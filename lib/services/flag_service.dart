/*import 'dart:convert';
import 'package:http/http.dart' as http;

class FlagService {
  final http.Client client;
  final Map<String, String> _isoCache = {};

  FlagService({required this.client});

  Future<String?> getIsoCode(String query, {bool isDemonym = false}) async {
    final key = query.toLowerCase().trim();
    if (key.isEmpty) return null;
    if (_isoCache.containsKey(key)) return _isoCache[key];

    final endpoint = isDemonym
        ? 'https://restcountries.com/v3.1/demonym/${Uri.encodeComponent(key)}?fields=cca2'
        : 'https://restcountries.com/v3.1/name/${Uri.encodeComponent(key)}?fields=cca2';

    try {
      final response = await client.get(Uri.parse(endpoint));
      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        if (data.isNotEmpty && data[0]['cca2'] != null) {
          final String isoCode = data[0]['cca2'];
          _isoCache[key] = isoCode;
          return isoCode;
        }
      }
    } catch (_) {
      // Gracefully handle rate-limits or offline state
    }
    return null;
  }
}

extension IsoToFlagEmoji on String {
  String toFlagEmoji() {
    if (length != 2) return '';
    final upper = toUpperCase();
    return String.fromCharCode(upper.codeUnitAt(0) + 127397) +
        String.fromCharCode(upper.codeUnitAt(1) + 127397);
  }
}*/

import 'package:sealed_countries/sealed_countries.dart';

class FlagService {
  static final Map<String, String> _isoCache = {};

  /// Resolves country names, kebab-case strings, demonyms, or ISO codes
  /// to 2-letter ISO codes offline in 0ms without network calls.
  static String? getIsoCode(String query, {bool isDemonym = false}) {
    final cleanQuery = query.trim();
    if (cleanQuery.isEmpty) return null;

    final key = cleanQuery.toLowerCase();
    if (_isoCache.containsKey(key)) return _isoCache[key];

    // 1. Direct return if query is already a valid 2-letter or 3-letter ISO code (e.g. "GB", "GBR")
    if (RegExp(r'^[a-zA-Z]{2,3}$').hasMatch(cleanQuery)) {
      final upper = cleanQuery.toUpperCase();
      for (final country in WorldCountry.list) {
        if (country.codeShort == upper || country.code == upper) {
          _isoCache[key] = country.codeShort;
          return country.codeShort;
        }
      }
    }

    // 2. Normalize hyphens and extra spaces ("united-kingdom" -> "united kingdom")
    final normalized = key.replaceAll('-', ' ');

    // 3. Search local sealed_countries dataset
    for (final country in WorldCountry.list) {
      // Check common & official names
      if (country.name.common.toLowerCase() == normalized ||
          country.name.official.toLowerCase() == normalized) {
        _isoCache[key] = country.codeShort;
        return country.codeShort;
      }

      // Check alternate spellings (e.g. "UK", "USA", "Éire")
      if (country.altSpellings.any((s) => s.toLowerCase() == normalized)) {
        _isoCache[key] = country.codeShort;
        return country.codeShort;
      }

      // Check demonyms (e.g. "British", "Dutch", "American")
      if (isDemonym || country.demonyms.isNotEmpty) {
        final matchesDemonym = country.demonyms.any(
          (d) =>
              d.male.toLowerCase() == normalized ||
              d.female.toLowerCase() == normalized,
        );
        if (matchesDemonym) {
          _isoCache[key] = country.codeShort;
          return country.codeShort;
        }
      }
    }

    return null;
  }
}

extension IsoToFlagEmoji on String {
  String toFlagEmoji() {
    if (length != 2) return '';
    final upper = toUpperCase();
    return String.fromCharCode(upper.codeUnitAt(0) + 127397) +
        String.fromCharCode(upper.codeUnitAt(1) + 127397);
  }
}
