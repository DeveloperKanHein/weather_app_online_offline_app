import '../database/weather_db_services.dart';
import '../model/weather_model.dart';

class LocalDataSource
{
  final WeatherDBServices services;
  LocalDataSource({ required this.services });

  Future<WeatherModel> getWeatherData({ required String cityName}) async {
    Map<String, dynamic> jsonData = await services.search(cityName: cityName);
    return WeatherModel.fromJson(jsonData);
  }

}