// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$WeatherController on WeatherBase, Store {
  Computed<CurrentModel> _$currentWeatherComputed;

  @override
  CurrentModel get currentWeather => (_$currentWeatherComputed ??=
          Computed<CurrentModel>(() => super.currentWeather))
      .value;

  final _$currentListAtom = Atom(name: 'WeatherBase.currentList');

  @override
  ObservableList<CurrentModel> get currentList {
    _$currentListAtom.context.enforceReadPolicy(_$currentListAtom);
    _$currentListAtom.reportObserved();
    return super.currentList;
  }

  @override
  set currentList(ObservableList<CurrentModel> value) {
    _$currentListAtom.context.conditionallyRunInAction(() {
      super.currentList = value;
      _$currentListAtom.reportChanged();
    }, _$currentListAtom, name: '${_$currentListAtom.name}_set');
  }

  final _$forecastListAtom = Atom(name: 'WeatherBase.forecastList');

  @override
  ObservableList<ForecastModel> get forecastList {
    _$forecastListAtom.context.enforceReadPolicy(_$forecastListAtom);
    _$forecastListAtom.reportObserved();
    return super.forecastList;
  }

  @override
  set forecastList(ObservableList<ForecastModel> value) {
    _$forecastListAtom.context.conditionallyRunInAction(() {
      super.forecastList = value;
      _$forecastListAtom.reportChanged();
    }, _$forecastListAtom, name: '${_$forecastListAtom.name}_set');
  }

  final _$indexOfCityAtom = Atom(name: 'WeatherBase.indexOfCity');

  @override
  int get indexOfCity {
    _$indexOfCityAtom.context.enforceReadPolicy(_$indexOfCityAtom);
    _$indexOfCityAtom.reportObserved();
    return super.indexOfCity;
  }

  @override
  set indexOfCity(int value) {
    _$indexOfCityAtom.context.conditionallyRunInAction(() {
      super.indexOfCity = value;
      _$indexOfCityAtom.reportChanged();
    }, _$indexOfCityAtom, name: '${_$indexOfCityAtom.name}_set');
  }

  final _$fetchWeatherAsyncAction = AsyncAction('fetchWeather');

  @override
  Future<void> fetchWeather() {
    return _$fetchWeatherAsyncAction.run(() => super.fetchWeather());
  }

  final _$fetchForecastAsyncAction = AsyncAction('fetchForecast');

  @override
  Future<void> fetchForecast() {
    return _$fetchForecastAsyncAction.run(() => super.fetchForecast());
  }
}
