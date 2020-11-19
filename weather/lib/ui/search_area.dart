import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/bloc/search_bloc.dart';
import 'package:weather/ui/weather_home.dart';

class SearchArea extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search City'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: TextFormField(
                  autofocus: true,
                  controller: _searchController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Search City'),
                )),
                IconButton(
                    icon: Icon(Icons.search, color: Colors.blue),
                    onPressed: () {
                      if(_searchController.text!=''){
                        BlocProvider.of<SearchBloc>(context).add(FetchCityEvent(cityName: _searchController.text));
                      }
                    }),
              ],
            ),
            Expanded(child: BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (state is CityEmptyState) {
                  return Center(
                    child: Text('Type something to search!'),
                  );
                } else if (state is CityLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is CityLoadedState) {
                  return ListView.builder(
                    itemCount: state.cityModels.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        child: Card(
                          child: Container(
                              padding: EdgeInsets.only(
                                  top: 15, left: 10, right: 10, bottom: 15),
                              child: Text('${state.cityModels[index].title}')),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WeatherHome(
                                      state.cityModels[index].woeId)));
                        },
                      );
                    },
                  );
                } else if (state is CityErrorState) {
                  return Center(child: Text(state.error));
                }
                return Center(child: Text('NULL'));
              },
            ))
          ],
        ),
      ),
    );
  }
}
