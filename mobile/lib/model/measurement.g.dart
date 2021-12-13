// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'measurement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Measurement _$MeasurementFromJson(Map<String, dynamic> json) => Measurement(
      json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      BloodPressure.fromJson(json['bloodPressure'] as Map<String, dynamic>),
      Pulse.fromJson(json['pulse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MeasurementToJson(Measurement instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('createdAt', instance.createdAt?.toIso8601String());
  val['bloodPressure'] = instance.bloodPressure;
  val['pulse'] = instance.pulse;
  return val;
}
