import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../models/jolpica_driver.dart';
import '../models/race_result.dart';
import '../services/jolpica_service.dart';

final httpClientProvider = Provider<http.Client>((ref) {
  final client = http.Client();
  ref.onDispose(() => client.close());
  return client;
});

final jolpicaServiceProvider = Provider<JolpicaService>((ref) {
  return JolpicaService(client: ref.watch(httpClientProvider));
});

/*final flagServiceProvider = Provider<FlagService>((ref) {
  return FlagService(client: ref.watch(httpClientProvider));
});*/

final driverStandingsProvider = FutureProvider<List<JolpicaDriver>>((
  ref,
) async {
  final service = ref.watch(jolpicaServiceProvider);
  return service.fetchDriverStandings();
});

final jolpicaDriverProvider = FutureProvider.autoDispose
    .family<JolpicaDriver, String>((ref, driverId) async {
      final standings = await ref.watch(driverStandingsProvider.future);
      return standings.firstWhere(
        (d) =>
            d.driverId == driverId || d.permanentNumber.toString() == driverId,
      );
    });

// AutoDispose clears family provider memory when driver screens unmount
final driverSeasonResultsProvider = FutureProvider.autoDispose
    .family<List<RaceResult>, String>((ref, driverIdOrNumber) async {
      final driver = await ref.watch(
        jolpicaDriverProvider(driverIdOrNumber).future,
      );
      final service = ref.watch(jolpicaServiceProvider);
      return service.fetchDriverSeasonResults(driver.driverId);
    });

/*final flagIsoProvider = FutureProvider.autoDispose
    .family<String?, ({String query, bool isDemonym})>((ref, params) async {
      final service = ref.watch(flagServiceProvider);
      return service.getIsoCode(params.query, isDemonym: params.isDemonym);
    });*/
final driverDebutProvider = FutureProvider.autoDispose
    .family<RaceResult?, String>((ref, driverIdOrNumber) async {
      final driver = await ref.watch(
        jolpicaDriverProvider(driverIdOrNumber).future,
      );
      final service = ref.watch(jolpicaServiceProvider);
      return service.fetchDriverDebut(driver.driverId);
    });
