[![Build Status](https://travis-ci.org/kevmoo/stats.svg?branch=master)](https://travis-ci.org/kevmoo/stats)
![Pub](https://img.shields.io/pub/v/stats.svg)

```dart
import 'package:stats/stats.dart';

void main() {
  var input = [1, 2, 3, 4, 5, 6, 7, 8];
  print('Input: $input');
  var stats = Stats.fromData(input);
  // {count: 8, mean: 4.5, median: 4.5, max: 8, min: 1, standardDeviation: 2.29, rms: 5.05}
  print(stats.withPrecision(3));
}
```
