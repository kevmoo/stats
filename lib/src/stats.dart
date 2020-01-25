import 'dart:math' as math;

import 'package:json_annotation/json_annotation.dart';

part 'stats.g.dart';

@JsonSerializable()
class Stats {
  final int count;
  final num mean;
  final num median;
  final num max;
  final num min;
  final num standardDeviation;
  final num standardError;
  final num rms;

  Stats(this.count, this.mean, this.median, this.max, this.min,
      this.standardDeviation, this.rms)
      : standardError = standardDeviation / math.sqrt(count);

  factory Stats.fromData(Iterable<num> source) {
    assert(source != null);

    final list = source.toList()..sort();

    if (list.isEmpty) {
      throw ArgumentError.value(source, 'source', 'Cannot be empty.');
    }

    final count = list.length;

    final max = list.last;
    final min = list.first;

    num sum = 0;
    num squareSum = 0;
    for (var value in list) {
      sum += value;
      squareSum += value * value;
    }

    final mean = sum / count;
    final ms = squareSum / count;

    // Root Mean Square:  square root of the mean square
    final rms = math.sqrt(ms);

    // variance
    // The average of the squared difference from the Mean

    num sumOfSquaredDiffFromMean = 0;
    for (var value in list) {
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
      median = list[middleIndex];
    } else {
      final secondMiddle = count ~/ 2;
      final firstMiddle = secondMiddle - 1;
      median = (list[firstMiddle] + list[secondMiddle]) / 2.0;
    }

    return Stats(count, mean, median, max, min, standardDeviation, rms);
  }

  Stats withPrecision(int precision) {
    num _fix(num input) {
      if (input is int) {
        return input;
      }

      return double.parse((input as double).toStringAsPrecision(precision));
    }

    return Stats(
      count,
      _fix(mean),
      _fix(median),
      _fix(max),
      _fix(min),
      _fix(standardDeviation),
      _fix(rms),
    );
  }

  factory Stats.fromJson(Map<String, dynamic> json) => _$StatsFromJson(json);

  Map<String, dynamic> toJson() => _$StatsToJson(this);

  @override
  String toString() => toJson().toString();
}
