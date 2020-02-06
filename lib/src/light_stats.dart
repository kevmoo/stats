import 'dart:math' as math;

import 'package:json_annotation/json_annotation.dart';

part 'light_stats.g.dart';

@JsonSerializable()
class LightStats {
  final int count;
  final num average;
  final num max;
  final num min;
  final num rms;

  LightStats(
    this.count,
    this.average,
    this.max,
    this.min,
    this.rms,
  );

  factory LightStats.fromData(Iterable<num> source) {
    assert(source != null);

    num sum = 0;
    num squareSum = 0;
    var count = 0;

    num min, max;

    for (var value in source) {
      min = (min == null) ? value : math.min(min, value);
      max = (max == null) ? value : math.max(max, value);
      count++;
      sum += value;
      squareSum += value * value;
    }

    if (count == 0) {
      throw ArgumentError.value(source, 'source', 'Cannot be empty.');
    }

    final mean = sum / count;
    final rootMeanSquared = squareSum / count;

    // Root Mean Square:  square root of the mean square
    final rms = math.sqrt(rootMeanSquared);

    return LightStats(count, mean, max, min, rms);
  }

  factory LightStats.fromJson(Map<String, dynamic> json) =>
      _$LightStatsFromJson(json);

  Map<String, dynamic> toJson() => _$LightStatsToJson(this);

  LightStats withPrecision(int precision) {
    num _fix(num input) {
      if (input is int) {
        return input;
      }

      return double.parse((input as double).toStringAsPrecision(precision));
    }

    return LightStats(
      count,
      _fix(average),
      _fix(max),
      _fix(min),
      _fix(rms),
    );
  }

  @override
  String toString() => toJson().toString();
}
