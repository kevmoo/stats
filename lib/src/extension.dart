import 'stats.dart';

extension StatsExtensions<T> on Iterable<num> {
  Stats get stats => Stats.fromData(this);
}
