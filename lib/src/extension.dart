import 'dart:math' as math;

import '../stats.dart';

extension StatsExtensions<T extends num> on Iterable<T> {
  Stats get stats => Stats.fromData(this);

  ConfidenceInterval confidenceInterval(ConfidenceLevel confidenceLevel) =>
      ConfidenceInterval.calculate(stats, confidenceLevel);

  /// Returns the maximum of all values in `this`.
  T get max => reduce(math.max);

  /// Returns the minimum values in `this`.
  T get min => reduce(math.min);

  /// Returns the sum of all values in `this`.
  T get sum {
    var runningSum = T == int ? 0 : 0.0;
    for (var value in this) {
      runningSum += value;
    }

    return runningSum as T;
  }

  /// Returns the mean (average) of all values in `this`.
  ///
  /// `this` is only enumerated once.
  double get mean {
    var count = 0;
    num runningSum = 0;
    for (var value in this) {
      count++;
      runningSum += value;
    }

    if (count == 0) {
      throw ArgumentError(
        'Cannot calculate the average of an empty collection.',
      );
    }

    return runningSum / count;
  }
}
