import '../models/car_data.dart';
import '../models/lap.dart';
import '../models/team_radio.dart';

import '../services/car_data_service.dart';
import '../services/lap_service.dart';
import '../services/team_radio_service.dart';

class ReplayRepository {
  final LapService lapService;
  final CarDataService carDataService;
  final TeamRadioService teamRadioService;

  ReplayRepository({
    required this.carDataService,
    required this.lapService,
    required this.teamRadioService,
  });

  Future<List<Lap>> fetchLaps() => lapService.fetchLaps();
  Future<List<CarData>> fetchCarData() => carDataService.fetchCarData();
  Future<List<TeamRadio>> fetchRadio() => teamRadioService.fetchTeamRadio();
}
