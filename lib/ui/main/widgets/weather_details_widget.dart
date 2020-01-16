import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:rockband_weather_app/stores/weather/weather_controller.dart';
import 'package:rockband_weather_app/ui/forecast/forecast_page.dart';

///The Widget to be displayed at the top of the [MainPage]
///when the data is loaded.
class WeatherDetailsWidget extends StatefulWidget {
  @override
  _WeatherDetailsWidgetState createState() => _WeatherDetailsWidgetState();
}

class _WeatherDetailsWidgetState extends State<WeatherDetailsWidget> {
  final _weatherController = GetIt.I.get<WeatherController>();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Column(
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height * 0.6,
              child: Card(
                  color: Color(0xff233342),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 20,
                          right: 0,
                          left: 0,
                          child: Text(
                            _weatherController.currentWeather.cityName ?? "",
                            style: TextStyle(fontSize: 28),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                '${_weatherController.currentWeather.temp} °C',
                                style: TextStyle(fontSize: 30),
                              ),
                              Text(
                                _weatherController.currentWeather.description ??
                                    "",
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Min. temp.'),
                              Text(
                                  '${_weatherController.currentWeather.tempMin} °C',
                                  style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text('Max. temp.'),
                              Text(
                                  '${_weatherController.currentWeather.tempMax} °C',
                                  style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            left: 0,
                            child: Center(
                                child: GestureDetector(
                              onTap: () {
                                if (_weatherController.currentWeather == null)
                                  return;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => ForecastPage()));
                              },
                              child: Container(
                                height: 30,
                                color: Color(0xff233342),
                                child: Text(
                                  'Forecast',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )))
                      ],
                    ),
                  ))),
        ],
      ),
    );
  }
}
