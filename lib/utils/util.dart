import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:weather_icons/weather_icons.dart';

class Util {
  /// Global variable to store the base_url for the main API
  static const String kBaseUrl = "https://api.openweathermap.org/data/2.5";

  /// get the API Key from the [FlutterSecureStorage] plugin
  static Future<String> getApiKey() async {
    return await FlutterSecureStorage().read(key: "api_key");
  }

  /// Covert the timestamp from the [WeatherModel] in formatted date.
  static String dateFromTimestamp(timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var formatter = DateFormat('MM/dd/yyyy');
    return formatter.format(date);
  }

  /// Map some of the icon codes provided by the API
  static IconData getIconFromCode(String iconString) {
    switch (iconString) {
      case '01d':
        return WeatherIcons.day_sunny;
      case '01n':
        return WeatherIcons.night_clear;
      case '02d':
        return WeatherIcons.day_cloudy;
      case '02n':
        return WeatherIcons.night_cloudy;
      case '09d':
      case '10d':
        return WeatherIcons.day_rain;
      case '09n':
      case '10n':
        return WeatherIcons.night_rain;
      case '11d':
        return WeatherIcons.day_storm_showers;
      case '11n':
        return WeatherIcons.night_storm_showers;
      case '13d':
        return WeatherIcons.day_snow;
      case '13n':
        return WeatherIcons.night_snow;
      case '50d':
        return WeatherIcons.day_rain_mix;
      case '50n':
        return WeatherIcons.night_rain_mix;
      default:
        return WeatherIcons.day_cloudy;
    }
  }
}
