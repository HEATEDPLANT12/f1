import 'package:f1/models/race.dart';
import 'package:f1/screens/constructors/constructorstandings_screen.dart';
import 'package:f1/screens/race/race_screen.dart';
import 'package:f1/screens/sessions/sessions_screen.dart';
import 'package:f1/screens/standings/standings_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//import 'screens/dashboard/dashboard_screen.dart';
import 'screens/splash/splash_screen.dart';
import 'screens/team_selection/team_selection_screen.dart';
//import 'models/team.dart';
import 'screens/main/main_shell.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

final GoRouter router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
    GoRoute(
      path: '/team_selection',
      builder: (context, state) => const TeamSelectionScreen(),
    ),

    GoRoute(
      path: '/main',
      builder: (context, state) {
        //final team = state.extra as Team;
        return const MainShell();
      },
    ),

    GoRoute(
      path: '/constructor',
      builder: (context, state) => const SessionsScreen(),
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
