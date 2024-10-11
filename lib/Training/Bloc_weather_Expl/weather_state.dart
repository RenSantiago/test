// weather_state.dart
abstract class WeatherState {}

class WeatherInitialState extends WeatherState {}

class WeatherLoadingState extends WeatherState {}

class WeatherLoadedState extends WeatherState {
  final String cityName;
  final double temperature;

  WeatherLoadedState(this.cityName, this.temperature);
}

class WeatherErrorState extends WeatherState {
  final String message;

  WeatherErrorState(this.message);
}
