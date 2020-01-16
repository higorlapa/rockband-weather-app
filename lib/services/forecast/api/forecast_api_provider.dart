import 'dart:convert';

import 'package:rockband_weather_app/models/forecast/forecast_model.dart';
import 'package:http/http.dart' as http;
import 'package:rockband_weather_app/utils/util.dart';

class ForecastApiProvider {
  /// Perform a call to API with the [cityId] as parameter and the unit as an optional.
  static Future<List<ForecastModel>> getForecastByCityId(int cityId,
      {String unit = 'metric'}) async {
    try {
      String apiKey = await Util.getApiKey();
      String url =
          Util.kBaseUrl + "/forecast?id=$cityId&APPID=$apiKey&units=$unit";
      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        var jsonBody = jsonDecode(response.body);

        List<ForecastModel> weatherForecastList = List();

        int previousDay = 0;

        for (var json in jsonBody['list']) {
          var weatherModel = ForecastModel.fromJson(json);

          int currentDay = int.tryParse(weatherModel.date.substring(3, 5));

          if (currentDay != previousDay) {
            weatherForecastList.add(weatherModel);
            previousDay = currentDay;
          }
        }
        return weatherForecastList;
      } else
        return null;
    } on Exception catch (ex) {
      print(ex.toString());
      return null;
    }
  }
}
