part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable
{
  @override
  List<Object> get props => [];
}

class GetWeatherData extends WeatherEvent
{
  final String? location;
  GetWeatherData({ this.location });
}