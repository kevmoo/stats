import 'dart:math' as math;

import 'package:checks/checks.dart';
import 'package:stats/stats.dart';
import 'package:test/scaffolding.dart';

Stats _validateJson<T extends num>(
  Iterable<T> values,
  T expectedSum,
  Map<String, dynamic> expectedJson,
) {
  final stats = values.stats;

  check(stats.toJson()).deepEquals(expectedJson);

  final lightStats = values.lightStats;
  for (var entry in lightStats.toJson().entries) {
    check(expectedJson)[entry
        .key].isA<num>().isCloseTo(entry.value as num, 0.0000001);
  }

  check(values.sum).equals(expectedSum);
  check(stats.average).isCloseTo(values.average, 0.0000001);
  check(stats.min).equals(values.min);
  check(stats.max).equals(values.max);
  return stats;
}

void main() {
  test('empty source is not allowed', () {
    check(() => <num>[].stats).throws<ArgumentError>().which(
      (it) => it.has((p0) => p0.message, 'message').equals('Cannot be empty.'),
    );

    check(() => <num>[].lightStats).throws<ArgumentError>().which(
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

    test('average', () {
      check(() => <num>[].average).throws<ArgumentError>();
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

  test('10 values', () {
    _validateJson(Iterable.generate(10, (i) => i), 45, {
      'count': 10,
      'average': 4.5,
      'min': 0,
      'max': 9,
      'median': 4.5,
      'standardDeviation': 2.8722813232690143,
    });
  });

  test('11 values', () {
    _validateJson(Iterable.generate(11, (i) => i), 55, {
      'count': 11,
      'average': 5.0,
      'min': 0,
      'max': 10,
      'median': 5,
      'standardDeviation': 3.1622776601683795,
    });
  });

  test('precision', () {
    final stats =
        _validateJson(Iterable.generate(100, math.sqrt), 661.4629471031477, {
          'count': 100,
          'average': 6.614629471031478,
          'median': 7.035533905932738,
          'max': 9.9498743710662,
          'min': 0.0,
          'standardDeviation': 2.3972227599791043,
        });

    check(stats.withPrecision(4).toJson()).deepEquals({
      'count': 100,
      'average': 6.615,
      'median': 7.036,
      'max': 9.95,
      'min': 0.0,
      'standardDeviation': 2.397,
    });

    check(stats.withPrecision(1).toJson()).deepEquals({
      'count': 100,
      'average': 7.0,
      'median': 7.0,
      'max': 10.0,
      'min': 0.0,
      'standardDeviation': 2.0,
    });
  });
}
