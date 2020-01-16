import 'package:rockband_weather_app/models/forecast/forecast_model.dart';
import 'package:rockband_weather_app/services/forecast/api/forecast_api_provider.dart';
import 'package:rockband_weather_app/services/forecast/sqlite/forecast_sqlite_provider.dart';

class ForecastRepository {
  ///Singleton instance. Calling it more than one time will result in the same
  ///instance of [ForecastRepository]
  static final ForecastRepository _forecastRepository =
      ForecastRepository._internal();

  factory ForecastRepository() => _forecastRepository;

  ForecastRepository._internal();

  Future<List<ForecastModel>> fetchForecastList(int cityId) async {
    List<ForecastModel> forecastList = await this._getForecastByCityId(cityId);

    if (forecastList != null && forecastList.length > 0) {
      //persist data in sql
      //so it can be available when there's no connection
      for (var forecast in forecastList) {
        await ForecastSQLiteProvider.insertForecast(forecast, cityId);
      }

      return forecastList;
    } else {
      //There was an error trying to fetch the data from API
      //try to get the data from local db.
      forecastList = await this._getForecastListFromDB(cityId);

      if (forecastList != null && forecastList.length > 0) return forecastList;
    }

    return null;
  }

  ///Perform a call to [ForecastSQLiteProvider] to return a list with [ForecastModel]
  ///with the [cityId] as parameter
  Future<List<ForecastModel>> _getForecastListFromDB(int cityId) async {
    return await ForecastSQLiteProvider.getForecastListFromDB(cityId);
  }

  ///Perform a call to [ForecastApiProvider] to return a list with [ForecastModel]
  ///with the [cityId] as parameter
  Future<List<ForecastModel>> _getForecastByCityId(int cityId) async {
    return await ForecastApiProvider.getForecastByCityId(cityId);
  }
}
