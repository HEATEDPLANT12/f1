import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReplayState {
  final int currentLap;
  final bool isPlaying;
  final double speed;

  const ReplayState({
    required this.currentLap,
    required this.isPlaying,
    required this.speed,
  });

  ReplayState copyWith({int? currentLap, bool? isPlaying, double? speed}) {
    return ReplayState(
      currentLap: currentLap ?? this.currentLap,
      isPlaying: isPlaying ?? this.isPlaying,
      speed: speed ?? this.speed,
    );
  }
}

class ReplayNotifier extends Notifier<ReplayState> {
  static const int totalLaps = 57;

  @override
  ReplayState build() {
    return const ReplayState(currentLap: 24, isPlaying: false, speed: 1.0);
  }

  void nextLap() {
    if (state.currentLap >= totalLaps) return;

    state = state.copyWith(currentLap: state.currentLap + 1);
  }

  void previousLap() {
    if (state.currentLap <= 1) return;

    state = state.copyWith(currentLap: state.currentLap - 1);
  }

  void togglePlayback() {
    state = state.copyWith(isPlaying: !state.isPlaying);
  }

  void changeSpeed(double speed) {
    state = state.copyWith(speed: speed);
  }
}

final replayProvider = NotifierProvider<ReplayNotifier, ReplayState>(
  ReplayNotifier.new,
);
