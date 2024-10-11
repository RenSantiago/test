// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'weather_bloc.dart';
import 'weather_event.dart';
import 'weather_state.dart';



class WeatherBlocApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => WeatherBloc(),
        child: WeatherScreen(),
      ),
    );
  }
}

class WeatherScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final weatherBloc = BlocProvider.of<WeatherBloc>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Weather Info using Bloc')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Enter city name'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  weatherBloc.add(FetchWeatherEvent(_controller.text));
                }
              },
              child: Text('Get Weather'),
            ),
            SizedBox(height: 32),
            BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is WeatherInitialState) {
                  return Text('Enter a city name to get the weather.');
                } else if (state is WeatherLoadingState) {
                  return CircularProgressIndicator();
                } else if (state is WeatherLoadedState) {
                  return Text(
                    'Weather in ${state.cityName}: ${state.temperature}°C',
                    style: TextStyle(fontSize: 20),
                  );
                } else if (state is WeatherErrorState) {
                  return Text(
                    state.message,
                    style: TextStyle(color: Colors.red, fontSize: 20),
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
