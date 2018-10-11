import 'dart:math' as math;

import 'package:stats/stats.dart';
import 'package:test/test.dart';

void main() {
  test('empty source is not allowed', () {
    expect(
        () => Stats.fromData([]),
        throwsA(isArgumentError.having(
            (e) => e.message, 'message', 'Cannot be empty.')));
  });

  test('trivial', () {
    var stats = Stats.fromData([0]);

    expect(stats.toJson(), {
      'count': 1,
      'mean': 0.0,
      'median': 0,
      'max': 0,
      'min': 0,
      'standardDeviation': 0.0
    });
  });

  test('two simple values', () {
    var stats = Stats.fromData([0, 2]);
    expect(stats.toJson(), {
      'count': 2,
      'mean': 1.0,
      'median': 1.0,
      'max': 2,
      'min': 0,
      'standardDeviation': 1.0
    });
  });

  test('precesion', () {
    var stats = Stats.fromData(Iterable.generate(100, (i) => math.sqrt(i)));
    expect(stats.toJson(), {
      'count': 100,
      'mean': 6.614629471031477,
      'median': 7.035533905932738,
      'max': 9.9498743710662,
      'min': 0.0,
      'standardDeviation': 2.3972227599791047
    });

    expect(stats.withPrecision(4).toJson(), {
      'count': 100,
      'mean': 6.615,
      'median': 7.036,
      'max': 9.95,
      'min': 0.0,
      'standardDeviation': 2.397
    });

    expect(stats.withPrecision(1).toJson(), {
      'count': 100,
      'mean': 7.0,
      'median': 7.0,
      'max': 10.0,
      'min': 0.0,
      'standardDeviation': 2.0
    });
  });
}
