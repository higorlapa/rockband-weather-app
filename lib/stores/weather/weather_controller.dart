import 'package:mobx/mobx.dart';
import 'package:rockband_weather_app/models/current/current_model.dart';
import 'package:rockband_weather_app/models/forecast/forecast_model.dart';
import 'package:rockband_weather_app/services/current/current_repository.dart';
import 'package:rockband_weather_app/services/forecast/forecast_repository.dart';
import 'package:rockband_weather_app/ui/forecast/forecast_page.dart';

part 'weather_controller.g.dart';

///The controller between the UI and the business logic.
///it holds the forecast and current logic.
class WeatherController = WeatherBase with _$WeatherController;

abstract class WeatherBase with Store {
  final _currentRepository = CurrentRepository();
  final _forecastRepository = ForecastRepository();

  /// Current current [ObservableList]
  @observable
  ObservableList<CurrentModel> currentList = ObservableList.of([]);

  /// Forecast current [ObservableList]
  @observable
  ObservableList<ForecastModel> forecastList = ObservableList.of([]);

  /// To avoid long lines of codes in the UI, we compute it here
  @computed
  CurrentModel get currentWeather => currentList[indexOfCity];

  /// The index of the city in the list of cities in [currentList],
  /// changing its value will change the current Weather in the
  /// [WeatherDetailsWidget]
  @observable
  int indexOfCity = 0;

  ///Populates the [currentList] from API or SQLite.
  ///Changing its value will result in the change of
  ///listed cities in [MainPage]
  @action
  Future<void> fetchWeather() async {
    var resultList = await _currentRepository.fetchWeatherList();
    this.currentList = ObservableList.of(resultList);
  }

  ///Populates the [forecastList] from API or SQLite.
  ///Changing its value will result in the change of
  ///forecast in [ForecastPage]
  @action
  Future<void> fetchForecast() async {
    forecastList = ObservableList.of([]);

    var resultList =
        await _forecastRepository.fetchForecastList(currentWeather.cityId);

    this.forecastList = ObservableList.of(resultList);
  }
}
