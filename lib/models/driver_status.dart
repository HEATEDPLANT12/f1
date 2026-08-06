import 'interval.dart';
import 'openf1_driver.dart';
import 'position.dart';
import 'stint.dart';

class DriverStatus {
  final OpenF1Driver driver;
  final Position? position;
  final Interval? interval;
  final Stint? stint;

  const DriverStatus({
    required this.driver,
    required this.interval,
    required this.position,
    required this.stint,
  });
}
