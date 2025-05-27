import 'package:json_annotation/json_annotation.dart';

import 'confidence_level.dart';
import 'stats.dart';
import 't_score.dart';

part 'confidence_interval.g.dart';

/// Represents the calculated confidence interval.
@JsonSerializable()
class ConfidenceInterval {
  ConfidenceInterval({
    required this.stats,
    required this.marginOfError,
    required this.tScore,
    required this.confidenceLevel,
  }) : assert(marginOfError >= 0),
       assert(marginOfError.isFinite);

  factory ConfidenceInterval.fromJson(Map<String, dynamic> json) =>
      _$ConfidenceIntervalFromJson(json);

  final Stats stats;
  final double marginOfError;
  final double tScore;
  final ConfidenceLevel confidenceLevel;

  double get lowerBound => stats.mean - marginOfError;
  double get upperBound => stats.mean + marginOfError;

  /// Calculates the [ConfidenceInterval] for [stats] given a [confidenceLevel].
  static ConfidenceInterval calculate(
    Stats stats,
    ConfidenceLevel confidenceLevel,
  ) {
    if (stats.count < 2) {
      throw ArgumentError.value(
        stats,
        'stats',
        'At least two data points are required '
            'to calculate a confidence interval.',
      );
    }
    final tScore = calcTScore(stats.count - 1, confidenceLevel);

    final se = stats.sampleValues.standardError;

    final marginOfError = tScore * se;

    return ConfidenceInterval(
      stats: stats,
      marginOfError: marginOfError,
      tScore: tScore,
      confidenceLevel: confidenceLevel,
    );
  }

  Map<String, dynamic> toJson() => _$ConfidenceIntervalToJson(this);

  @override
  String toString() => '''
Confidence Level: ${(confidenceLevel.value * 100).toStringAsFixed(0)}%
Margin of Error: ${marginOfError.toStringAsFixed(_toStringPrecision)}
Confidence Interval: [${lowerBound.toStringAsFixed(_toStringPrecision)}, ${upperBound.toStringAsFixed(_toStringPrecision)}]''';
}

const _toStringPrecision = 4;
