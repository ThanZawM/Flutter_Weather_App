import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:weather/network/api_service.dart';
import 'package:weather/network/model/weathers_model.dart';
part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final ApiService api;
  WeatherBloc({@required this.api})
      : assert(api != null),
        super(WeatherInitialState());

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if (event is FetchWeatherEvent) {
      yield WeatherLoadingState();
      try {
        final response = await api.getWeather(event.cityCode);
        yield WeatherLoadedState(weathersModel: response);
      } on SocketException {
        yield WeatherErrorState();
      } on Exception {
        yield WeatherErrorState();
      }
    }
  }
}
