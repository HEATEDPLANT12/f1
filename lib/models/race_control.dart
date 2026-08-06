class RaceControl {
  final String category;
  final String message;
  final String scope;
  final String date;

  const RaceControl({
    required this.category,
    required this.date,
    required this.message,
    required this.scope,
  });

  factory RaceControl.fromJson(Map<String, dynamic> json) {
    return RaceControl(
      category: json["category"],
      message: json["scope"],
      scope: json["message"],
      date: json["date"],
    );
  }
}
