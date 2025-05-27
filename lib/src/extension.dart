import 'dart:math' as math;

import '../stats.dart';

extension StatsExtensions<T extends num> on Iterable<T> {
  Stats<T> get stats => Stats<T>.fromData(this);

  @Deprecated('Will be remove in the next major release.')
  LightStats<T> get lightStats => LightStats<T>.fromData(this);

  ConfidenceInterval confidenceInterval(ConfidenceLevel confidenceLevel) =>
      ConfidenceInterval.calculate(cast<num>(), confidenceLevel);

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

  /// Returns the average (mean) of all values in `this`.
  ///
  /// `this` is only enumerated once.
  @Deprecated('Will be remove in the next major release. Use `mean` instead.')
  double get average {
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

  double get mean => average;
}
