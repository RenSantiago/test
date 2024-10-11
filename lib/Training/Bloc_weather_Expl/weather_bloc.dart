// weather_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'weather_event.dart';
import 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitialState()) {
    on<FetchWeatherEvent>((event, emit) async {
      emit(WeatherLoadingState());

      // Simulate fetching data with a delay
      await Future.delayed(Duration(seconds: 1));

      if (event.cityName.toLowerCase() == "error") {
        emit(WeatherErrorState("City not found."));
      } else {
        // Mock data
        double temperature = 25 ; // Example logic for mock data
        emit(WeatherLoadedState(event.cityName, temperature));
      }
    });
  }
}
