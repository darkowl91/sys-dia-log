import 'package:json_annotation/json_annotation.dart';

part 'pulse.g.dart';

@JsonSerializable()
class Pulse {
  @JsonKey(name: 'bpm')
  final int bpm;

  Pulse(this.bpm);

  factory Pulse.fromJson(final Map<String, dynamic> json) {
    return _$PulseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PulseToJson(this);
}
