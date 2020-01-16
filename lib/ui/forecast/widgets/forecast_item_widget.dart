import 'package:flutter/material.dart';
import 'package:rockband_weather_app/models/forecast/forecast_model.dart';
import 'package:rockband_weather_app/utils/util.dart';

///The widget item do be listed in the [ForecastPage] in
///a list of widgets
class ForecastItemWidget extends StatelessWidget {
  final ForecastModel forecastWeatherModel;

  ForecastItemWidget({this.forecastWeatherModel})
      : assert(forecastWeatherModel != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          color: Color(0xff233342).withOpacity(0.40)),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text("Temp: ${forecastWeatherModel.temp}°C "),
          Text(" Date: ${forecastWeatherModel.date} "),
          Icon(Util.getIconFromCode(forecastWeatherModel.iconCode))
        ],
      ),
    );
  }
}
