import 'package:sqflite/sqflite.dart';

/// Provide a simple way to  map the fields of the  [TABLE] in [current.db]
/// to save the date from [ForecastModel]
class ForecastSQLiteModel {
  static const String TABLE = "forecast_table";
  static const String FIELD_ID = "id";
  static const String FIELD_CITY_ID = "city_id"; //String
  static const String FIELD_DATE = "date_str"; //String
  static const String FIELD_MAIN = "main"; //String
  static const String FIELD_DESCRIPTION = "description"; //String
  static const String FIELD_TEMP = "temp"; //double
  static const String FIELD_TEMP_MIN = "temp_min"; //double
  static const String FIELD_TEMP_MAX = "temp_max"; //double
  static const String FIELD_ICON_CODE = "icon_code"; //String

  static Future<void> createTable(Database database) {
    var sql = 'CREATE TABLE $TABLE ('
        '$FIELD_ID INTEGER PRIMARY KEY AUTOINCREMENT,'
        '$FIELD_CITY_ID BIGINT,'
        '$FIELD_DATE TEXT,'
        '$FIELD_MAIN TEXT,'
        '$FIELD_DESCRIPTION TEXT,'
        '$FIELD_TEMP REAL,'
        '$FIELD_TEMP_MIN REAL,'
        '$FIELD_TEMP_MAX REAL,'
        '$FIELD_ICON_CODE TEXT'
        ');';

    return database.execute(sql);
  }
}
