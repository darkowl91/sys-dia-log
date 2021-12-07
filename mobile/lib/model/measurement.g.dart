// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'measurement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Measurement _$MeasurementFromJson(Map<String, dynamic> json) => Measurement(
      DateTime.parse(json['createdAt'] as String),
      BloodPressure.fromJson(json['bloodPressure'] as Map<String, dynamic>),
      Pulse.fromJson(json['pulse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MeasurementToJson(Measurement instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt.toIso8601String(),
      'bloodPressure': instance.bloodPressure,
      'pulse': instance.pulse,
    };
