import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/driver.dart';

class ComparisonState {
  final Driver? driverA;
  final Driver? driverB;

  const ComparisonState({this.driverA, this.driverB});

  ComparisonState copyWith({Driver? driverA, Driver? driverB}) {
    return ComparisonState(
      driverA: driverA ?? this.driverA,
      driverB: driverB ?? this.driverB,
    );
  }
}

class ComparisonNotifier extends Notifier<ComparisonState> {
  @override
  ComparisonState build() {
    return const ComparisonState();
  }

  void selectDriverA(Driver driver) {
    state = state.copyWith(driverA: driver);
  }

  void selectDriverB(Driver driver) {
    state = state.copyWith(driverB: driver);
  }

  void clear() {
    state = const ComparisonState();
  }

  void swapDrivers() {
    state = ComparisonState(driverA: state.driverB, driverB: state.driverA);
  }
}

final comparisonProvider =
    NotifierProvider<ComparisonNotifier, ComparisonState>(
      ComparisonNotifier.new,
    );
