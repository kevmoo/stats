import 'dart:math' as math;

import 'package:checks/checks.dart';
import 'package:stats/stats.dart';
import 'package:test/scaffolding.dart';
import 'package:test/test.dart' as legacy show containsPair, expect;

Stats _validateJson<T extends num>(
  Iterable<T> values,
  T expectedSum,
  Map<String, dynamic> expectedJson,
) {
  final stats = values.stats;

  checkThat(stats.toJson()).deepEquals(expectedJson);

  final lightStats = values.lightStats;
  for (var entry in lightStats.toJson().entries) {
    // TODO: remove when pkg:checks has this
    // https://github.com/dart-lang/test/issues/1879
    legacy.expect(expectedJson, legacy.containsPair(entry.key, entry.value));
  }

  checkThat(values.sum).equals(expectedSum);
  checkThat(stats.average).equals(values.average);
  checkThat(stats.min).equals(values.min);
  checkThat(stats.max).equals(values.max);
  return stats;
}

void main() {
  test('empty source is not allowed', () {
    final messageIsCannotBeEmpty = it<ArgumentError>()
      ..has((p0) => p0.message, 'message').equals('Cannot be empty.');

    checkThat(() => <num>[].stats)
        .throws<ArgumentError>()
        .which(messageIsCannotBeEmpty);
    checkThat(() => <num>[].lightStats)
        .throws<ArgumentError>()
        .which(messageIsCannotBeEmpty);
  });

  group('empty', () {
    test('sum', () {
      checkThat(<num>[].sum).equals(0);
      checkThat(<int>[].sum).equals(0);
      checkThat(<double>[].sum).equals(0);
    });

    test('max', () {
      checkThat(() => <num>[].max).throws<StateError>();
    });

    test('min', () {
      checkThat(() => <num>[].min).throws<StateError>();
    });

    test('average', () {
      checkThat(() => <num>[].average).throws<ArgumentError>();
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
    _validateJson(
      Iterable.generate(10, (i) => i),
      45,
      {
        'count': 10,
        'average': 4.5,
        'min': 0,
        'max': 9,
        'median': 4.5,
        'standardDeviation': 2.8722813232690143
      },
    );
  });

  test('11 values', () {
    _validateJson(
      Iterable.generate(11, (i) => i),
      55,
      {
        'count': 11,
        'average': 5.0,
        'min': 0,
        'max': 10,
        'median': 5,
        'standardDeviation': 3.1622776601683795
      },
    );
  });

  test('precision', () {
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

    checkThat(stats.withPrecision(4).toJson()).deepEquals(
      {
        'count': 100,
        'average': 6.615,
        'median': 7.036,
        'max': 9.95,
        'min': 0.0,
        'standardDeviation': 2.397,
      },
    );

    checkThat(stats.withPrecision(1).toJson()).deepEquals(
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
