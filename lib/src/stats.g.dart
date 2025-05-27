// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Stats<T> _$StatsFromJson<T extends num>(Map<String, dynamic> json) => Stats<T>(
  (json['count'] as num).toInt(),
  (json['average'] as num).toDouble(),
  fromJsonGeneric(json['min'] as Object),
  fromJsonGeneric(json['max'] as Object),
  json['median'] as num,
  (json['standardDeviation'] as num).toDouble(),
);

Map<String, dynamic> _$StatsToJson<T extends num>(Stats<T> instance) =>
    <String, dynamic>{
      'count': instance.count,
      'average': instance.average,
      'min': toJsonGeneric(instance.min),
      'max': toJsonGeneric(instance.max),
      'median': instance.median,
      'standardDeviation': instance.standardDeviation,
    };
