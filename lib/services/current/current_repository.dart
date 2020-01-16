import 'package:rockband_weather_app/models/current/current_model.dart';
import 'package:rockband_weather_app/services/current/api/current_api_provider.dart';
import 'package:rockband_weather_app/services/current/sqlite/current_sqlite_provider.dart';

class CurrentRepository {
  ///Singleton instance. Calling it more than one time will result in the same
  ///instance of [CurrentRepository]
  static final CurrentRepository _weatherRepository =
      CurrentRepository._internal();

  factory CurrentRepository() => _weatherRepository;

  CurrentRepository._internal();

  /// The current main function at [CurrentRepository]
  /// Fetch the current current of cities with the
  /// static provided IDs, if it can't perform the API call,
  /// it will try to get the data from the SQLite, otherwise
  /// it returns null
  Future<List<CurrentModel>> fetchWeatherList() async {
    //Sao Paulo, SilverStone, Melbourne, monte carlo
    List<int> citiesIds = [3448439, 2637827, 2158177, 2992741];
    List<CurrentModel> weatherList =
        await this.getWeatherListByCitiesId(citiesIds);

    if (weatherList != null && weatherList.length > 0) {
      //persist data in sql
      //so it can be available when there's no connection
      for (var weather in weatherList) {
        await CurrentSQLiteProvider.insertWeather(weather);
      }

      return weatherList;
    } else {
      //There was an error trying to fetch the data from API
      //try to get the data from local db.
      weatherList = await this.getLatestWeather();

      if (weatherList != null && weatherList.length > 0) return weatherList;
    }

    return null;
  }

  /// private method to get the latest list of current saved in
  /// SQLite
  Future<List<CurrentModel>> getLatestWeather() async {
    return await CurrentSQLiteProvider.getLatestWeather();
  }

  /// private method to get the latest list of current from an API call
  /// with a list of ids as parameter;
  Future<List<CurrentModel>> getWeatherListByCitiesId(List<int> idList) async {
    return await CurrentApiProvider.getWeatherListByCitiesId(idList);
  }
}
