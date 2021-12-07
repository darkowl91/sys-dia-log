import 'package:json_annotation/json_annotation.dart';

part 'blood_pressure.g.dart';

@JsonSerializable()
class BloodPressure {
  @JsonKey(name: 'systolic')
  final int systolic;

  @JsonKey(name: 'diastolic')
  final int diastolic;

  BloodPressure(this.systolic, this.diastolic);

  factory BloodPressure.fromJson(final Map<String, dynamic> json) {
    return _$BloodPressureFromJson(json);
  }

  Map<String, dynamic> toJson() => _$BloodPressureToJson(this);
}
