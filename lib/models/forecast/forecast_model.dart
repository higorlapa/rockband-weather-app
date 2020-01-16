import 'package:rockband_weather_app/models/weather_model.dart';
import 'package:rockband_weather_app/models/forecast/forecast_sqlite_model.dart';
import 'package:rockband_weather_app/utils/util.dart';

class ForecastModel extends WeatherModel {
  int id;
  String date;
  int cityId;

  ForecastModel(
      {String main,
      String description,
      double temp,
      double tempMin,
      double tempMax,
      String iconCode,
      this.date,
      this.cityId,
      this.id})
      : super(
            main: main,
            description: description,
            temp: temp,
            tempMin: tempMin,
            tempMax: tempMax,
            iconCode: iconCode);

  /// It will return an instance of [ForecastModel]
  /// the `json` argument must not be null
  /// this method was created to map the response of the API
  /// in the current model
  factory ForecastModel.fromJson(Map<String, dynamic> json) {
    var weatherResult = json['weather'][0];
    var mainResult = json['main'];

    return ForecastModel(
        main: weatherResult['main'],
        description: weatherResult['description'],
        temp: double.tryParse(mainResult['temp'].toString()),
        tempMin: double.parse(mainResult['temp_min'].toString()),
        tempMax: double.parse(mainResult['temp_max'].toString()),
        cityId: json['id'],
        date: Util.dateFromTimestamp(json['dt']),
        iconCode: weatherResult['icon']);
  }

  /// It will return an instance of [ForecastModel]
  /// the `map` argument must not be null
  /// this method was created to map the [ForecastSQLiteModel]
  /// from [weather.db] in the current one
  factory ForecastModel.fromMap(Map<String, dynamic> map) {
    return ForecastModel(
        main: map[ForecastSQLiteModel.FIELD_MAIN],
        description: map[ForecastSQLiteModel.FIELD_DESCRIPTION],
        temp: map[ForecastSQLiteModel.FIELD_TEMP],
        tempMin: map[ForecastSQLiteModel.FIELD_TEMP_MIN],
        tempMax: map[ForecastSQLiteModel.FIELD_TEMP_MAX],
        cityId: map[ForecastSQLiteModel.FIELD_CITY_ID],
        date: map[ForecastSQLiteModel.FIELD_DATE],
        iconCode: map[ForecastSQLiteModel.FIELD_ICON_CODE],
        id: map[ForecastSQLiteModel.FIELD_ID]);
  }
}
