import 'dart:math' as math;

import 'package:json_annotation/json_annotation.dart';

import 'light_stats.dart';

part 'stats.g.dart';

@JsonSerializable()
class Stats implements LightStats {
  @override
  final int count;
  @override
  final num average;
  final num median;
  @override
  final num max;
  @override
  final num min;
  final num standardDeviation;

  Stats(
    this.count,
    this.average,
    this.median,
    this.max,
    this.min,
    this.standardDeviation,
  );

  /// Note: the implementation creates a [List] from [source] and sorts it.
  /// For large inputs, this can be memory intensive and/or slow.
  /// Consider using [LightStats] for large inputs.
  factory Stats.fromData(Iterable<num> source) {
    assert(source != null);

    final list = source.toList()..sort();
    return Stats.fromSortedList(list);
  }

  /// [source] must be sorted (lowest value first) or the output will be
  /// inaccurate.
  factory Stats.fromSortedList(List<num> source) {
    if (source.isEmpty) {
      throw ArgumentError.value(source, 'source', 'Cannot be empty.');
    }

    final count = source.length;

    final max = source.last;
    final min = source.first;

    num sum = 0;
    for (var value in source) {
      sum += value;
    }

    final mean = sum / count;

    // variance
    // The average of the squared difference from the Mean
    num sumOfSquaredDiffFromMean = 0;
    for (var value in source) {
      final squareDiffFromMean = math.pow(value - mean, 2);
      sumOfSquaredDiffFromMean += squareDiffFromMean;
    }

    final variance = sumOfSquaredDiffFromMean / count;

    // standardDeviation: sqrt of the variance
    final standardDeviation = math.sqrt(variance);

    num median;
    // if length is odd, take middle value
    if (count % 2 == 1) {
      final middleIndex = (count / 2 - 0.5).toInt();
      median = source[middleIndex];
    } else {
      final secondMiddle = count ~/ 2;
      final firstMiddle = secondMiddle - 1;
      median = (source[firstMiddle] + source[secondMiddle]) / 2.0;
    }

    return Stats(count, mean, median, max, min, standardDeviation);
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
      _fix(median),
      _fix(max),
      _fix(min),
      _fix(standardDeviation),
    );
  }

  factory Stats.fromJson(Map<String, dynamic> json) => _$StatsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$StatsToJson(this);
}
