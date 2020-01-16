import 'package:rockband_weather_app/models/forecast/forecast_model.dart';
import 'package:rockband_weather_app/models/forecast/forecast_sqlite_model.dart';
import 'package:rockband_weather_app/services/app_database.dart';
import 'package:sqflite/sqflite.dart';

class ForecastSQLiteProvider {
  static Future<List<ForecastModel>> getForecastListFromDB(int cityId) async {
    try {
      Database database = await AppDatabase.get().getDb();

      String sql = "SELECT * FROM ${ForecastSQLiteModel.TABLE} WHERE "
          "${ForecastSQLiteModel.FIELD_CITY_ID} = $cityId LIMIT 5";

      List<Map<String, dynamic>> mapList = await database.rawQuery(sql);

      if (mapList.length == 0) return null;

      List<ForecastModel> forecastList = List();

      for (var map in mapList) {
        forecastList.add(ForecastModel.fromMap(map));
      }

      return forecastList;
    } on Exception {
      return null;
    }
  }

  static Future<void> insertForecast(ForecastModel weather, int cityId) async {
    try {
      Database database = await AppDatabase.get().getDb();

      String main = weather.main != null ? '"${weather.main}"' : null;
      String date = weather.date != null ? '"${weather.date}"' : null;
      String iconCode =
          weather.iconCode != null ? '"${weather.iconCode}"' : null;

      String description =
          weather.description != null ? '"${weather.description}"' : null;

      var sql = "INSERT INTO ${ForecastSQLiteModel.TABLE} ("
          "${ForecastSQLiteModel.FIELD_CITY_ID},"
          "${ForecastSQLiteModel.FIELD_MAIN},"
          "${ForecastSQLiteModel.FIELD_TEMP},"
          "${ForecastSQLiteModel.FIELD_DESCRIPTION},"
          "${ForecastSQLiteModel.FIELD_TEMP_MIN},"
          "${ForecastSQLiteModel.FIELD_TEMP_MAX},"
          "${ForecastSQLiteModel.FIELD_ICON_CODE},"
          "${ForecastSQLiteModel.FIELD_DATE}"
          ")"
          "VALUES("
          "$cityId,"
          "$main,"
          "${weather.temp},"
          "$description,"
          "${weather.tempMin},"
          "${weather.tempMax},"
          "$iconCode,"
          "$date"
          ")";

      await database.rawInsert(sql);
    } on Exception catch (ex) {
      print(ex.toString());
    }
  }
}
