import 'package:json_annotation/json_annotation.dart';
import 'condition.dart';
part 'current.g.dart';

@JsonSerializable()
class Current {
  @JsonKey(name: "last_updated")
  String? lastUpdated;
  @JsonKey(name: "temp_c")
  double? tempC;
  @JsonKey(name: "temp_f")
  double? tempF;
  @JsonKey(name: "is_day")
  int? isDay;
  @JsonKey(name: "condition")
  Condition? condition;
  @JsonKey(name: "wind_mph")
  double? windMph;
  @JsonKey(name: "wind_kph")
  double? windKph;
  Current(
      {this.lastUpdated,
      this.tempC,
      this.tempF,
      this.isDay,
      this.condition,
      this.windMph,
      this.windKph});
  factory Current.fromJson(Map<String, dynamic> json) => _$CurrentFromJson(json);
  Map<String, dynamic> toJson() => _$CurrentToJson(this);

  Map<String, dynamic> toRawData() => <String, dynamic>{
    'last_updated': lastUpdated,
    'temp_c': tempC,
    'temp_f': tempF,
    'is_day': isDay,
    'wind_mph': windMph,
    'wind_kph': windKph,
  };
}


