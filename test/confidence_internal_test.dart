import 'package:stats/src/confidence_interval.dart';
import 'package:stats/src/confidence_level.dart';
import 'package:test/test.dart';

void main() {
  // Used https://www.statskingdom.com/confidence-interval-calculator.html
  // to calculate target values

  group('set 5', () {
    const threshold = 0.0003;
    const data = [1.0, 2.0, 3.0, 4.0, 5.0];

    final shared = {
      'count': 5,
      'mean': 3.0,
      'min': 1.0,
      'max': 5.0,
      'standardDeviation': closeTo(1.58113883, threshold),
    };

    final expected = {
      ConfidenceLevel.percent90: {
        ...shared,
        'marginOfError': closeTo(1.507443319, threshold),
        'tScore': 2.1318,
        'confidenceLevel': 'percent90',
      },
      ConfidenceLevel.percent95: {
        ...shared,
        'marginOfError': closeTo(1.963243161, threshold),
        'tScore': 2.7764,
        'confidenceLevel': 'percent95',
      },
      ConfidenceLevel.percent99: {
        ...shared,
        'marginOfError': closeTo(3.255586705, threshold),
        'tScore': 4.604,
        'confidenceLevel': 'percent99',
      },
    };

    for (var entry in expected.entries) {
      test(
        'calculate confidence interval ${entry.key} correctly for a sample',
        () {
          final interval = ConfidenceInterval.calculate(data, entry.key);
          expect(interval.standardError, closeTo(0.7071, threshold));
          expect(interval.toJson(), entry.value);
        },
      );
    }
  });

  group('set of 100 - even', () {
    final data = List.generate(101, (index) => index - 50);

    // This is HIGHER because 100 is interpolated
    // Still less than 1% of the target value
    const threshold = 0.016;

    final shared = {
      'count': 101,
      'mean': 0,
      'min': -50,
      'max': 50,
      'standardDeviation': closeTo(29.3002, threshold),
    };

    final expected = {
      ConfidenceLevel.percent90: {
        ...shared,
        'marginOfError': closeTo(4.8404, threshold),
        'tScore': closeTo(1.6602, threshold),
        'confidenceLevel': 'percent90',
      },
      ConfidenceLevel.percent95: {
        ...shared,
        'marginOfError': closeTo(5.7842, threshold),
        'tScore': closeTo(1.984, threshold),
        'confidenceLevel': 'percent95',
      },
      ConfidenceLevel.percent99: {
        ...shared,
        'marginOfError': closeTo(7.6557, threshold),
        'tScore': closeTo(2.6259, threshold),
        'confidenceLevel': 'percent99',
      },
    };

    for (var entry in expected.entries) {
      test(
        'calculate confidence interval ${entry.key} correctly for a sample',
        () {
          final interval = ConfidenceInterval.calculate(data, entry.key);
          expect(interval.standardError, closeTo(2.9155, threshold));
          expect(interval.toJson(), entry.value);
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

    final shared = {
      'count': bigNumber,
      'mean': closeTo(0, threshold),
      'min': closeTo(-0.5, threshold),
      'max': closeTo(0.5, threshold),
      'standardDeviation': closeTo(0.2891081112663565, threshold),
    };

    final expected = {
      ConfidenceLevel.percent90: {
        ...shared,
        'marginOfError': closeTo(0.0150317, threshold),
        'tScore': closeTo(1.645, threshold),
        'confidenceLevel': 'percent90',
      },
      ConfidenceLevel.percent95: {
        ...shared,
        'marginOfError': closeTo(0.01791, threshold),
        'tScore': 1.96,
        'confidenceLevel': 'percent95',
      },
      ConfidenceLevel.percent99: {
        ...shared,
        'marginOfError': closeTo(0.023539, threshold),
        'tScore': 2.576,
        'confidenceLevel': 'percent99',
      },
    };

    for (var entry in expected.entries) {
      test(
        'calculate confidence interval ${entry.key} correctly for a sample',
        () {
          final interval = ConfidenceInterval.calculate(data, entry.key);
          expect(interval.standardError, closeTo(0.009138, threshold));
          expect(interval.toJson(), entry.value);
        },
      );
    }
  });
}
