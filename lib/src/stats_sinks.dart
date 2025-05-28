import 'dart:convert';

import 'stats.dart';

final class StatsConverter extends Converter<num, Stats> {
  const StatsConverter();

  @override
  Stats convert(num input) => Stats.fromData([input]);

  @override
  Sink<num> startChunkedConversion(Sink<Stats> sink) => ChunkedSink(sink);
}

final class ChunkedSink extends StatsSink {
  ChunkedSink(this._target);

  final Sink<Stats> _target;
  bool _closed = false;

  @override
  void add(num value) {
    if (_closed) {
      throw StateError('Closed.');
    }
    super.add(value);
    _target.add(emit());
  }

  @override
  void close() {
    super.close();
    _closed = true;
  }
}

final class StatsSink implements ChunkedConversionSink<num> {
  int _count = 0;
  double _mean = 0;
  double _sumOfSquares = 0;
  late num _min, _max;

  @override
  void add(num value) {
    assert(value.isFinite);
    if (_count == 0) {
      _min = _max = value;
    } else {
      if (value < _min) {
        _min = value;
      } else if (value > _max) {
        _max = value;
      }
    }
    _count++;
    final delta = value - _mean;
    _mean += delta / _count;
    final delta2 = value - _mean; // Use the new mean for delta2
    _sumOfSquares += delta * delta2;
  }

  Stats emit() {
    if (_count == 0) {
      throw ArgumentError('Cannot be empty.', 'source');
    }

    return Stats(
      count: _count,
      mean: _mean,
      min: _min,
      max: _max,
      sumOfSquares: _sumOfSquares,
    );
  }

  @override
  void close() {}
}
