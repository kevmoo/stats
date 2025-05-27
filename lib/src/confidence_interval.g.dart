// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confidence_interval.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfidenceInterval _$ConfidenceIntervalFromJson(Map<String, dynamic> json) =>
    ConfidenceInterval(
      count: (json['count'] as num).toInt(),
      mean: (json['mean'] as num).toDouble(),
      standardDeviation: (json['standardDeviation'] as num).toDouble(),
      min: fromJsonGeneric(json['min'] as Object),
      max: fromJsonGeneric(json['max'] as Object),
      marginOfError: (json['marginOfError'] as num).toDouble(),
      tScore: (json['tScore'] as num).toDouble(),
      confidenceLevel: $enumDecode(
        _$ConfidenceLevelEnumMap,
        json['confidenceLevel'],
      ),
    );

Map<String, dynamic> _$ConfidenceIntervalToJson(ConfidenceInterval instance) =>
    <String, dynamic>{
      'standardDeviation': instance.standardDeviation,
      'min': toJsonGeneric(instance.min),
      'max': toJsonGeneric(instance.max),
      'count': instance.count,
      'mean': instance.mean,
      'marginOfError': instance.marginOfError,
      'tScore': instance.tScore,
      'confidenceLevel': _$ConfidenceLevelEnumMap[instance.confidenceLevel]!,
    };

const _$ConfidenceLevelEnumMap = {
  ConfidenceLevel.percent90: 'percent90',
  ConfidenceLevel.percent95: 'percent95',
  ConfidenceLevel.percent99: 'percent99',
};
