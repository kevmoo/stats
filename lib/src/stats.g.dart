// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Stats _$StatsFromJson(Map<String, dynamic> json) => Stats(
  count: (json['count'] as num).toInt(),
  mean: (json['mean'] as num).toDouble(),
  min: json['min'] as num,
  max: json['max'] as num,
  sumOfSquares: (json['sumOfSquares'] as num).toDouble(),
);

Map<String, dynamic> _$StatsToJson(Stats instance) => <String, dynamic>{
  'count': instance.count,
  'min': instance.min,
  'max': instance.max,
  'mean': instance.mean,
  'sumOfSquares': instance.sumOfSquares,
};
