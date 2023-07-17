import 'package:json_annotation/json_annotation.dart';
import 'condition.dart';

part 'hour.g.dart';

@JsonSerializable()
class Hour
{
  @JsonKey(name: 'time')
  String? time;
  @JsonKey(name: 'temp_c')
  double? tempC;
  @JsonKey(name: 'temp_f')
  double? tempF;
  @JsonKey(name: 'is_day')
  int? isDay;
  @JsonKey(name: 'condition')
  Condition? condition;
  @JsonKey(name: "wind_mph")
  double? windMph;
  @JsonKey(name: "wind_kph")
  double? windKph;
  Hour({ this.time, this.tempC, this.tempF, this.isDay, this.condition, this.windMph, this.windKph });
  factory Hour.fromJson(Map<String, dynamic> json) => _$HourFromJson(json);
  Map<String, dynamic> toJson() => _$HourToJson(this);

  Map<String, dynamic> toRawData() => <String, dynamic>{
    'time': time,
    'temp_c': tempC,
    'temp_f': tempF,
    'is_day': isDay,
    'wind_mph': windMph,
    'wind_kph': windKph,
  };
}