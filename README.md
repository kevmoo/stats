[![CI](https://github.com/kevmoo/stats/actions/workflows/ci.yml/badge.svg)](https://github.com/kevmoo/stats/actions/workflows/ci.yml)
[![Pub Package](https://img.shields.io/pub/v/stats.svg)](https://pub.dev/packages/stats)
[![package publisher](https://img.shields.io/pub/publisher/stats.svg)](https://pub.dev/packages/stats/publisher)

Supports:

- `Stats`: Typical statistical values over a `List` or `Stream` of `num`: 
  `count`, `min`, `max`, `mean`, `sumOfSquares`
- `ConfidenceInterval` over `Stats` with a given confidence level. 

```dart
import 'dart:convert';

import 'package:stats/stats.dart';

void main() {
  final input = [1, 2, 3, 4, 5, 6, 7, 8];
  print('Input: $input');
  final stats = Stats.fromData(input);
  final confidence = ConfidenceInterval.calculate(
    stats,
    ConfidenceLevel.percent95,
  );

  print(_toJson(confidence));
  // {
  //   "stats": {
  //     "count": 8,
  //     "min": 1,
  //     "max": 8,
  //     "mean": 4.5,
  //     "sumOfSquares": 42.0
  //   },
  //   "marginOfError": 2.0481500799501973,
  //   "tScore": 2.365,
  //   "confidenceLevel": "percent95"
  // }
}

String _toJson(Object? value) =>
    const JsonEncoder.withIndent('  ').convert(value);
```
