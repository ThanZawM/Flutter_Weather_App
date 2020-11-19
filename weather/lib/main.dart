import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:weather/bloc/search_bloc.dart';
import 'package:weather/bloc/weather_bloc.dart';
import 'package:weather/helper/observer.dart';
import 'package:weather/network/api_service.dart';
import 'package:weather/ui/weather_home.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<ApiService>(
        create: (context) => ApiService.create(),
        child: Consumer<ApiService>(builder: (context, apiService, child) {
          return MultiBlocProvider(
              providers: [
                BlocProvider<WeatherBloc>(
                    create: (context) => WeatherBloc(api: apiService)),
                BlocProvider<SearchBloc>(
                    create: (context) => SearchBloc(api: apiService)),
              ],
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(primaryColor: Colors.deepPurple),
                home: WeatherHome(),
              ));
        }));
  }
}
