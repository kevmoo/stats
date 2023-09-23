import 'dart:math' as math;

import 'package:json_annotation/json_annotation.dart';

import 'util.dart';

part 'light_stats.g.dart';

@JsonSerializable()
class LightStats<T extends num> {
  final int count;
  final num average;

  @JsonKey(fromJson: fromJsonGeneric, toJson: toJsonGeneric)
  final T min;

  @JsonKey(fromJson: fromJsonGeneric, toJson: toJsonGeneric)
  final T max;

  LightStats(
    this.count,
    this.average,
    this.min,
    this.max,
  );

  factory LightStats.fromData(Iterable<T> source) {
    num sum = 0;
    var count = 0;

    T? min, max;

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

    return LightStats(count, mean, min!, max!);
  }

  factory LightStats.fromJson(Map<String, dynamic> json) =>
      _$LightStatsFromJson(json);

  static Future<LightStats<T>> fromStream<T extends num>(
    Stream<T> source,
  ) async {
    num sum = 0;
    var count = 0;

    T? min, max;

    await for (var value in source) {
      min = (min == null) ? value : math.min(min, value);
      max = (max == null) ? value : math.max(max, value);
      count++;
      sum += value;
    }

    if (count == 0) {
      throw ArgumentError.value(source, 'source', 'Cannot be empty.');
    }

    final mean = sum / count;

    return LightStats<T>(count, mean, min!, max!);
  }

  Map<String, dynamic> toJson() => _$LightStatsToJson(this);

  LightStats withPrecision(int precision) {
    num fix(num input) {
      if (input is int) {
        return input;
      }

      return double.parse((input as double).toStringAsPrecision(precision));
    }

    return LightStats(
      count,
      fix(average),
      fix(min),
      fix(max),
    );
  }

  @override
  String toString() => toJson().toString();
}
