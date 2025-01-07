import 'package:flutter/material.dart';

class ForecastList extends StatelessWidget {
  final List<dynamic> forecast;
  final void Function(dynamic dayForecast) switchScreen;

  const ForecastList(
      {super.key, required this.forecast, required this.switchScreen});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: forecast.length - 1,
        itemBuilder: (context, index) {
          final dayForecast = forecast.sublist(1)[index];
          final day = _getDayOfWeek(dayForecast['date_epoch']);
          return TextButton(
            onPressed: () {
              switchScreen(dayForecast);
            },
            style: TextButton.styleFrom(
              // backgroundColor: Colors.amber,
              shape: ContinuousRectangleBorder(
                side: BorderSide.none,
                borderRadius: BorderRadius.zero,
              ),
              // padding: EdgeInsets.only(left: 0),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 0),
              leading: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: const Color.fromARGB(255, 153, 116, 255),
                    borderRadius: BorderRadius.all(
                      Radius.circular(100),
                    ),
                  ),
                  width: 100,
                  child: Text(
                    day,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  )),
              trailing: Text(dayForecast['date']),
              // Image.network("https:$dayForecast['day']['condition']['icon']"),
              title: Text("${dayForecast['day']['avgtemp_c']}°C"),
              subtitle: Row(
                children: [
                  Text(dayForecast['day']['condition']['text']),
                  Image.network(
                    'https:${dayForecast['day']['condition']['icon']}',
                    width: 30,
                    height: 30,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

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
