class RacingHubDriver {
  final String id;
  final int permanentNumber;
  final String abbr;
  // final String country;

  RacingHubDriver({
    // this.country = '',
    required this.id,
    required this.permanentNumber,
    required this.abbr,
  });

  factory RacingHubDriver.fromJson(Map<String, dynamic> json) {
    final driver = json['driver'] is Map<String, dynamic>
        ? json['driver']
        : json;
    return RacingHubDriver(
      id: driver['id'] ?? json['id'] ?? '',
      permanentNumber:
          int.tryParse(
            (driver['permanentNumber'] ??
                    driver['permanent_number'] ??
                    driver['number'] ??
                    '0')
                .toString(),
          ) ??
          0,
      abbr: (driver['abbr'] ?? json['abbr'] ?? json['code'] ?? '')
          .toString()
          .toUpperCase(),

      //country: (driver['country'] ?? json['country'] ?? '').toString(),
    );
  }
}
