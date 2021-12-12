import 'package:json_annotation/json_annotation.dart';

import 'blood_pressure.dart';
import 'pulse.dart';

part 'measurement.g.dart';

@JsonSerializable()
class Measurement {
  @JsonKey(name: 'createdAt', includeIfNull: false)
  DateTime? createdAt;

  @JsonKey(name: 'bloodPressure')
  final BloodPressure bloodPressure;

  @JsonKey(name: 'pulse')
  final Pulse pulse;

  Measurement(this.createdAt, this.bloodPressure, this.pulse);

  static const fromJsonFactory = _$MeasurementFromJson;

  Map<String, dynamic> toJson() => _$MeasurementToJson(this);

  Measurement._builder(MeasurementBuilder builder)
      : bloodPressure = BloodPressure(builder._systolic, builder._diastolic),
        pulse = Pulse(builder._pulseBpm);
}

class MeasurementBuilder {
  final int _systolic;
  final int _diastolic;
  final int _pulseBpm;

  MeasurementBuilder(int systolic, int diastolic, int bpm)
      : _systolic = systolic,
        _diastolic = diastolic,
        _pulseBpm = bpm;

  Measurement build() {
    return Measurement._builder(this);
  }
}
