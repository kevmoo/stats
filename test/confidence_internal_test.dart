import 'package:checks/checks.dart';
import 'package:stats/stats.dart';
import 'package:test/scaffolding.dart';

typedef ExpectedValues =
    ({double marginOfError, double tScore, String confidenceLevel});

void main() {
  // Used https://www.statskingdom.com/confidence-interval-calculator.html
  // to calculate target values

  group('set 5', () {
    const threshold = 0.0003;
    const data = [1.0, 2.0, 3.0, 4.0, 5.0];

    final expected = <ConfidenceLevel, ExpectedValues>{
      ConfidenceLevel.percent90: (
        marginOfError: 1.507443319,
        tScore: 2.1318,
        confidenceLevel: 'percent90',
      ),
      ConfidenceLevel.percent95: (
        marginOfError: 1.963243161,
        tScore: 2.7764,
        confidenceLevel: 'percent95',
      ),
      ConfidenceLevel.percent99: (
        marginOfError: 3.255586705,
        tScore: 4.604,
        confidenceLevel: 'percent99',
      ),
    };

    for (var entry in expected.entries) {
      test(
        'calculate confidence interval ${entry.key} correctly for a sample',
        () {
          final interval = ConfidenceInterval.calculate(data.stats, entry.key);
          final actual = interval.toJson()..remove('stats');
          final expectedValue = entry.value;

          check(
            actual['marginOfError'],
          ).isA<num>().isCloseTo(expectedValue.marginOfError, threshold);
          check(actual['tScore']).isA<num>().equals(expectedValue.tScore);
          check(
            actual['confidenceLevel'],
          ).equals(expectedValue.confidenceLevel);

          check(
            actual.keys,
          ).unorderedEquals(['marginOfError', 'tScore', 'confidenceLevel']);
        },
      );
    }
  });

  group('set of 100 - even', () {
    final data = List.generate(101, (index) => index - 50);

    // This is HIGHER because 100 is interpolated
    // Still less than 1% of the target value
    const threshold = 0.016;

    final expected = <ConfidenceLevel, ExpectedValues>{
      ConfidenceLevel.percent90: (
        marginOfError: 4.8404,
        tScore: 1.6602,
        confidenceLevel: 'percent90',
      ),
      ConfidenceLevel.percent95: (
        marginOfError: 5.7842,
        tScore: 1.984,
        confidenceLevel: 'percent95',
      ),
      ConfidenceLevel.percent99: (
        marginOfError: 7.6557,
        tScore: 2.6259,
        confidenceLevel: 'percent99',
      ),
    };

    for (var entry in expected.entries) {
      test(
        'calculate confidence interval ${entry.key} correctly for a sample',
        () {
          final interval = ConfidenceInterval.calculate(data.stats, entry.key);
          final actual = interval.toJson()..remove('stats');
          final expectedValue = entry.value;

          check(
            actual['marginOfError'],
          ).isA<num>().isCloseTo(expectedValue.marginOfError, threshold);
          check(
            actual['tScore'],
          ).isA<num>().isCloseTo(expectedValue.tScore, threshold);
          check(
            actual['confidenceLevel'],
          ).equals(expectedValue.confidenceLevel);

          check(
            actual.keys,
          ).unorderedEquals(['marginOfError', 'tScore', 'confidenceLevel']);
        },
      );
    }
  });

  const bigNumber = 1001;
  group('set of $bigNumber - clustered', () {
    final data = List<double>.generate(
      bigNumber,
      (index) => index / (bigNumber - 1) - 0.5,
    );

    const threshold = 0.00001;

    final expected = <ConfidenceLevel, ExpectedValues>{
      ConfidenceLevel.percent90: (
        marginOfError: 0.0150317,
        tScore: 1.645,
        confidenceLevel: 'percent90',
      ),
      ConfidenceLevel.percent95: (
        marginOfError: 0.01791,
        tScore: 1.96,
        confidenceLevel: 'percent95',
      ),
      ConfidenceLevel.percent99: (
        marginOfError: 0.023539,
        tScore: 2.576,
        confidenceLevel: 'percent99',
      ),
    };

    for (var entry in expected.entries) {
      test(
        'calculate confidence interval ${entry.key} correctly for a sample',
        () {
          final interval = ConfidenceInterval.calculate(data.stats, entry.key);
          final actual = interval.toJson()..remove('stats');
          final expectedValue = entry.value;

          check(
            actual['marginOfError'],
          ).isA<num>().isCloseTo(expectedValue.marginOfError, threshold);

          check(actual['tScore']).isA<num>().equals(expectedValue.tScore);

          check(
            actual['confidenceLevel'],
          ).equals(expectedValue.confidenceLevel);

          check(
            actual.keys,
          ).unorderedEquals(['marginOfError', 'tScore', 'confidenceLevel']);
        },
      );
    }
  });
}
