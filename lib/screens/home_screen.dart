import 'package:flutter/material.dart';
import 'package:weather_app/screens/forecast_screen.dart';
import '../services/weather_service.dart';
import '../services/location_service.dart';
import '../widgets/current_weather.dart';
import '../widgets/forecast_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  WeatherService weatherService = WeatherService();
  LocationService locationService = LocationService();
  var activeScreen = 'homeScreen';
  dynamic dayForecastDetail;

  void switchScreen(dynamic dayForecast) {
    dayForecastDetail = dayForecast;
    setState(() {
      activeScreen = 'forecastScreen';
    });
  }

  Map<String, dynamic>? weatherData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  Future<void> fetchWeather() async {
    try {
      final position = await locationService.getCurrentLocation();
      final data = await weatherService.fetchWeatherData(
          position.latitude, position.longitude);
      setState(() {
        weatherData = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("From Catch $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : activeScreen == 'homeScreen'
              ? Column(
                  children: [
                    CurrentWeather(
                      temperature: weatherData!['current']['temp_c'],
                      condition: weatherData!['current']['condition']['text'],
                      icon: weatherData!['current']['condition']['icon'],
                      location: weatherData!['location']['name'],
                      today: weatherData!['location']['localtime'],
                    ),
                    //           SizedBox(height: 20),
                    ForecastList(
                      forecast: weatherData!['forecast']['forecastday'],
                      switchScreen: switchScreen,
                    ),
                  ],
                )
              : ForecastScreen(
                  // forecastData: weatherData!['forecast']['forecastday'],
                  dayForecast: dayForecastDetail,
                  location: weatherData!['location']['name'],
                  feelsLike: weatherData!['current']['feelslike_c'],
                ),
    );
  }
}
