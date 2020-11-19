import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'city_model.g.dart';

@JsonSerializable()
class CityModel extends Equatable {
  final String title;
  @JsonKey(name: 'location_type')
  final String locationType;
  @JsonKey(name: 'woeid')
  final int woeId;
  @JsonKey(name: 'latt_long')
  final String lattLong;

  CityModel({this.title, this.locationType, this.woeId, this.lattLong});

  factory CityModel.fromJson(Map<String, dynamic> json) =>
      _$CityModelFromJson(json);

  Map<String, dynamic> toJson() => _$CityModelToJson(this);

  @override
  // TODO: implement props
  List<Object> get props => throw [title, locationType, woeId, lattLong];
}
