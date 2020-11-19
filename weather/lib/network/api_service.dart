import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/http.dart';
import 'package:weather/network/model/city_model.dart';
import 'package:weather/network/model/weathers_model.dart';
part 'api_service.g.dart';

@RestApi(baseUrl: 'https://www.metaweather.com/api/')
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  static ApiService create() {
    final Dio dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
    return ApiService(dio);
  }

  @GET('location/{locationId}')
  Future<WeathersModel> getWeather(@Path() int locationId);

  @GET('location/search/')
  Future<List<CityModel>> getCity(@Query('query') String keyword);
}
