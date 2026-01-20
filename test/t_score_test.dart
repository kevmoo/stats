import 'package:checks/checks.dart';
import 'package:stats/src/confidence_level.dart';
import 'package:stats/src/t_score.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('t-scores for confidence levels', () {
    for (var level in ConfidenceLevel.values) {
      test(level, () {
        check(
          level.scores,
        ).length.equals(ConfidenceLevel.percent95.scores.length);
        check(
          level.scores.keys,
        ).deepEquals(ConfidenceLevel.percent95.scores.keys);
        check(level.scores.keys.first).equals(1);
        check(level.scores.keys.last).equals(biggestSpecifiedDF);

        MapEntry<int, double>? previous;
        for (var entry in level.scores.entries) {
          if (previous == null) {
            previous = entry;
            continue;
          }
          check(entry.key).isGreaterThan(previous.key);
          check(entry.value).isLessThan(previous.value);
          previous = entry;
        }
      });
    }
  });

  group('Exact Matches', () {
    test('should return exact t-score for percent95, df=1', () {
      check(calcTScore(1, ConfidenceLevel.percent95)).equals(12.706);
    });

    test('should return exact t-score for percent90, df=10', () {
      check(calcTScore(10, ConfidenceLevel.percent90)).equals(1.812);
    });

    test('should return exact t-score for percent99, df=20', () {
      check(calcTScore(20, ConfidenceLevel.percent99)).equals(2.845);
    });

    test('should return exact t-score for percent95, df=120', () {
      check(calcTScore(120, ConfidenceLevel.percent95)).equals(1.980);
    });
  });

  group('Infinity Key (Large DF)', () {
    test('should return infinity t-score for percent95, df=120 '
        '(boundary of largest specific)', () {
      check(calcTScore(121, ConfidenceLevel.percent95)).equals(1.960);
      check(calcTScore(200, ConfidenceLevel.percent95)).equals(1.960);
      check(calcTScore(1000000, ConfidenceLevel.percent95)).equals(1.960);
    });

    test('should return infinity t-score for percent90, df=500', () {
      check(calcTScore(500, ConfidenceLevel.percent90)).equals(1.645);
    });

    test('should return infinity t-score for percent99, df=1000', () {
      check(calcTScore(1000, ConfidenceLevel.percent99)).equals(2.576);
    });
  });

  group('Interpolation', () {
    test('should interpolate for percent95, df=17 (between 16 and 18)', () {
      check(
        calcTScore(17, ConfidenceLevel.percent95),
      ).isCloseTo(2.11, 0.000001);
    });

    test('should interpolate for percent90, df=25 (between 20 and 29)', () {
      check(
        calcTScore(25, ConfidenceLevel.percent90),
      ).isCloseTo(1.710555, 0.000001);
    });

    test('should interpolate for percent99, df=40 (between 30 and 60)', () {
      check(
        calcTScore(40, ConfidenceLevel.percent99),
      ).isCloseTo(2.720, 0.00001);
    });

    test(
      'should interpolate for percent95, df=2 (exact match, but tests loop)',
      () {
        // This will hit the exact match, but good to ensure loop logic is
        // sound
        check(calcTScore(2, ConfidenceLevel.percent95)).equals(4.303);
      },
    );
  });

  test(
    'should throw ArgumentError if df is below smallest tabulated value',
    () {
      check(() => calcTScore(0, ConfidenceLevel.percent95))
          .throws<ArgumentError>()
          .has((e) => e.message as String, 'message')
          .contains('Degrees of freedom must be at least 1.');
    },
  );
}
