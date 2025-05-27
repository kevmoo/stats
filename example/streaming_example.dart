import 'dart:async';
import 'dart:math';

import 'package:stats/stats.dart';

void main() async {
  final controller = StreamController<num>(sync: true);

  final rnd = Random();

  void addRandomValue() {
    if (controller.isClosed) return;
    controller.add(rnd.nextInt(256));
    Future.microtask(addRandomValue);
  }

  unawaited(Future.microtask(addRandomValue));

  await for (var stats in controller.stream
      .transform(Stats.transformer)
      .take(1000)) {
    if (stats.count > 1) {
      final confidence = ConfidenceInterval.calculate(
        stats,
        ConfidenceLevel.percent99,
      );
      print(
        [
          stats.count,
          stats.mean.toStringAsPrecision(4),
          confidence.marginOfError.toStringAsPrecision(4),
        ].join('\t'),
      );
    }
  }

  await controller.close();
}
