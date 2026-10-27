/*import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:f1/models/openf1_driver.dart';
import '../../../core/widgets/flag_widget.dart';

class AnimatedDriverCard extends StatelessWidget {
  final OpenF1Driver driver;
  final Color accentColor;
  final bool isHeaderMode;
  final VoidCallback onTap;

  const AnimatedDriverCard({
    super.key,
    required this.driver,
    required this.accentColor,
    required this.isHeaderMode,
    required this.onTap,
  });

  static const Duration animDuration = Duration(milliseconds: 400);
  static const Curve animCurve = Curves.fastOutSlowIn;

  @override
  Widget build(BuildContext context) {
    final nameParts = driver.fullName.trim().split(RegExp(r'\s+'));
    final firstName = nameParts.length > 1 ? nameParts.first.toUpperCase() : '';
    final lastName = nameParts.isNotEmpty
        ? nameParts.last.toUpperCase()
        : driver.fullName.toUpperCase();

    // Sanitizes surnames for local asset lookup (e.g., "verstappen" -> "verstappen.webp")
    final sanitizedSurname =
        (nameParts.isNotEmpty ? nameParts.last : driver.fullName)
            .toLowerCase()
            .replaceAll(RegExp(r'[^a-z0-9]'), '');

    final bool isSkeleton = Skeletonizer.maybeOf(context)?.enabled ?? false;

    final Widget driverImage = Skeleton.keep(
      child: Image.asset(
        'assets/drivers/$sanitizedSurname.webp',
        fit: isHeaderMode ? BoxFit.cover : BoxFit.contain,
        alignment: Alignment.topCenter,
        filterQuality: FilterQuality.high,
        color: isSkeleton ? const Color(0xFF2C2C2C) : null,
        colorBlendMode: isSkeleton ? BlendMode.srcIn : null,
        errorBuilder: (context, error, stackTrace) => Icon(
          Icons.person,
          size: isHeaderMode ? 80 : 100,
          color: const Color(0xFFEC1515),
        ),
      ),
    );

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: animDuration,
        curve: animCurve,
        height: isHeaderMode ? 120 : 240,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFF121212),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: accentColor, width: 1.5),
        ),
        child: Stack(
          children: [
            // Outlined Driver Number
            AnimatedPositioned(
              duration: animDuration,
              curve: animCurve,
              top: isHeaderMode ? 12 : 10,
              left: 20,
              child: AnimatedContainer(
                duration: animDuration,
                curve: animCurve,
                width: isHeaderMode ? 100 : 140,
                alignment: isHeaderMode
                    ? Alignment.center
                    : Alignment.centerLeft,
                child: AnimatedDefaultTextStyle(
                  duration: animDuration,
                  curve: animCurve,
                  style: TextStyle(
                    fontSize: isHeaderMode ? 85 : 110,
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.italic,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 4
                      ..color = accentColor.withValues(alpha: 0.85),
                  ),
                  child: Text(driver.driverNumber.toString()),
                ),
              ),
            ),

            Positioned(
              bottom: 0,
              right: 0,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(14),
                  topRight: Radius.circular(14),
                ),
                child: AnimatedContainer(
                  duration: animDuration,
                  curve: animCurve,
                  height: isHeaderMode ? 120 : 240,
                  width: isHeaderMode ? 130 : 200,
                  child: isHeaderMode
                      ? driverImage
                      : OverflowBox(
                          maxHeight: 600,
                          maxWidth: 600,
                          alignment: Alignment.topCenter,
                          child: driverImage,
                        ),
                ),
              ),
            ),

            // Driver Name & Info
            AnimatedPositioned(
              duration: animDuration,
              curve: animCurve,
              left: isHeaderMode ? 130 : 20,
              top: isHeaderMode ? 0 : null,
              bottom: isHeaderMode ? 0 : 24,
              child: Container(
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (firstName.isNotEmpty) ...[
                          Text(
                            firstName,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: isHeaderMode ? 14 : 16,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                        /*FlagWidget(
                          query: driver.countryCode,
                          isDemonym: true,
                          fontSize: isHeaderMode ? 16 : 18,
                        ),*/
                      ],
                    ),
                    Text(
                      lastName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isHeaderMode ? 22 : 28,
                        fontWeight: FontWeight.w900,
                        height: 1.1,
                      ),
                    ),
                    if (!isHeaderMode) ...[
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: accentColor.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              driver.broadcastName.isNotEmpty
                                  ? driver.broadcastName
                                  : "#${driver.driverNumber}",
                              style: TextStyle(
                                color: accentColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            driver.teamName ?? '',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),

            // Navigation Arrow
            AnimatedPositioned(
              duration: animDuration,
              curve: animCurve,
              bottom: 20,
              right: isHeaderMode ? -60 : 20,
              child: AnimatedOpacity(
                duration: animDuration,
                opacity: isHeaderMode ? 0.0 : 1.0,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: accentColor, width: 2),
                    color: Colors.black.withValues(alpha: 0.6),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Icon(
                    Icons.arrow_forward,
                    color: accentColor,
                    size: 22,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:f1/models/driver_career_stats.dart';
import 'package:f1/models/openf1_driver.dart';
import 'package:f1/providers/racinghub_providers.dart';
import '../../../core/widgets/flag_widget.dart';

class AnimatedDriverCard extends StatelessWidget {
  final OpenF1Driver driver;
  final Color accentColor;
  final bool isHeaderMode;
  final VoidCallback onTap;

  const AnimatedDriverCard({
    super.key,
    required this.driver,
    required this.accentColor,
    required this.isHeaderMode,
    required this.onTap,
  });

  static const Duration animDuration = Duration(milliseconds: 400);
  static const Curve animCurve = Curves.fastOutSlowIn;

  @override
  Widget build(BuildContext context) {
    final nameParts = driver.fullName.trim().split(RegExp(r'\s+'));
    final firstName = nameParts.length > 1 ? nameParts.first.toUpperCase() : '';
    final lastName = nameParts.isNotEmpty
        ? nameParts.last.toUpperCase()
        : driver.fullName.toUpperCase();

    // Sanitizes surnames for local asset lookup (e.g., "verstappen" -> "verstappen.webp")
    final sanitizedSurname =
        (nameParts.isNotEmpty ? nameParts.last : driver.fullName)
            .toLowerCase()
            .replaceAll(RegExp(r'[^a-z0-9]'), '');

    final bool isSkeleton = Skeletonizer.maybeOf(context)?.enabled ?? false;

    final Widget driverImage = Skeleton.keep(
      child: Image.asset(
        'assets/drivers/$sanitizedSurname.webp',
        fit: isHeaderMode ? BoxFit.cover : BoxFit.contain,
        alignment: Alignment.topCenter,
        filterQuality: FilterQuality.high,
        color: isSkeleton ? const Color(0xFF2C2C2C) : null,
        colorBlendMode: isSkeleton ? BlendMode.srcIn : null,
        errorBuilder: (context, error, stackTrace) => Icon(
          Icons.person,
          size: isHeaderMode ? 80 : 100,
          color: const Color(0xFFEC1515),
        ),
      ),
    );

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: animDuration,
        curve: animCurve,
        height: isHeaderMode ? 120 : 240,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFF121212),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: accentColor, width: 1.5),
        ),
        child: Stack(
          children: [
            // Outlined Driver Number
            AnimatedPositioned(
              duration: animDuration,
              curve: animCurve,
              top: isHeaderMode ? 12 : 10,
              left: 20,
              child: AnimatedContainer(
                duration: animDuration,
                curve: animCurve,
                width: isHeaderMode ? 100 : 140,
                alignment: isHeaderMode
                    ? Alignment.center
                    : Alignment.centerLeft,
                child: AnimatedDefaultTextStyle(
                  duration: animDuration,
                  curve: animCurve,
                  style: TextStyle(
                    fontSize: isHeaderMode ? 85 : 110,
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.italic,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 4
                      ..color = accentColor.withValues(alpha: 0.85),
                  ),
                  child: Text(driver.driverNumber.toString()),
                ),
              ),
            ),

            Positioned(
              bottom: 0,
              right: 0,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(14),
                  topRight: Radius.circular(14),
                ),
                child: AnimatedContainer(
                  duration: animDuration,
                  curve: animCurve,
                  height: isHeaderMode ? 120 : 240,
                  width: isHeaderMode ? 130 : 200,
                  child: isHeaderMode
                      ? driverImage
                      : OverflowBox(
                          maxHeight: 600,
                          maxWidth: 600,
                          alignment: Alignment.topCenter,
                          child: driverImage,
                        ),
                ),
              ),
            ),

            // Driver Name & Info
            AnimatedPositioned(
              duration: animDuration,
              curve: animCurve,
              left: isHeaderMode ? 130 : 20,
              top: isHeaderMode ? 0 : null,
              bottom: isHeaderMode ? 0 : 24,
              child: Container(
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (firstName.isNotEmpty) ...[
                          Text(
                            firstName,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: isHeaderMode ? 14 : 16,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                      ],
                    ),
                    Text(
                      lastName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isHeaderMode ? 22 : 28,
                        fontWeight: FontWeight.w900,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Flag & Country Name directly below driver name
                    _DriverCountryRow(
                      driverNumber: driver.driverNumber.toString(),
                      driverCode: driver.code,
                      isHeaderMode: isHeaderMode,
                    ),

                    if (!isHeaderMode) ...[
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: accentColor.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              driver.broadcastName.isNotEmpty
                                  ? driver.broadcastName
                                  : "#${driver.driverNumber}",
                              style: TextStyle(
                                color: accentColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            driver.teamName ?? '',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),

            // Navigation Arrow
            AnimatedPositioned(
              duration: animDuration,
              curve: animCurve,
              bottom: 20,
              right: isHeaderMode ? -60 : 20,
              child: AnimatedOpacity(
                duration: animDuration,
                opacity: isHeaderMode ? 0.0 : 1.0,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: accentColor, width: 2),
                    color: Colors.black.withValues(alpha: 0.6),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Icon(
                    Icons.arrow_forward,
                    color: accentColor,
                    size: 22,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Sub-widget to load and render Flag + Formatted Country Name
class _DriverCountryRow extends ConsumerWidget {
  final String driverNumber;
  final String driverCode;
  final bool isHeaderMode;

  const _DriverCountryRow({
    required this.driverNumber,
    required this.driverCode,
    required this.isHeaderMode,
  });

  String _formatCountryId(String countryId) {
    if (countryId.isEmpty) return '';
    return countryId
        .split('-')
        .map(
          (word) => word.isNotEmpty
              ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}'
              : '',
        )
        .join(' ');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rhDriverAsync = ref.watch(
      racingHubDriverProvider((number: driverNumber, code: driverCode)),
    );

    return rhDriverAsync.when(
      data: (rhDriver) {
        final statsAsync = ref.watch(driverCareerStatsProvider(rhDriver.id));
        return statsAsync.when(
          data: (stats) {
            final formattedCountry = _formatCountryId(stats.countryId);
            if (formattedCountry.isEmpty) return const SizedBox.shrink();

            return Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FlagWidget(query: formattedCountry, width: 20, height: 14),
                  const SizedBox(width: 6),
                  Text(
                    formattedCountry,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: isHeaderMode ? 12 : 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          },
          loading: () => const SizedBox.shrink(),
          error: (_, _) => const SizedBox.shrink(),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, _) => const SizedBox.shrink(),
    );
  }
}
