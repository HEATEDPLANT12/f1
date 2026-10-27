/*import '../models/constructor_standing.dart';
import '../models/driver_standing.dart';
import '../models/race.dart';
import '../models/session.dart';
*/

import '../models/team.dart';
import '../data/teams.dart';

class DashboardRepository {
  List<Team> getTeams() {
    return teams;
  }

  /*final StandingsService standingsService;
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
  Future<List<Session>> sessions() => sessionService.fetchSessions();*/
}
