import 'dart:math' as math;

import 'package:json_annotation/json_annotation.dart';

import 'light_stats.dart';
import 'util.dart';

part 'stats.g.dart';

@JsonSerializable()
class Stats<T extends num> extends LightStats<T> {
  @Deprecated('Will be remove in the next major release.')
  final num median;
  final double standardDeviation;

  Stats(
    super.count,
    super.average,
    super.min,
    super.max,
    this.median,
    this.standardDeviation,
  ) : assert(median.isFinite),
      assert(min <= median),
      assert(median <= max),
      assert(standardDeviation.isFinite),
      assert(standardDeviation >= 0);

  /// Note: the implementation creates a [List] from [source] and sorts it.
  /// For large inputs, this can be memory intensive and/or slow.
  /// Consider using [LightStats] for large, unsorted inputs.
  ///
  /// If [besselCorrection] is `true`, the use `source.length - 1` to calculate
  /// the variance. This is important for calculating confidence.
  factory Stats.fromData(Iterable<T> source, {bool besselCorrection = false}) {
    final list = source.toList()..sort();
    return Stats.fromSortedList(list, besselCorrection: besselCorrection);
  }

  /// [source] must be sorted (lowest value first) or the output will be
  /// inaccurate.
  ///
  /// If [besselCorrection] is `true`, the use `source.length - 1` to calculate
  /// the variance. This is important for calculating confidence.
  factory Stats.fromSortedList(
    List<T> source, {
    bool besselCorrection = false,
  }) {
    if (source.isEmpty) {
      throw ArgumentError.value(source, 'source', 'Cannot be empty.');
    }
    if (besselCorrection && source.length < 2) {
      throw ArgumentError.value(
        source,
        'source',
        'Must have at least two elements if besselCorrection is true.',
      );
    }

    final min = source.first;
    final max = source.last;

    var count = 0;
    var mean = 0.0;
    var m2 = 0.0;

    for (var value in source) {
      count++;
      final delta = value - mean;
      mean += delta / count;
      final delta2 = value - mean; // Use the new mean for delta2
      m2 += delta * delta2;
    }

    final variance =
        m2 / (besselCorrection ? (count - 1) : count); // Bessel's correction;

    final standardDeviation = math.sqrt(variance);

    final middleIndex = count ~/ 2;
    num median = source[middleIndex];
    // if length is even, average the "middle" values
    if (count.isEven) {
      median = (source[middleIndex - 1] + median) / 2.0;
    }

    return Stats(count, mean, min, max, median, standardDeviation);
  }

  double get standardError => standardDeviation / math.sqrt(count);

  @override
  Stats withPrecision(int precision) {
    num fix(num input) {
      if (input is int) {
        return input;
      }

      return double.parse((input as double).toStringAsPrecision(precision));
    }

    return Stats(
      count,
      fix(mean).toDouble(),
      fix(min),
      fix(max),
      fix(median),
      fix(standardDeviation).toDouble(),
    );
  }

  factory Stats.fromJson(Map<String, dynamic> json) => _$StatsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$StatsToJson(this);
}
