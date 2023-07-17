part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable
{
  @override
  List<Object> get props => [];
}

class WeatherInitializing extends WeatherState
{
  //
}

class WeatherLoading extends WeatherState
{
  //
}

class WeatherLoaded extends WeatherState
{
  final WeatherModel weather;
  final bool isOnLine;
  WeatherLoaded({ required this.weather, required this.isOnLine });
}

class WeatherEmpty extends WeatherState
{
  //
}

class WeatherError extends WeatherState
{
  //
}