// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'light_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LightStats _$LightStatsFromJson(Map<String, dynamic> json) {
  return LightStats(
    json['count'] as int,
    json['average'] as num,
    json['max'] as num,
    json['min'] as num,
  );
}

Map<String, dynamic> _$LightStatsToJson(LightStats instance) =>
    <String, dynamic>{
      'count': instance.count,
      'average': instance.average,
      'max': instance.max,
      'min': instance.min,
    };
