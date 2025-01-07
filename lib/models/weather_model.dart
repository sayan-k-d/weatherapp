class Weather {
  final String location;
  final String condition;
  final double temperature;
  final List<Forecast> forecast;

  Weather({
    required this.location,
    required this.condition,
    required this.temperature,
    required this.forecast,
  });
}

class Forecast {
  final String day;
  final String condition;
  final double temp;

  Forecast({
    required this.day,
    required this.condition,
    required this.temp,
  });
}
