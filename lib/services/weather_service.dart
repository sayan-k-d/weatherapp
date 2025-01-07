import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = 'cf04ae4515da4e48af9171204250601';

  Future<Map<String, dynamic>> fetchWeatherData(double lat, double lon) async {
    print(lat);
    print(lon);
    final response = await http.get(Uri.parse(
        'https://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=$lat,$lon&days=7'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }
}
