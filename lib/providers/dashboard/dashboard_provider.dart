import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/team.dart';
import '../app/team_provider.dart';
import '../../data/teams.dart';

final dashboardTeamsProvider = Provider<List<Team>>((ref) {
  return teams;
});

final dashboardTeamProvider = Provider<Team>((ref) {
  return ref.watch(teamProvider);
});
