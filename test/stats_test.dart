import 'dart:math' as math;

import 'package:stats/stats.dart';
import 'package:test/test.dart';

Stats _validateJson(
  Iterable<num> values,
  num expectedSum,
  Map<String, dynamic> expectedJson,
) {
  final stats = values.stats;
  expect(stats.toJson(), expectedJson);
  expect(values.sum, expectedSum);
  expect(stats.average, values.average);
  return stats;
}

void main() {
  test('empty source is not allowed', () {
    expect(
        () => <num>[].stats,
        throwsA(isArgumentError.having(
            (e) => e.message, 'message', 'Cannot be empty.')));
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
        'rms': 0.0
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
        'median': 1.0,
        'max': 2,
        'min': 0,
        'standardDeviation': 1.0,
        'rms': 1.4142135623730951
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
        'rms': 7.035623639735144
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
        'rms': 7.036
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
        'rms': 7.0
      },
    );
  });
}
