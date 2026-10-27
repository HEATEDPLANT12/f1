import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import 'dashboard_responsive.dart';

Widget dashboardCard(
  BuildContext context, {
  required Widget child,
  String? backgroundImage,
}) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(contextWidth(context, 0.04)),
    decoration: BoxDecoration(
      color: AppColors.card,
      borderRadius: BorderRadius.circular(AppRadius.lg),
      border: Border.all(color: AppColors.border),
      image: backgroundImage == null
          ? null
          : DecorationImage(
              image: AssetImage(backgroundImage),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withValues(alpha: 0.45),
                BlendMode.darken,
              ),
            ),
    ),
    child: child,
  );
}

Widget dashboardSectionLabel(String text, Color color) {
  return Text(text, style: AppTextStyles.section(color));
}

Widget dashboardSectionHeader(
  BuildContext context,
  String title,
  String action,
  Color color,
) {
  return Row(
    children: [
      Expanded(child: dashboardSectionLabel(title, color)),
      Text(
        action,
        style: TextStyle(
          color: AppColors.white54,
          fontSize: responsiveFont(context, 11),
        ),
      ),
      const Icon(
        Icons.chevron_right_rounded,
        color: AppColors.white54,
        size: 18,
      ),
    ],
  );
}

Widget dashboardSessionBadge(String text) {
  return Container(
    padding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.md,
      vertical: AppSpacing.xs,
    ),
    decoration: BoxDecoration(
      color: AppColors.red.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(AppRadius.lg),
      border: Border.all(color: AppColors.red.withValues(alpha: 0.5)),
    ),
    child: Text(
      text,
      style: const TextStyle(
        color: AppColors.white,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}

Widget dashboardSessionMetric(
  BuildContext context,
  String label,
  String value, {
  bool accentFirst = false,
}) {
  final parts = value.split(' ');

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: TextStyle(
          color: AppColors.white54,
          fontSize: responsiveFont(context, 10),
        ),
      ),
      Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: parts.first,
              style: TextStyle(
                color: accentFirst ? AppColors.orange : AppColors.white,
                fontSize: responsiveFont(context, 22),
                fontWeight: FontWeight.w700,
              ),
            ),
            if (parts.length > 1)
              TextSpan(
                text: ' ${parts.sublist(1).join(' ')}',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: responsiveFont(context, 15),
                ),
              ),
          ],
        ),
      ),
    ],
  );
}

Widget dashboardSmallMetric(
  BuildContext context,
  String title,
  String value, {
  bool accent = false,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(
          color: AppColors.white54,
          fontSize: responsiveFont(context, 9),
        ),
      ),
      SizedBox(height: AppSpacing.xs),
      Text(
        value,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: accent ? AppColors.orange : AppColors.white,
          fontSize: responsiveFont(context, 12),
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  );
}

Widget dashboardTyreIcon(BuildContext context) {
  final size = contextWidth(context, 0.075);

  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: AppColors.yellow, width: 2),
    ),
    child: Center(
      child: Text(
        'M',
        style: TextStyle(
          color: AppColors.yellow,
          fontSize: size * 0.4,
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
  );
}

Widget dashboardVerticalDivider(BuildContext context) {
  return Container(
    width: 1,
    height: contextHeight(context, 0.065),
    color: AppColors.divider,
    margin: EdgeInsets.symmetric(horizontal: contextWidth(context, 0.018)),
  );
}

Widget dashboardInfoItem(
  BuildContext context,
  IconData icon,
  Color color,
  String title,
  String value,
  String subtitle,
) {
  return Column(
    children: [
      Icon(icon, color: color, size: contextWidth(context, 0.065)),
      SizedBox(height: AppSpacing.xs),
      Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.white54,
          fontSize: responsiveFont(context, 8.5),
        ),
      ),
      SizedBox(height: AppSpacing.xs),
      Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: color,
          fontSize: responsiveFont(context, 12),
          fontWeight: FontWeight.w600,
        ),
      ),
      if (subtitle.isNotEmpty)
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.white54,
            fontSize: responsiveFont(context, 8.5),
          ),
        ),
    ],
  );
}

Widget dashboardWeatherStat(BuildContext context, String value, String label) {
  return Padding(
    padding: EdgeInsets.only(bottom: AppSpacing.sm),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          value,
          style: TextStyle(
            color: AppColors.white,
            fontSize: responsiveFont(context, 12),
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          label,
          textAlign: TextAlign.right,
          style: TextStyle(
            color: AppColors.white54,
            fontSize: responsiveFont(context, 8),
          ),
        ),
      ],
    ),
  );
}

Widget dashboardNextSessionItem(
  BuildContext context,
  IconData icon,
  Color color,
  String title,
  String day,
  String time,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(icon, color: color, size: contextWidth(context, 0.07)),
      SizedBox(height: AppSpacing.sm),
      Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: AppColors.white,
          fontSize: responsiveFont(context, 11),
          fontWeight: FontWeight.w600,
        ),
      ),
      SizedBox(height: AppSpacing.xs),
      Text(
        day,
        style: TextStyle(
          color: AppColors.white54,
          fontSize: responsiveFont(context, 9),
        ),
      ),
      Text(
        time,
        style: TextStyle(
          color: AppColors.white70,
          fontSize: responsiveFont(context, 9),
        ),
      ),
    ],
  );
}

Widget dashboardDashedLine(BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: contextWidth(context, 0.01)),
    child: SizedBox(
      width: contextWidth(context, 0.04),
      child: const Divider(color: AppColors.white54),
    ),
  );
}

Widget dashboardCircleIconButton(
  BuildContext context,
  IconData icon,
  VoidCallback onTap,
) {
  return IconButton(
    onPressed: onTap,
    padding: EdgeInsets.zero,
    constraints: const BoxConstraints(),
    icon: Icon(icon, color: AppColors.white, size: contextWidth(context, 0.07)),
  );
}
