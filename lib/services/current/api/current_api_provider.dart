import 'package:rockband_weather_app/models/current/current_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:rockband_weather_app/utils/util.dart';

class CurrentApiProvider {
  /// Perform a call to API with a list of int ([listId]) as parameter and the unit as an optional.
  static Future<List<CurrentModel>> getWeatherListByCitiesId(List<int> listId,
      {String unit = 'metric'}) async {
    try {
      String apiKey = await Util.getApiKey();

      String list = listId.join(",");

      String getUrl =
          Util.kBaseUrl + '/group?id=$list&APPID=$apiKey&units=$unit';
      http.Response response = await http.get(getUrl);

      var jsonBody;
      if (response.statusCode == 200) {
        jsonBody = jsonDecode(response.body);
      } else
        throw Exception("WeatherApiProvider: bad status code");

      List<CurrentModel> weatherReturnList = List();

      for (var map in jsonBody['list']) {
        weatherReturnList.add(CurrentModel.fromJson(map));
      }
      return weatherReturnList;
    } on Exception catch (ex) {
      print(ex.toString());
      return null;
    }
  }
}
