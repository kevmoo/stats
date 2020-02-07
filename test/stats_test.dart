import 'dart:math' as math;

import 'package:stats/stats.dart';
import 'package:test/test.dart';

Stats _validateJson<T extends num>(
  Iterable<T> values,
  T expectedSum,
  Map<String, dynamic> expectedJson,
) {
  final stats = values.stats;
  expect(stats.toJson(), expectedJson);

  final lightStats = values.lightStats;
  for (var entry in lightStats.toJson().entries) {
    expect(expectedJson, containsPair(entry.key, entry.value));
  }

  expect(values.sum, expectedSum);
  expect(stats.average, values.average);
  expect(stats.min, values.min);
  expect(stats.max, values.max);
  return stats;
}

void main() {
  test('empty source is not allowed', () {
    final matcher = throwsA(
      isArgumentError.having((e) => e.message, 'message', 'Cannot be empty.'),
    );

    expect(() => <num>[].stats, matcher);
    expect(() => <num>[].lightStats, matcher);
  });

  group('empty', () {
    test('sum', () {
      expect(<num>[].sum, 0);
      expect(<int>[].sum, 0);
      expect(<double>[].sum, 0);
    });

    test('max', () {
      expect(() => <num>[].max, throwsStateError);
    });

    test('min', () {
      expect(() => <num>[].min, throwsStateError);
    });

    test('average', () {
      expect(() => <num>[].average, throwsArgumentError);
    });
  });

  test('trivial', () {
    _validateJson(
      [0],
      0,
      {
        'count': 1,
        'average': 0.0,
        'median': 0,
        'max': 0,
        'min': 0,
        'standardDeviation': 0.0,
      },
    );
  });

  test('two simple values', () {
    _validateJson(
      [0, 2],
      2,
      {
        'count': 2,
        'average': 1.0,
        'min': 0,
        'max': 2,
        'median': 1.0,
        'standardDeviation': 1.0,
      },
    );
  });

  test('precesion', () {
    final stats = _validateJson(
      Iterable.generate(100, math.sqrt),
      661.4629471031477,
      {
        'count': 100,
        'average': 6.614629471031477,
        'median': 7.035533905932738,
        'max': 9.9498743710662,
        'min': 0.0,
        'standardDeviation': 2.3972227599791047,
      },
    );

    expect(
      stats.withPrecision(4).toJson(),
      {
        'count': 100,
        'average': 6.615,
        'median': 7.036,
        'max': 9.95,
        'min': 0.0,
        'standardDeviation': 2.397,
      },
    );

    expect(
      stats.withPrecision(1).toJson(),
      {
        'count': 100,
        'average': 7.0,
        'median': 7.0,
        'max': 10.0,
        'min': 0.0,
        'standardDeviation': 2.0,
      },
    );
  });
}
