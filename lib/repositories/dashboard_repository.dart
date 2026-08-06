import '../models/constructor_standing.dart';
import '../models/driver_standing.dart';
import '../models/race.dart';
import '../models/session.dart';

import '../services/constructor_service.dart';
import '../services/race_service.dart';
import '../services/session_service.dart';
import '../services/standings_service.dart';

class DashboardRepository {
  final StandingsService standingsService;
  final ConstructorService constructorService;
  final RaceService raceService;
  final SessionService sessionService;

  DashboardRepository({
    required this.constructorService,
    required this.raceService,
    required this.sessionService,
    required this.standingsService,
  });

  Future<List<DriverStanding>> driverStandings() =>
      standingsService.fetchDriverStandings();
  Future<List<ConstructorStanding>> constructorStandings() =>
      constructorService.fetchConstructorStandings();
  Future<List<Race>> raceCalendar() => raceService.fetchRaces();
  Future<List<Session>> sessions() => sessionService.fetchSessions();
}
