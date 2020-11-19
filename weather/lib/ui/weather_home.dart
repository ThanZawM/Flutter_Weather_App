import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather/bloc/weather_bloc.dart';
import 'package:weather/helper/string_to_image.dart';
import 'package:weather/ui/search_area.dart';

class WeatherHome extends StatefulWidget {
  final int cityCode;
  WeatherHome([this.cityCode = 1015662]);

  @override
  _WeatherHomeState createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHome> {
  final newFormat = DateFormat('dd/MM/yy H:m:s');
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final weatherBloc = BlocProvider.of<WeatherBloc>(context);
    weatherBloc..add(FetchWeatherEvent(cityCode: widget.cityCode));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
        leading: Icon(Icons.home),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchArea()));
              }),
        ],
      ),
      body: SafeArea(
        child: Container(
            padding: EdgeInsets.only(
                top: 30.0, left: 20.0, right: 20.0, bottom: 30.0),
            child: BlocBuilder<WeatherBloc, WeatherState>(
                builder: (context, state) {
              if (state is WeatherLoadingState) {
                return Center(child: CircularProgressIndicator());
              } else if (state is WeatherLoadedState) {
                return ListView(
                  children: [
                    Column(
                      children: [
                        Text(
                          '${state.weathersModel.title}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 50,
                              color: Colors.blue),
                        ),
                        Text('updated: ' +
                            newFormat
                                .format(DateTime.parse(
                                    state.weathersModel.weathers[0].created))
                                .toString()),
                        Padding(
                          padding: const EdgeInsets.only(top: 50.0),
                          child: Image(
                            image: AssetImage(
                                'assets/images/${MyHelper.stringToImage(state.weathersModel.weathers[0].weatherStateAbbr)}.png'),
                            width: 150,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: Text(
                            '${state.weathersModel.weathers[0].weatherStateName}',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepOrange),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 20.0)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              '${state.weathersModel.weathers[0].theTemp.toInt()}° C',
                              style: TextStyle(fontSize: 25, color: Colors.red),
                            ),
                            Column(
                              children: [
                                Text(
                                    'min: ${state.weathersModel.weathers[0].minTemp.toInt()}° C'),
                                Text(
                                    'max: ${state.weathersModel.weathers[0].maxTemp.toInt()}° C'),
                              ],
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                );
              } else if (state is WeatherErrorState) {
                return Center(
                    child: Text('Error Loading from API',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                        )));
              }
              return Center(
                child: Text('NULL'),
              );
            })),
      ),
    );
  }
}
