// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Stats<T> _$StatsFromJson<T extends num>(Map<String, dynamic> json) => Stats<T>(
  (json['count'] as num).toInt(),
  (json['mean'] as num).toDouble(),
  fromJsonGeneric(json['min'] as Object),
  fromJsonGeneric(json['max'] as Object),
  (json['standardDeviation'] as num).toDouble(),
);

Map<String, dynamic> _$StatsToJson<T extends num>(Stats<T> instance) =>
    <String, dynamic>{
      'standardDeviation': instance.standardDeviation,
      'min': toJsonGeneric(instance.min),
      'max': toJsonGeneric(instance.max),
      'count': instance.count,
      'mean': instance.mean,
    };
