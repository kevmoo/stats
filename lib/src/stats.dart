import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;

import 'package:json_annotation/json_annotation.dart';

import 'stats_sinks.dart';

part 'stats.g.dart';

@JsonSerializable()
/// Represents important statistical values of a collection of numbers.
class Stats {
  Stats({
    required this.count,
    required this.mean,
    required this.min,
    required this.max,
    required this.sumOfSquares,
  }) : assert(count > 0),
       assert(sumOfSquares.isFinite),
       assert(sumOfSquares >= 0),
       assert(mean >= min),
       assert(mean <= max),
       assert(mean.isFinite),
       assert(min.isFinite),
       assert(max.isFinite);

  /// The number of items in the source collection.
  final int count;

  /// The minimum value in the source collection.
  final num min;

  /// The maximum value in the source collection.
  final num max;

  /// The mean (average) value in the source collection.
  final double mean;

  /// The sum of all of each value in the source collection squared.
  ///
  /// Important for many other statistical calculations.
  final double sumOfSquares;

  /// Represents three typical statistical values related to [Stats].
  ///
  /// * `variance` is [Stats.sumOfSquares]`/`[Stats.count].
  /// * `standardDeviation` is the square-root of `variance`.
  /// * `standardError` is `standardDeviation` divided by the square-root of
  ///   `count`.
  ({double variance, double standardDeviation, double standardError})
  get populationValues => _values(population: true);

  /// Represents three typical statistical values related to [Stats].
  ///
  /// * `variance` is [Stats.sumOfSquares]`/(`[Stats.count]`-1)`.
  /// * `standardDeviation` is the square-root of `variance`.
  /// * `standardError` is `standardDeviation` divided by the square-root of
  ///   `count`.
  ({double variance, double standardDeviation, double standardError})
  get sampleValues => _values(population: false);

  /// Assumes all values in [source] are [num.isFinite].
  factory Stats.fromData(Iterable<num> source) {
    final state = StatsSink();
    for (final value in source) {
      state.add(value);
    }
    return state.emit();
  }

  /// Assumes all values in [source] are [num.isFinite].
  static Future<Stats> fromStream(Stream<num> source) async {
    final state = StatsSink();
    await for (final value in source) {
      state.add(value);
    }
    return state.emit();
  }

  static const Converter<num, Stats> transformer = StatsConverter();

  Stats withPrecision(int precision) {
    double fixDouble(double input) =>
        double.parse(input.toStringAsPrecision(precision));

    num fix(num input) => input is int ? input : fixDouble(input as double);

    return Stats(
      count: count,
      mean: fixDouble(mean),
      min: fix(min),
      max: fix(max),
      sumOfSquares: fixDouble(sumOfSquares),
    );
  }

  factory Stats.fromJson(Map<String, dynamic> json) => _$StatsFromJson(json);

  Map<String, dynamic> toJson() => _$StatsToJson(this);

  ({double variance, double standardDeviation, double standardError}) _values({
    required bool population,
  }) {
    final variance =
        population
            ? sumOfSquares / count
            : count == 1
            ? double.nan
            : sumOfSquares / (count - 1);
    final standardDeviation = math.sqrt(variance);
    return (
      variance: variance,
      standardDeviation: standardDeviation,
      standardError: standardDeviation / math.sqrt(count),
    );
  }
}
