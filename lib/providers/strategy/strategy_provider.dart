import 'package:flutter_riverpod/flutter_riverpod.dart';

class StrategyState {
  final int pitLap;
  final String tyre;
  final bool rainExpected;

  const StrategyState({
    required this.pitLap,
    required this.tyre,
    required this.rainExpected,
  });

  StrategyState copyWith({int? pitLap, String? tyre, bool? rainExpected}) {
    return StrategyState(
      pitLap: pitLap ?? this.pitLap,
      tyre: tyre ?? this.tyre,
      rainExpected: rainExpected ?? this.rainExpected,
    );
  }
}

class StrategyNotifier extends Notifier<StrategyState> {
  @override
  StrategyState build() {
    return const StrategyState(pitLap: 30, tyre: "Medium", rainExpected: false);
  }

  void changePitLap(int lap) {
    state = state.copyWith(pitLap: lap);
  }

  void changeTyre(String tyre) {
    state = state.copyWith(tyre: tyre);
  }

  void toggleRain() {
    state = state.copyWith(rainExpected: !state.rainExpected);
  }

  String get predictedPosition {
    if (state.pitLap <= 28) return "P3";
    if (state.pitLap <= 32) return "P2";
    return "P4";
  }

  String get predictedWear {
    if (state.pitLap <= 28) return "58%";
    if (state.pitLap <= 32) return "72%";
    return "86%";
  }
}

final strategyProvider = NotifierProvider<StrategyNotifier, StrategyState>(
  StrategyNotifier.new,
);
