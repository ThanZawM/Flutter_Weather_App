part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class FetchWeatherEvent extends WeatherEvent {
  final int cityCode;
  FetchWeatherEvent({@required this.cityCode}) : assert(cityCode != null);
  @override
  // TODO: implement props
  List<Object> get props => [cityCode];
}
