class DBQuery
{
  static const String createConditionTableQuery = "CREATE TABLE IF NOT EXISTS conditions ( id INTEGER PRIMARY KEY, text TEXT, icon TEXT, code INTEGER)";
  static const String createLocationTableQuery = "CREATE TABLE IF NOT EXISTS locations ( id INTEGER PRIMARY KEY, name TEXT, region TEXT, country TEXT, lat DOUBLE, lon DOUBLE, tz_id TEXT, localtime TEXT)";
  static const String createCurrentTableQuery = "CREATE TABLE IF NOT EXISTS currents ( id INTEGER PRIMARY KEY, location_id INTEGER, last_updated TEXT, temp_c DOUBLE, temp_f DOUBLE, is_day TINYINT, wind_mph DOUBLE, wind_kph DOUBLE, condition_id INTEGER)";
  static const String createForecastDayTableQuery = "CREATE TABLE IF NOT EXISTS forecast_days ( id INTEGER PRIMARY KEY, location_id INTEGER, date TEXT)";
  static const String createDayTableQuery = "CREATE TABLE IF NOT EXISTS days ( id INTEGER PRIMARY KEY, forecast_day_id INTEGER, maxtemp_c DOUBLE, maxtemp_f DOUBLE, mintemp_c DOUBLE, mintemp_f DOUBLE, avgtemp_c DOUBLE, avgtemp_f DOUBLE, maxwind_mph DOUBLE, maxwind_kph DOUBLE, condition_id INTEGER)";
  static const String createHourTableQuery = "CREATE TABLE IF NOT EXISTS hours ( id INTEGER PRIMARY KEY, forecast_day_id INTEGER, time TEXT, temp_c DOUBLE, temp_f DOUBLE, is_day TINYINT, wind_mph DOUBLE, wind_kph DOUBLE, condition_id INTEGER)";
}