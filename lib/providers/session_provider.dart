import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/session.dart';
import 'api_provider.dart';
import '../services/session_service.dart';

final sessionServiceprovider = Provider(
  (ref) => SessionService(ref.watch(apiServiceProvider)),
);

final sessionprovider = FutureProvider<List<Session>>((ref) async {
  final service = ref.watch(sessionServiceprovider);

  return service.fetchSessions();
});
