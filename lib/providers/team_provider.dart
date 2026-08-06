import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:flutter_riverpod/legacy.dart';
import '../models/team.dart';
import '../data/teams.dart';

class TeamNotifier extends Notifier<Team> {
  @override
  Team build() {
    return teams.first;
  }

  void changeTeam(Team team) {
    state = team;
  }
}

final teamProvider = NotifierProvider<TeamNotifier, Team>(TeamNotifier.new);
