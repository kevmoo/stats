import 'dart:math' as math;

import 'package:json_annotation/json_annotation.dart';

import 'light_stats.dart';
import 'util.dart';

part 'stats.g.dart';

@JsonSerializable()
class Stats<T extends num> extends LightStats<T> {
  final num median;
  final num standardDeviation;

  Stats(
    int count,
    num average,
    T min,
    T max,
    this.median,
    this.standardDeviation,
  ) : super(count, average, min, max);

  /// Note: the implementation creates a [List] from [source] and sorts it.
  /// For large inputs, this can be memory intensive and/or slow.
  /// Consider using [LightStats] for large inputs.
  factory Stats.fromData(Iterable<T> source) {
    assert(source != null);

    final list = source.toList()..sort();
    return Stats.fromSortedList(list);
  }

  /// [source] must be sorted (lowest value first) or the output will be
  /// inaccurate.
  factory Stats.fromSortedList(List<T> source) {
    if (source.isEmpty) {
      throw ArgumentError.value(source, 'source', 'Cannot be empty.');
    }

    final count = source.length;
    final min = source.first;
    final max = source.last;

    num sum = 0;
    for (var value in source) {
      sum += value;
    }

    final average = sum / count;

    // variance
    // The average of the squared difference from the Mean
    num sumOfSquaredDiffFromMean = 0;
    for (var value in source) {
      final squareDiffFromMean = math.pow(value - average, 2);
      sumOfSquaredDiffFromMean += squareDiffFromMean;
    }

    final variance = sumOfSquaredDiffFromMean / count;

    // standardDeviation: sqrt of the variance
    final standardDeviation = math.sqrt(variance);

    final middleIndex = count ~/ 2;
    num median = source[middleIndex];
    // if length is even, average the "middle" values
    if (count.isEven) {
      median = (source[middleIndex - 1] + median) / 2.0;
    }

    return Stats(count, average, min, max, median, standardDeviation);
  }

  num get standardError => standardDeviation / math.sqrt(count);

  @override
  Stats withPrecision(int precision) {
    num _fix(num input) {
      if (input is int) {
        return input;
      }

      return double.parse((input as double).toStringAsPrecision(precision));
    }

    return Stats(
      count,
      _fix(average),
      _fix(min),
      _fix(max),
      _fix(median),
      _fix(standardDeviation),
    );
  }

  factory Stats.fromJson(Map<String, dynamic> json) => _$StatsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$StatsToJson(this);
}
