// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confidence_interval.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfidenceInterval _$ConfidenceIntervalFromJson(Map<String, dynamic> json) =>
    ConfidenceInterval(
      stats: Stats.fromJson(json['stats'] as Map<String, dynamic>),
      marginOfError: (json['marginOfError'] as num).toDouble(),
      tScore: (json['tScore'] as num).toDouble(),
      confidenceLevel: $enumDecode(
        _$ConfidenceLevelEnumMap,
        json['confidenceLevel'],
      ),
    );

Map<String, dynamic> _$ConfidenceIntervalToJson(ConfidenceInterval instance) =>
    <String, dynamic>{
      'stats': instance.stats,
      'marginOfError': instance.marginOfError,
      'tScore': instance.tScore,
      'confidenceLevel': _$ConfidenceLevelEnumMap[instance.confidenceLevel]!,
    };

const _$ConfidenceLevelEnumMap = {
  ConfidenceLevel.percent90: 'percent90',
  ConfidenceLevel.percent95: 'percent95',
  ConfidenceLevel.percent99: 'percent99',
};
