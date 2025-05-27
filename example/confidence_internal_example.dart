import 'package:stats/stats.dart';

void main() {
  // Example benchmark data (e.g., response times in milliseconds)
  final benchmarkData = <double>[
    120.5, 130.2, 115.8, 125.1, 140.0, //
    110.3, 135.5, 122.9, 128.7, 132.0,
    121.0, 129.5, 116.0, 124.8, 139.0,
    111.0, 136.0, 123.0, 127.0, 131.0,
    100.0,
  ];

  print('--- Sample Data ---');
  print('Number of items: ${benchmarkData.length}');
  print('Raw Data: $benchmarkData\n');

  final ci95 = benchmarkData.confidenceInterval(ConfidenceLevel.percent95);
  print('95% Confidence Interval:');
  print(ci95);
  print('\n');

  final ci99 = benchmarkData.confidenceInterval(ConfidenceLevel.percent99);
  print('99% Confidence Interval:');
  print(ci99);
  print('\n');

  // --- Example 2: Comparing two sets of benchmark data ---
  print('--- Comparing Two Benchmark Sets ---');
  final oldVersionData = <double>[
    150.0, 160.0, 145.0, 155.0, 170.0, //
    140.0, 165.0, 152.0, 158.0, 162.0,
  ]; // n = 10
  print('Old Version Benchmark Data: $oldVersionData');

  final newVersionData = <double>[
    120.0, 130.0, 115.0, 125.0, 140.0, //
    110.0, 135.0, 122.0, 128.0, 132.0,
  ]; // n = 10
  print('New Version Benchmark Data: $newVersionData\n');

  final ciOld = oldVersionData.confidenceInterval(ConfidenceLevel.percent95);
  print('Old Version 95% CI:');
  print(ciOld);
  print('');

  final ciNew = newVersionData.confidenceInterval(ConfidenceLevel.percent95);
  print('New Version 95% CI:');
  print(ciNew);
  print('');

  print('--- Interpretation for Comparison ---');
  if (ciOld.lowerBound > ciNew.upperBound ||
      ciNew.lowerBound > ciOld.upperBound) {
    print(
      'The confidence intervals DO NOT OVERLAP. '
      'This suggests a statistically significant difference.',
    );
    if (ciOld.average > ciNew.average) {
      print('The New Version is statistically significantly faster/better.');
    } else {
      print('The Old Version is statistically significantly faster/better.');
    }
  } else {
    print(
      'The confidence intervals OVERLAP. This suggests that the difference '
      'between the two versions is not statistically significant at the 95% '
      'confidence level.',
    );
    print(
      'Further runs or a more powerful statistical test '
      '(like a t-test on the difference) might be needed to confirm a '
      'difference, or the difference might be negligible.',
    );
  }
}
