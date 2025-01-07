import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CurrentWeather extends StatelessWidget {
  final double temperature;
  final String condition;
  final String location;
  final String icon;
  final String today;

  const CurrentWeather({
    super.key,
    required this.temperature,
    required this.condition,
    required this.location,
    required this.icon,
    required this.today,
  });

  @override
  Widget build(BuildContext context) {
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
              _getDayOfWeek(today),
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
            '${temperature.toStringAsFixed(1)}°C',
            style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
          ),
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
          )
        ],
      ),
    );
  }

  String _getDayOfWeek(String dateStr) {
    // final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    final date = DateFormat('yyyy-MM-dd').parse(dateStr);
    return [
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday'
    ][date.weekday % 7];
  }
}
