import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../constant/const_api.dart';
import '../model/weather_model.dart';

part 'api_repository.g.dart';

@RestApi(baseUrl: ConstApi.baseUrl)
abstract class ApiRepository {
  factory ApiRepository(Dio dio, {String baseUrl}) = _ApiRepository;

  @GET(ConstApi.current)
  Future<WeatherModel> getCurrentWeather(
      @Query('key') String? key,
      @Query('q') String? q );

  @GET(ConstApi.forecast)
  Future<WeatherModel> getForecastWeather(
      @Query('key') String? key,
      @Query('q') String? q,
      @Query('days') int? days
      );
}