part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class FetchCityEvent extends SearchEvent {
  final String cityName;
  FetchCityEvent({@required this.cityName}) : assert(cityName != null);
  @override
  // TODO: implement props
  List<Object> get props => [cityName];
}
