import 'package:flutter/foundation.dart';
import 'package:weather_app/service/save_image.dart';

import '../model/forecast_day.dart';
import '../model/hour.dart';
import 'weather_db_services.dart';
import '../model/weather_model.dart';
import 'db_config.dart';

Future<bool> saveToLocalDB(WeatherModel weather) async {
  final db = await DBConfig.instance;

  try {
    final dbServices = WeatherDBServices(database: db);

    print("START DOWNLOADING...");

    //Store Location
    weather.location!.name = weather.location!.name!.toLowerCase();
    int locationID = await dbServices.storeLocation(weather.location!.toJson());

    //Store condition of current
    Map<String, dynamic> currentConditionJson = weather.current!.condition!.toJson();
    currentConditionJson['icon'] = await saveImage(weather.current!.condition!.icon);
    int currentConditionId = await dbServices.storeCondition(currentConditionJson);

    //Store add location.id and condition.id to current
    Map<String, dynamic> currentJsonData = weather.current!.toRawData();
    currentJsonData['location_id'] = locationID;
    currentJsonData['condition_id'] = currentConditionId;
    int currentID = await dbServices.storeCurrent(currentJsonData);

    for(ForecastDay forecastDay in weather.forecast!.forecastDays!)
    {
      Map<String, dynamic> forecastDayRawData = forecastDay.toRawData();
      forecastDayRawData['location_id'] = locationID;
      int forecastID = await dbServices.storeForeCastDay(forecastDayRawData);

      //Store image
      Map<String, dynamic> dayConditionJson = forecastDay.day!.condition!.toJson();
      dayConditionJson['icon'] = await saveImage(forecastDay.day!.condition!.icon);
      int dayConditionId = await dbServices.storeCondition(dayConditionJson);
      Map<String, dynamic> dayRawData = forecastDay.day!.toRawData();
      dayRawData['condition_id'] = dayConditionId;
      dayRawData['forecast_day_id'] = forecastID;
      int dayID = await dbServices.storeDay(dayRawData);

      for(Hour hour in forecastDay.hours!)
      {
        Map<String, dynamic> hourConditionJson = hour.condition!.toJson();
        hourConditionJson['icon'] = await saveImage(hour.condition!.icon);
        int hourConditionID = await dbServices.storeCondition(hourConditionJson);
        Map<String, dynamic> hourRawData = hour.toRawData();
        hourRawData['condition_id'] = hourConditionID;
        hourRawData['forecast_day_id'] = forecastID;
        int hourID = await dbServices.storeHour(hourRawData);
      }
    }
    if (kDebugMode) {
      print("SUCCESSFULLY SAVED TO LOCAL DATABASE");
    }
    return true;
  } catch (e) {
    return false;
  }
}
