part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherInitialState extends WeatherState {}

class WeatherLoadingState extends WeatherState {}

class WeatherLoadedState extends WeatherState {
  final WeathersModel weathersModel;
  WeatherLoadedState({@required this.weathersModel}) : assert(weathersModel != null);
  @override
  // TODO: implement props
  List<Object> get props => [weathersModel];
}

class WeatherErrorState extends WeatherState {}
