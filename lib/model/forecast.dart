import 'package:json_annotation/json_annotation.dart';

import 'forecast_day.dart';

part 'forecast.g.dart';

@JsonSerializable()
class Forecast
{
  @JsonKey(name: "forecastday")
  List<ForecastDay>? forecastDays;
  Forecast({ this.forecastDays });
  factory Forecast.fromJson(Map<String, dynamic> json) => _$ForecastFromJson(json);
  Map<String, dynamic> toJson() => _$ForecastToJson(this);
}