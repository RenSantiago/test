// weather_event.dart
abstract class WeatherEvent {}

class FetchWeatherEvent extends WeatherEvent {
  final String cityName;

  FetchWeatherEvent(this.cityName);
}
