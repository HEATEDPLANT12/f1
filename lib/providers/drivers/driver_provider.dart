import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:flutter_riverpod/legacy.dart';
import '../../models/driver.dart';

class DriverNotifier extends Notifier<Driver?> {
  @override
  Driver? build() => null;

  void selectDriver(Driver driver) {
    state = driver;
  }

  void clearSelection() {
    state = null;
  }
}

final driverProvider = NotifierProvider<DriverNotifier, Driver?>(
  DriverNotifier.new,
);
