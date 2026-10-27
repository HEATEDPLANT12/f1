import 'constructor_standing.dart';
import 'driver_standing.dart';
import 'driver_status.dart';
import 'lap.dart';
import 'race.dart';
import 'race_control.dart';
import 'session.dart';
import 'team.dart';
import 'weather.dart';

class DashboardData {
  final Team selectedTeam;
  final Session? currentSession;
  final Race? nextRace;
  final Lap? latestLap;
  final Weather? weather;
  final List<DriverStatus> teamDrivers;
  final RaceControl? latestRaceControl;
  final DriverStanding? championshipLeader;
  final ConstructorStanding? constructorLeader;

  const DashboardData({
    required this.championshipLeader,
    required this.constructorLeader,
    required this.currentSession,
    required this.teamDrivers,
    required this.latestLap,
    required this.latestRaceControl,
    required this.nextRace,
    required this.selectedTeam,
    required this.weather,
  });
}
