import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../models/team.dart';
import '../dashboard_widgets/dashboard_helpers.dart';
import '../dashboard_widgets/dashboard_responsive.dart';

class DashboardHeader extends StatelessWidget {
  final Team team;

  const DashboardHeader({super.key, required this.team});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        dashboardCircleIconButton(context, Icons.menu_rounded, () {}),
        Expanded(
          child: Center(
            /*child: Text(
              team.logoPath,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColors.white,
                fontSize: responsiveFont(context, 22),
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
              ),
            ),*/
            child: SvgPicture.asset(
              team.logoPath,
              width: 72,

              /*colorFilter: const ColorFilter.mode(
                                    Color.fromARGB(255, 79, 76, 76),
                                    BlendMode.srcIn,
                                  ),*/
            ),
          ),
        ),
        Stack(
          clipBehavior: Clip.none,
          children: [
            dashboardCircleIconButton(
              context,
              Icons.notifications_none_rounded,
              () {},
            ),
            Positioned(
              right: 12,
              top: 12,
              child: Container(
                width: contextWidth(context, 0.022),
                height: contextWidth(context, 0.022),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(0, 0, 127, 255),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
