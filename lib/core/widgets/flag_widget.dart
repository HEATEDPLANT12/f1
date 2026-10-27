/*import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/jolpica_providers.dart';
import '../../services/flag_service.dart';

class FlagWidget extends ConsumerWidget {
  final String query;
  final bool isDemonym;
  final double fontSize;

  const FlagWidget({
    super.key,
    required this.query,
    this.isDemonym = false,
    this.fontSize = 20,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flagAsync = ref.watch(
      flagIsoProvider((query: query, isDemonym: isDemonym)),
    );

    return flagAsync.when(
      data: (isoCode) {
        if (isoCode == null || isoCode.isEmpty) {
          return const SizedBox.shrink();
        }
        return Text(
          isoCode.toFlagEmoji(),
          style: TextStyle(fontSize: fontSize),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}*/
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import '../../services/flag_service.dart';

class FlagWidget extends StatelessWidget {
  final String query;
  final double width;
  final double height;

  const FlagWidget({
    super.key,
    required this.query,
    this.width = 20,
    this.height = 14,
  });

  @override
  Widget build(BuildContext context) {
    final isoCode = FlagService.getIsoCode(query);

    if (isoCode == null || isoCode.isEmpty) {
      return const SizedBox.shrink();
    }

    return CountryFlag.fromCountryCode(
      isoCode,
      theme: ImageTheme(
        width: width,
        height: height,
        shape: const RoundedRectangle(2),
      ),
    );
  }
}
