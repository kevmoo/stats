// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: prefer_expression_function_bodies

part of 'stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Stats<T> _$StatsFromJson<T extends num>(Map<String, dynamic> json) {
  return Stats<T>(
    json['count'] as int,
    json['average'] as num,
    fromJsonGeneric(json['min']),
    fromJsonGeneric(json['max']),
    json['median'] as num,
    json['standardDeviation'] as num,
  );
}

Map<String, dynamic> _$StatsToJson<T extends num>(Stats<T> instance) =>
    <String, dynamic>{
      'count': instance.count,
      'average': instance.average,
      'min': toJsonGeneric(instance.min),
      'max': toJsonGeneric(instance.max),
      'median': instance.median,
      'standardDeviation': instance.standardDeviation,
    };
