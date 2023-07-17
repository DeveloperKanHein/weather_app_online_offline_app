import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../api_repository/api_repository.dart';
import '../../model/weather_model.dart';
import '../data/token_data.dart';
import '../../logger/set_pretty_logger.dart';
import '../database/db_config.dart';
import '../database/weather_db_services.dart';
import '../local_data_source/local_data_source.dart';
import '../service/check_connection.dart';

part 'weather_state.dart';

part 'weather_event.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitializing()) {
    final apiRepository = ApiRepository(setPrettyLogger());
    on<GetWeatherData>((event, emit) async {
      try {
        emit(WeatherLoading());
        WeatherModel weather;
        bool isAccessNetwork = await checkConnection();
        if (isAccessNetwork) {
          weather = await apiRepository.getForecastWeather(
              TokenData.accessKey, event.location, 3);
        } else {
          final db = await DBConfig.instance;
          final weatherDBService = WeatherDBServices(database: db);
          final localDataSource = LocalDataSource(services: weatherDBService);
          weather = await localDataSource.getWeatherData(cityName: event.location ?? "rangoon");
        }
        emit(WeatherLoaded(weather: weather, isOnLine: isAccessNetwork));
      } catch (e) {
        emit(WeatherError());
      }
    });
  }
}
