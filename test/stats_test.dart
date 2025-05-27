import 'dart:math' as math;

import 'package:checks/checks.dart';
import 'package:stats/stats.dart';
import 'package:test/scaffolding.dart';

Stats _validateJson(
  Iterable<num> values,
  num expectedSum,
  Map<String, dynamic> expectedJson,
) {
  final stats = values.stats;

  check(stats.toJson()).deepEquals(expectedJson);

  check(values.sum).equals(expectedSum);
  check(stats.mean).isCloseTo(values.mean, 0.0000001);
  check(stats.min).equals(values.min);
  check(stats.max).equals(values.max);
  return stats;
}

void main() {
  test('empty source is not allowed', () {
    check(() => <num>[].stats).throws<ArgumentError>().which(
      (it) => it.has((p0) => p0.message, 'message').equals('Cannot be empty.'),
    );
  });

  group('empty', () {
    test('sum', () {
      check(<num>[].sum).equals(0);
      check(<int>[].sum).equals(0);
      check(<double>[].sum).equals(0);
    });

    test('max', () {
      check(() => <num>[].max).throws<StateError>();
    });

    test('min', () {
      check(() => <num>[].min).throws<StateError>();
    });

    test('mean', () {
      check(() => <num>[].mean).throws<ArgumentError>();
    });
  });

  test('trivial', () {
    _validateJson(
      [0],
      0,
      {'count': 1, 'mean': 0.0, 'max': 0, 'min': 0, 'sumOfSquares': 0.0},
    );
  });

  test('two simple values', () {
    _validateJson(
      [0, 2],
      2,
      {'count': 2, 'mean': 1.0, 'min': 0, 'max': 2, 'sumOfSquares': 2.0},
    );
  });

  test('10 values', () {
    _validateJson(Iterable.generate(10, (i) => i), 45, {
      'count': 10,
      'mean': 4.5,
      'min': 0,
      'max': 9,
      'sumOfSquares': 82.5,
    });
  });

  test('11 values', () {
    _validateJson(Iterable.generate(11, (i) => i), 55, {
      'count': 11,
      'mean': 5.0,
      'min': 0,
      'max': 10,
      'sumOfSquares': 110.0,
    });
  });

  test('precision', () {
    final stats =
        _validateJson(Iterable.generate(100, math.sqrt), 661.4629471031477, {
          'count': 100,
          'mean': 6.614629471031478,
          'max': 9.9498743710662,
          'min': 0.0,
          'sumOfSquares': 574.6676960961834,
        });

    check(stats.withPrecision(4).toJson()).deepEquals({
      'count': 100,
      'mean': 6.615,
      'max': 9.95,
      'min': 0.0,
      'sumOfSquares': 574.7,
    });

    check(stats.withPrecision(1).toJson()).deepEquals({
      'count': 100,
      'mean': 7.0,
      'max': 10.0,
      'min': 0.0,
      'sumOfSquares': 600.0,
    });
  });
}
