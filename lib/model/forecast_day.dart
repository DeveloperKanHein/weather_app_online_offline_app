import 'package:json_annotation/json_annotation.dart';
import 'day.dart';
import 'hour.dart';

part 'forecast_day.g.dart';

@JsonSerializable()
class ForecastDay
{
  @JsonKey(name: "date")
  String? date;
  @JsonKey(name: "day")
  Day? day;
  @JsonKey(name: "hour")
  List<Hour>? hours;
  ForecastDay({ this.date, this.day, this.hours });
  factory ForecastDay.fromJson(Map<String, dynamic> json) => _$ForecastDayFromJson(json);
  Map<String, dynamic> toJson() => _$ForecastDayToJson(this);

  Map<String, dynamic> toRawData() =>
      <String, dynamic>{
        'date': date,
      };
}