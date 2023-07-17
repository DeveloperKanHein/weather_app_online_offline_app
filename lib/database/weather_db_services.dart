import 'dart:convert';

import 'package:sqflite/sqflite.dart';

class WeatherDBServices
{
  final Database database;
  WeatherDBServices({ required this.database });
  Future<int> storeCondition(Map<String, dynamic> dataRow) async
  {
    return await database.insert('conditions', dataRow);
  }

  Future<int> storeCurrent(Map<String, dynamic> dataRow) async
  {
    return await database.insert('currents', dataRow);
  }

  Future<int> storeLocation(Map<String, dynamic> dataRow) async
  {
    return await database.insert('locations', dataRow);
  }

  Future<int> storeForeCastDay(Map<String, dynamic> dataRow) async
  {
    return await database.insert('forecast_days', dataRow);
  }

  Future<int> storeDay(Map<String, dynamic> dataRow) async
  {
    return await database.insert('days', dataRow);
  }

  Future<int> storeHour(Map<String, dynamic> dataRow) async
  {
    return await database.insert('hours', dataRow);
  }

  Future<Map<String, dynamic>> search({ required String cityName }) async
  {
    String city = cityName.toLowerCase();
    List<Map<String, dynamic>> locations = await database.rawQuery("SELECT * FROM locations WHERE name='$city'");
    if(locations.isNotEmpty){
      int locationID = locations[0]['id'];

      List<Map<String, dynamic>> currents = await database.rawQuery("SELECT * FROM currents WHERE location_id=$locationID");
      int currentConditionID = currents[0]['condition_id'];

      List<Map<String, dynamic>> currentConditions = await database.rawQuery("SELECT * FROM conditions WHERE id=$currentConditionID");
      Map<String, dynamic> current = Map.of(currents[0]);
      current["condition"] = currentConditions[0];

      List<Map<String, dynamic>> rawForecastDays = await database.rawQuery("SELECT * FROM forecast_days WHERE location_id=$locationID");
      List<Map<String, dynamic>> forecastDays = rawForecastDays.map((e) => Map.of(e)).toList();

      for(int i = 0; i <  forecastDays.length; i++){
        int forecastDayID = forecastDays[i]['id'];
        List<Map<String, dynamic>> days = await database.rawQuery("SELECT * FROM days WHERE forecast_day_id=$forecastDayID");
        int dayConditionId = days[0]['condition_id'];
        List<Map<String, dynamic>> dayConditions = await database.rawQuery("SELECT * FROM conditions WHERE id=$dayConditionId");
        Map<String, dynamic> day = Map.of(days[0]);
        day['condition'] = dayConditions[0];
        List<Map<String, dynamic>> rawHours = await database.rawQuery("SELECT * FROM hours WHERE forecast_day_id=$forecastDayID");
        List<Map<String,dynamic>> hours = rawHours.map((e) => Map.of(e)).toList();
        for(int h = 0; h < hours.length; h++){
          int hourConditionID = hours[h]['condition_id'];
          List<Map<String, dynamic>> hourConditions = await database.rawQuery("SELECT * FROM conditions WHERE id=$hourConditionID");
          hours[h]['condition'] = hourConditions[0];
        }
        forecastDays[i]['day'] = day;
        forecastDays[i]['hour'] = hours;
      }
      return {
        "location": locations[0],
        "current": current,
        "forecast": {
          "forecastday": forecastDays
        }
      };
    }else{
      return {
        "location": null,
        "current": null,
        "forecast": {
          "forecastday": null
        }
      };
    }


  }
}