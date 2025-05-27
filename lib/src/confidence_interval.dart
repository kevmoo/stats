import 'package:json_annotation/json_annotation.dart';

import 'confidence_level.dart';
import 'stats.dart';
import 't_score.dart';
import 'util.dart';

part 'confidence_interval.g.dart';

/// Represents the calculated confidence interval.
@JsonSerializable()
class ConfidenceInterval extends Stats<double> {
  ConfidenceInterval({
    required int count,
    required double mean,
    required double standardDeviation,
    required double min,
    required double max,
    required this.marginOfError,
    required this.tScore,
    required this.confidenceLevel,
  }) : assert(marginOfError >= 0),
       assert(marginOfError.isFinite),
       super(count, mean, min, max, standardDeviation);

  factory ConfidenceInterval.fromJson(Map<String, dynamic> json) =>
      _$ConfidenceIntervalFromJson(json);

  final double marginOfError;
  final double tScore;
  final ConfidenceLevel confidenceLevel;

  double get lowerBound => mean - marginOfError;
  double get upperBound => mean + marginOfError;

  /// Calculates the [ConfidenceInterval] for [data] given a [confidenceLevel].
  ///
  /// NOTE: [data] is copied to a list and sorted.
  static ConfidenceInterval calculate(
    Iterable<num> data,
    ConfidenceLevel confidenceLevel,
  ) {
    final list = data.toList()..sort();
    final length = list.length;

    if (length < 2) {
      throw ArgumentError.value(
        data,
        'data',
        'At least two data points are required '
            'to calculate a confidence interval.',
      );
    }
    final tScore = calcTScore(length - 1, confidenceLevel);

    final stats = Stats.fromSortedList(list, besselCorrection: true);
    final se = stats.standardError;
    final marginOfError = tScore * se;

    return ConfidenceInterval(
      count: length,
      min: stats.min.toDouble(),
      max: stats.max.toDouble(),
      mean: stats.mean,
      standardDeviation: stats.standardDeviation,
      marginOfError: marginOfError,
      tScore: tScore,
      confidenceLevel: confidenceLevel,
    );
  }

  @override
  Map<String, dynamic> toJson() => _$ConfidenceIntervalToJson(this);

  @override
  String toString() => '''
Mean: ${mean.toStringAsFixed(_toStringPrecision)}
Standard Deviation: ${standardDeviation.toStringAsFixed(_toStringPrecision)}
Confidence Level: ${(confidenceLevel.value * 100).toStringAsFixed(0)}%
Margin of Error: ${marginOfError.toStringAsFixed(_toStringPrecision)}
Confidence Interval: [${lowerBound.toStringAsFixed(_toStringPrecision)}, ${upperBound.toStringAsFixed(_toStringPrecision)}]''';
}

const _toStringPrecision = 4;
