import 'light_stats.dart';
import 'stats.dart';

extension StatsExtensions on Iterable<num> {
  Stats get stats => Stats.fromData(this);

  LightStats get lightStats => LightStats.fromData(this);

  /// Returns the sum of all values in `this`.
  num get sum {
    num runningSum = 0;
    for (var value in this) {
      runningSum += value;
    }

    return runningSum;
  }

  /// Returns the average (mean) of all values in `this`.
  ///
  /// `this` is only enumerated once.
  num get average {
    var count = 0;
    num runningSum = 0;
    for (var value in this) {
      count++;
      runningSum += value;
    }

    return runningSum / count;
  }
}
