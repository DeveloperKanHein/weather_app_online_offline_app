import 'package:json_annotation/json_annotation.dart';
import 'condition.dart';

part 'day.g.dart';

@JsonSerializable()
class Day
{
  @JsonKey(name: "maxtemp_c")
  double? maxTempC;
  @JsonKey(name: "maxtemp_f")
  double? maxTempF;
  @JsonKey(name: "mintemp_c")
  double? minTempC;
  @JsonKey(name: "mintemp_f")
  double? minTempF;
  @JsonKey(name: "avgtemp_c")
  double? avgTempC;
  @JsonKey(name: "avgtemp_f")
  double? avgTempF;
  @JsonKey(name: "condition")
  Condition? condition;
  Day({ this.maxTempC, this.maxTempF, this.minTempC, this.minTempF, this.condition });
  factory Day.fromJson(Map<String, dynamic> json) => _$DayFromJson(json);
  Map<String, dynamic> toJson() => _$DayToJson(this);

  Map<String, dynamic> toRawData() => <String, dynamic>{
    'maxtemp_c': maxTempC,
    'maxtemp_f': maxTempF,
    'mintemp_c': minTempC,
    'mintemp_f': minTempF,
    'avgtemp_c': avgTempC,
    'avgtemp_f': avgTempF
  };
}