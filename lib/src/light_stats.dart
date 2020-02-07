import 'dart:math' as math;

import 'package:json_annotation/json_annotation.dart';

part 'light_stats.g.dart';

@JsonSerializable()
class LightStats {
  final int count;
  final num average;
  final num max;
  final num min;

  LightStats(
    this.count,
    this.average,
    this.max,
    this.min,
  );

  factory LightStats.fromData(Iterable<num> source) {
    assert(source != null);

    num sum = 0;
    var count = 0;

    num min, max;

    for (var value in source) {
      min = (min == null) ? value : math.min(min, value);
      max = (max == null) ? value : math.max(max, value);
      count++;
      sum += value;
    }

    if (count == 0) {
      throw ArgumentError.value(source, 'source', 'Cannot be empty.');
    }

    final mean = sum / count;

    return LightStats(count, mean, max, min);
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
    );
  }

  @override
  String toString() => toJson().toString();
}
