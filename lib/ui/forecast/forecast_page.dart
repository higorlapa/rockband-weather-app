import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:rockband_weather_app/stores/weather/weather_controller.dart';
import 'package:rockband_weather_app/ui/forecast/widgets/forecast_item_widget.dart';

class ForecastPage extends StatefulWidget {
  @override
  _ForecastPageState createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage> {
  final _weatherController = GetIt.I.get<WeatherController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_weatherController.currentWeather.cityName),
        backgroundColor: Color(0xff1C2834),
        elevation: 0,
      ),
      backgroundColor: Color(0xff1C2834),
      body: Observer(
          builder: (_) => _weatherController.forecastList.isNotEmpty
              ? ListView(
                  children: _forecastWidgetBuilder(),
                )
              : Center(
                  child: Text('Loading'),
                )),
    );
  }

  @override
  void initState() {
    super.initState();

    /// After the final binding of the widgets,
    /// we are safe to perform calls that will impact
    /// the state of them
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _weatherController.fetchForecast();
    });
  }

  ///Build the [ForecastItemWidget] list
  ///[_weatherController.forecastList] must not be null
  List<Widget> _forecastWidgetBuilder() {
    List<Widget> returnList = List();

    for (var forecastDay in _weatherController.forecastList) {
      returnList.add(ForecastItemWidget(forecastWeatherModel: forecastDay));
    }

    return returnList;
  }
}
