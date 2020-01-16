import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:weather_icons/weather_icons.dart';

abstract class WeatherModel {
  String main;
  String description;
  double temp;
  double tempMin;
  double tempMax;
  String iconCode;

  WeatherModel(
      {this.main,
      this.description,
      this.temp,
      this.tempMin,
      this.tempMax,
      this.iconCode})
      : assert(temp != null);
}
