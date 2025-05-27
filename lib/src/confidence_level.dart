/// Supported confidence levels for the simplified t-score lookup.
enum ConfidenceLevel {
  percent90(
    value: 0.90,
    scores: {
      1: 6.314, 2: 2.920, 3: 2.353, 4: 2.1318, 5: 2.015, //
      6: 1.943, 7: 1.895, 8: 1.860, 9: 1.833, 10: 1.812,
      11: 1.796, 12: 1.782, 13: 1.771, 14: 1.761, 15: 1.753,
      16: 1.746, 17: 1.740, 18: 1.734, 19: 1.729, 20: 1.725,
      29: 1.699,
      30: 1.697,
      60: 1.671,
      120: 1.658,
    },
    infinityValue: 1.645,
  ),
  percent95(
    value: .95,
    scores: {
      1: 12.706, 2: 4.303, 3: 3.182, 4: 2.7764, 5: 2.571, //
      6: 2.447, 7: 2.365, 8: 2.306, 9: 2.262, 10: 2.228,
      11: 2.201, 12: 2.179, 13: 2.160, 14: 2.145, 15: 2.131,
      16: 2.120, 17: 2.110, 18: 2.101, 19: 2.093, 20: 2.086,
      29: 2.045,
      30: 2.042,
      60: 2.000,
      120: 1.980,
    },
    infinityValue: 1.960,
  ),
  percent99(
    value: 0.99,
    scores: {
      1: 63.657, 2: 9.925, 3: 5.841, 4: 4.604, 5: 4.032, //
      6: 3.707, 7: 3.499, 8: 3.355, 9: 3.250, 10: 3.169,
      11: 3.106, 12: 3.055, 13: 3.012, 14: 2.977, 15: 2.947,
      16: 2.921, 17: 2.896, 18: 2.878, 19: 2.861, 20: 2.845,
      29: 2.756,
      30: 2.750,
      60: 2.660,
      120: 2.617,
    },
    infinityValue: 2.576,
  );

  const ConfidenceLevel({
    required this.value,
    required this.scores,
    required this.infinityValue,
  });

  /// The confidence level as a percentage between `0` and `1`.
  final double value;

  /// A lookup of degrees of freedom to the t-score for this confidence level.
  final Map<int, double> scores;

  /// The value used for very large degrees of freedom.
  final double infinityValue;
}
