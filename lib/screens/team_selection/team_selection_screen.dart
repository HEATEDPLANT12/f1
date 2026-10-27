import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/teams.dart';
import '../../providers/app/team_provider.dart';

class TeamSelectionScreen extends ConsumerStatefulWidget {
  const TeamSelectionScreen({super.key});

  @override
  ConsumerState<TeamSelectionScreen> createState() =>
      _TeamSelectionScreenState();
}

class _TeamSelectionScreenState extends ConsumerState<TeamSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              TweenAnimationBuilder(
                duration: const Duration(milliseconds: 800),
                tween: Tween(begin: 0.0, end: 1.0),

                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,

                    child: Transform.translate(
                      offset: Offset(0, 20 * (1 - value)),

                      child: child,
                    ),
                  );
                },

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    const Text(
                      "CHOOSE YOUR TEAM",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      "Enter the pit wall",
                      style: TextStyle(color: Colors.white54, fontSize: 15),
                    ),

                    const SizedBox(height: 18),

                    Container(
                      width: 350,
                      height: 2,
                      color: const Color.fromARGB(255, 56, 56, 56),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              Expanded(
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),

                  itemCount: teams.length,

                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 30,
                    childAspectRatio: 1.05,
                  ),

                  itemBuilder: (context, index) {
                    final team = teams[index];

                    return TweenAnimationBuilder(
                      duration: Duration(milliseconds: 500 + (index * 120)),

                      tween: Tween(begin: 0.0, end: 1.0),

                      builder: (context, value, child) {
                        return Opacity(
                          opacity: value,

                          child: Transform.translate(
                            offset: Offset(0, 30 * (1 - value)),

                            child: child,
                          ),
                        );
                      },

                      child: GestureDetector(
                        onTap: () {
                          ref.read(teamProvider.notifier).changeTeam(team);
                          context.go('/main');
                        },

                        child: Container(
                          width: 150,
                          height: 85,

                          decoration: BoxDecoration(
                            color: team.tileColor,

                            borderRadius: BorderRadius.circular(18),

                            /*boxShadow: [
                                  BoxShadow(
                                    color: team.tileColor.withOpacity(0.35),

                                    blurRadius: 18,
                                    spreadRadius: 1,
                                  ),
                                ],*/
                          ),

                          child: Center(
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

                        //const SizedBox(height: 14),

                        /*Text(
                              team.name,

                              textAlign: TextAlign.center,

                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),*/
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
