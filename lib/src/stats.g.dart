// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Stats _$StatsFromJson(Map<String, dynamic> json) {
  return Stats(json['count'] as int, json['mean'] as num, json['median'] as num,
      json['max'] as num, json['min'] as num, json['standardDeviation'] as num, json[rms] as num);
}

Map<String, dynamic> _$StatsToJson(Stats instance) => <String, dynamic>{
      'count': instance.count,
      'mean': instance.mean,
      'median': instance.median,
      'max': instance.max,
      'min': instance.min,
      'standardDeviation': instance.standardDeviation,
      'rms': instance.rms
    };
