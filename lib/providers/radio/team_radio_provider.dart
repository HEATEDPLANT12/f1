import 'package:f1/models/team_radio.dart';
import 'package:f1/providers/app/api_provider.dart';
import 'package:f1/services/openf1/team_radio_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final teamRadioServiceProvider = Provider(
  (ref) => TeamRadioService(ref.watch(apiServiceProvider)),
);

final teamRadioProvider = FutureProvider<List<TeamRadio>>((ref) async {
  final service = ref.watch(teamRadioServiceProvider);

  return service.fetchTeamRadio();
});
