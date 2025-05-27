// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'light_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LightStats<T> _$LightStatsFromJson<T extends num>(Map<String, dynamic> json) =>
    LightStats<T>(
      (json['count'] as num).toInt(),
      (json['average'] as num).toDouble(),
      fromJsonGeneric(json['min'] as Object),
      fromJsonGeneric(json['max'] as Object),
    );

Map<String, dynamic> _$LightStatsToJson<T extends num>(
  LightStats<T> instance,
) => <String, dynamic>{
  'count': instance.count,
  'average': instance.average,
  'min': toJsonGeneric(instance.min),
  'max': toJsonGeneric(instance.max),
};
