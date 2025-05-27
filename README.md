[![CI](https://github.com/kevmoo/stats/actions/workflows/ci.yml/badge.svg)](https://github.com/kevmoo/stats/actions/workflows/ci.yml)
[![Pub Package](https://img.shields.io/pub/v/stats.svg)](https://pub.dev/packages/stats)
[![package publisher](https://img.shields.io/pub/publisher/stats.svg)](https://pub.dev/packages/stats/publisher)

```dart
import 'package:stats/stats.dart';

void main() {
  final input = [1, 2, 3, 4, 5, 6, 7, 8];
  print('Input: $input');
  final stats = Stats.fromData(input);
  print(stats.withPrecision(3));
  // {
  //   "standardDeviation": 2.29,
  //   "min": 1,
  //   "max": 8,
  //   "count": 8,
  //   "mean": 4.5
  // }
}
```
