import 'package:rockband_weather_app/models/current/current_sqlite_model.dart';
import 'package:rockband_weather_app/models/weather_model.dart';

class CurrentModel extends WeatherModel {
  int id;
  String cityName;
  int cityId;

  CurrentModel(
      {String main,
      String description,
      double temp,
      double tempMin,
      double tempMax,
      String iconCode,
      this.cityName,
      this.cityId,
      this.id})
      : assert(temp != null),
        assert(cityName != null),
        super(
            main: main,
            description: description,
            temp: temp,
            tempMin: tempMin,
            tempMax: tempMax,
            iconCode: iconCode);

  /// It will return an instance of [CurrentModel]
  /// the `json` argument must not be null
  /// this method was created to map the response of the API
  /// in the current model
  factory CurrentModel.fromJson(Map<String, dynamic> json) {
    var weatherResult = json['weather'][0];
    var mainResult = json['main'];
    return CurrentModel(
        main: weatherResult['main'],
        description: weatherResult['description'],
        temp: double.tryParse(mainResult['temp'].toString()),
        tempMin: double.parse(mainResult['temp_min'].toString()),
        tempMax: double.parse(mainResult['temp_max'].toString()),
        cityName: json['name'],
        cityId: json['id'],
        iconCode: weatherResult['icon']);
  }

  /// It will return an instance of [CurrentModel]
  /// the `map` argument must not be null
  /// this method was created to map the [CurrentSQLiteModel]
  /// from [weather.db] in the current one
  factory CurrentModel.fromMap(Map<String, dynamic> map) {
    return CurrentModel(
        main: map[CurrentSQLiteModel.FIELD_MAIN],
        description: map[CurrentSQLiteModel.FIELD_DESCRIPTION],
        temp: map[CurrentSQLiteModel.FIELD_TEMP],
        tempMin: map[CurrentSQLiteModel.FIELD_TEMP_MIN],
        tempMax: map[CurrentSQLiteModel.FIELD_TEMP_MAX],
        cityId: map[CurrentSQLiteModel.FIELD_CITY_ID],
        cityName: map[CurrentSQLiteModel.FIELD_CITY_NAME],
        iconCode: map[CurrentSQLiteModel.FIELD_ICON_CODE],
        id: map[CurrentSQLiteModel.FIELD_ID]);
  }
}
