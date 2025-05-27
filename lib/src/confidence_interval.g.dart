// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confidence_interval.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfidenceInterval _$ConfidenceIntervalFromJson(Map<String, dynamic> json) =>
    ConfidenceInterval(
      count: (json['count'] as num).toInt(),
      average: (json['average'] as num).toDouble(),
      standardDeviation: (json['standardDeviation'] as num).toDouble(),
      min: fromJsonGeneric(json['min'] as Object),
      max: fromJsonGeneric(json['max'] as Object),
      median: (json['median'] as num).toDouble(),
      marginOfError: (json['marginOfError'] as num).toDouble(),
      tScore: (json['tScore'] as num).toDouble(),
      confidenceLevel: $enumDecode(
        _$ConfidenceLevelEnumMap,
        json['confidenceLevel'],
      ),
    );

Map<String, dynamic> _$ConfidenceIntervalToJson(ConfidenceInterval instance) =>
    <String, dynamic>{
      'count': instance.count,
      'average': instance.average,
      'min': toJsonGeneric(instance.min),
      'max': toJsonGeneric(instance.max),
      'median': instance.median,
      'standardDeviation': instance.standardDeviation,
      'marginOfError': instance.marginOfError,
      'tScore': instance.tScore,
      'confidenceLevel': _$ConfidenceLevelEnumMap[instance.confidenceLevel]!,
    };

const _$ConfidenceLevelEnumMap = {
  ConfidenceLevel.percent90: 'percent90',
  ConfidenceLevel.percent95: 'percent95',
  ConfidenceLevel.percent99: 'percent99',
};
