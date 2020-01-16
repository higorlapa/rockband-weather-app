import 'package:rockband_weather_app/models/current/current_model.dart';
import 'package:rockband_weather_app/models/current/current_sqlite_model.dart';
import 'package:sqflite/sqflite.dart';

import '../../app_database.dart';

class CurrentSQLiteProvider {
  static Future<List<CurrentModel>> getLatestWeather() async {
    try {
      Database database = await AppDatabase.get().getDb();

      String sql = 'SELECT * FROM '
          '${CurrentSQLiteModel.TABLE} LIMIT 5';

      List<Map<String, dynamic>> mapList = await database.rawQuery(sql);

      if (mapList.length == 0) return null;

      List<CurrentModel> weatherList = List();

      for (var map in mapList) {
        weatherList.add(CurrentModel.fromMap(map));
      }

      return weatherList;
    } on Exception {
      return null;
    }
  }

  static Future<void> insertWeather(CurrentModel weather) async {
    try {
      var database = await AppDatabase.get().getDb();

      String main = weather.main != null ? '"${weather.main}"' : null;
      String cityName =
          weather.cityName != null ? '"${weather.cityName}"' : null;
      String iconCode =
          weather.iconCode != null ? '"${weather.iconCode}"' : null;

      String description =
          weather.description != null ? '"${weather.description}"' : null;

      var sql = "INSERT INTO ${CurrentSQLiteModel.TABLE} ("
          "${CurrentSQLiteModel.FIELD_CITY_ID},"
          "${CurrentSQLiteModel.FIELD_MAIN},"
          "${CurrentSQLiteModel.FIELD_TEMP},"
          "${CurrentSQLiteModel.FIELD_DESCRIPTION},"
          "${CurrentSQLiteModel.FIELD_TEMP_MIN},"
          "${CurrentSQLiteModel.FIELD_TEMP_MAX},"
          "${CurrentSQLiteModel.FIELD_CITY_NAME},"
          "${CurrentSQLiteModel.FIELD_ICON_CODE}"
          ")"
          "VALUES("
          "${weather.cityId},"
          "$main,"
          "${weather.temp},"
          "$description,"
          "${weather.tempMin},"
          "${weather.tempMax},"
          "$cityName,"
          "$iconCode"
          ")";

      await database.rawInsert(sql);
    } on Exception catch (ex) {
      print(ex.toString());
    }
  }
}
