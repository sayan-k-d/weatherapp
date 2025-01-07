import 'package:flutter/material.dart';

class ForecastScreen extends StatelessWidget {
  // final List<dynamic> forecastData;
  final dynamic dayForecast;
  final String location;
  final double feelsLike;
  // Constructor to accept forecast data from the previous screen
  const ForecastScreen(
      {super.key,
      required this.dayForecast,
      required this.location,
      required this.feelsLike});

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: ListView.builder(
    //     itemCount: forecastData.length,
    //     itemBuilder: (context, index) {
    // final dayData = forecastData.sublist(1)[index];
    final day = _getDayOfWeek(dayForecast['date_epoch']);
    final condition = dayForecast['day']['condition']['text'];
    final double temp = dayForecast['day']['avgtemp_c'];
    final icon = dayForecast['day']['condition']['icon'];
    final maxTemp = dayForecast['day']['maxtemp_c'];
    final minTemp = dayForecast['day']['mintemp_c'];
    final humidity = dayForecast['day']['avghumidity'];
    final sunrise = dayForecast['astro']['sunrise'];
    final sunset = dayForecast['astro']['sunset'];
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
            margin: EdgeInsets.symmetric(vertical: 10),
            // width: double.infinity,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 153, 116, 255),
                borderRadius: BorderRadius.circular(100)),
            child: Text(
              day,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.white),
            ),
          ),
          Text(
            location,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            '$temp°C',
            style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    condition,
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  Image.network(
                    'https:$icon',
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'H:$maxTemp°C',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'L:$minTemp°C',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 10),
          Expanded(
              child: Column(
            children: [
              Row(
                children: [
                  Card.filled(
                    color: Colors.amber,
                    child: Column(
                      children: [
                        Text("Humidity"),
                        Text("$humidity%", style: TextStyle(fontSize: 18)),
                      ],
                    ),
                  ),
                  Card.filled(
                    color: Colors.amber,
                    child: Column(
                      children: [
                        Text("Feels Like"),
                        Text("$feelsLike°C", style: TextStyle(fontSize: 18)),
                        Text(feelsLike > temp
                            ? "It feels warmer than the actual temperature"
                            : "It feels colder than the actual temperature"),
                      ],
                    ),
                  )
                ],
              )
            ],
          ))
        ],
      ),
    );

    // Column(
    //   children: [
    //     Image.network(
    //       'https:$icon',
    //       width: 50,
    //       height: 50,
    //     ),
    //     Text(
    //       '$day: $temp°C',
    //       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    //     ),
    //     Text(
    //       condition,
    //       style: TextStyle(color: Colors.grey[700]),
    //     ),
    //   ],
    // );
    // Card(
    //   margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    // child: ListTile(

    // ),
    // );
    //     },
    //   ),
    // );
  }

  // Utility function to get the day of the week from a Unix timestamp
  String _getDayOfWeek(int timestamp) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return [
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday'
    ][dateTime.weekday % 7];
  }
}
