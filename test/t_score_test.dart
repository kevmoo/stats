import 'package:stats/src/confidence_level.dart';
import 'package:stats/src/t_score.dart';
import 'package:test/test.dart';

void main() {
  group('t-scores for confidence levels', () {
    for (var level in ConfidenceLevel.values) {
      test(level, () {
        expect(
          level.scores,
          hasLength(ConfidenceLevel.percent95.scores.length),
        );
        expect(
          level.scores.keys,
          orderedEquals(ConfidenceLevel.percent95.scores.keys),
        );
        expect(level.scores.keys.first, 1);
        expect(level.scores.keys.last, biggestSpecifiedDF);

        MapEntry<int, double>? previous;
        for (var entry in level.scores.entries) {
          if (previous == null) {
            previous = entry;
            continue;
          }
          expect(entry.key, greaterThan(previous.key));
          expect(entry.value, lessThan(previous.value));
          previous = entry;
        }
      });
    }
  });

  group('Exact Matches', () {
    test('should return exact t-score for percent95, df=1', () {
      expect(calcTScore(1, ConfidenceLevel.percent95), 12.706);
    });

    test('should return exact t-score for percent90, df=10', () {
      expect(calcTScore(10, ConfidenceLevel.percent90), 1.812);
    });

    test('should return exact t-score for percent99, df=20', () {
      expect(calcTScore(20, ConfidenceLevel.percent99), 2.845);
    });

    test('should return exact t-score for percent95, df=120', () {
      expect(calcTScore(120, ConfidenceLevel.percent95), 1.980);
    });
  });

  group('Infinity Key (Large DF)', () {
    test('should return infinity t-score for percent95, df=120 '
        '(boundary of largest specific)', () {
      expect(calcTScore(121, ConfidenceLevel.percent95), 1.960);
      expect(calcTScore(200, ConfidenceLevel.percent95), 1.960);
      expect(calcTScore(1000000, ConfidenceLevel.percent95), 1.960);
    });

    test('should return infinity t-score for percent90, df=500', () {
      expect(calcTScore(500, ConfidenceLevel.percent90), 1.645);
    });

    test('should return infinity t-score for percent99, df=1000', () {
      expect(calcTScore(1000, ConfidenceLevel.percent99), 2.576);
    });
  });

  group('Interpolation', () {
    test('should interpolate for percent95, df=17 (between 16 and 18)', () {
      expect(
        calcTScore(17, ConfidenceLevel.percent95),
        closeTo(2.11, 0.000001),
      );
    });

    test('should interpolate for percent90, df=25 (between 20 and 29)', () {
      expect(
        calcTScore(25, ConfidenceLevel.percent90),
        closeTo(1.710555, 0.000001),
      );
    });

    test('should interpolate for percent99, df=40 (between 30 and 60)', () {
      expect(
        calcTScore(40, ConfidenceLevel.percent99),
        closeTo(2.720, 0.00001),
      );
    });

    test(
      'should interpolate for percent95, df=2 (exact match, but tests loop)',
      () {
        // This will hit the exact match, but good to ensure loop logic is
        // sound
        expect(calcTScore(2, ConfidenceLevel.percent95), 4.303);
      },
    );
  });

  test(
    'should throw ArgumentError if df is below smallest tabulated value',
    () {
      expect(
        () => calcTScore(0, ConfidenceLevel.percent95),
        throwsA(
          isA<ArgumentError>().having(
            (e) => e.message,
            'message',
            'Degrees of freedom must be at least 1.', // Current error message
          ),
        ),
      );
    },
  );
}
