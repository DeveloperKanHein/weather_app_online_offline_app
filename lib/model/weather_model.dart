import 'package:json_annotation/json_annotation.dart';
import 'current.dart';
import 'forecast.dart';
import 'forecast_day.dart';
import 'location.dart';

part 'weather_model.g.dart';

@JsonSerializable()
class WeatherModel
{
  @JsonKey(name: "location")
  Location? location;
  @JsonKey(name: "current")
  Current? current;
  @JsonKey(name: "forecast")
  Forecast? forecast;
  WeatherModel({ this.location, this.current, this.forecast});
  factory WeatherModel.fromJson(Map<String, dynamic> json) => _$WeatherModelFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherModelToJson(this);
}