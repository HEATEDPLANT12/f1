import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/session.dart';
import '../app/api_provider.dart';
import '../../services/openf1/session_service.dart';

final sessionServiceProvider = Provider(
  (ref) => SessionService(ref.watch(apiServiceProvider)),
);

final sessionProvider = FutureProvider<List<Session>>((ref) async {
  final service = ref.watch(sessionServiceProvider);

  return service.fetchSessions();
});
