import 'package:stats/stats.dart';
import 'package:test/test.dart';

void main() {
  test('stats', () {
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

  test('empty source is not allowed', () {
    expect(
        () => Stats.fromData([]),
        throwsA(isArgumentError.having(
            (e) => e.message, 'message', 'Cannot be empty.')));
  });

  test('stats', () {
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
}
