import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:rockband_weather_app/stores/weather/weather_controller.dart';
import 'package:rockband_weather_app/ui/main/widgets/weather_details_widget.dart';
import 'package:rockband_weather_app/utils/util.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _weatherController = GetIt.I.get<WeatherController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "RockBand Weather",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Color(0xff1C2834),
        ),
        backgroundColor: Color(0xff1C2834),
        body: Stack(
          children: <Widget>[
            Positioned(
                top: 20,
                left: 0,
                right: 0,
                child: Observer(
                    builder: (_) => _weatherController.currentList.isNotEmpty
                        ? Padding(
                            child: WeatherDetailsWidget(),
                            padding: EdgeInsets.symmetric(horizontal: 5),
                          )
                        : Center(
                            child: Text("Loading..."),
                          ))),
            Positioned(
                left: 0,
                bottom: 10,
                right: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Center(
                    child: Observer(
                      builder: (_) => _weatherController.currentList.isNotEmpty
                          ? SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: _weatherWidgetList()))
                          : Text("Loading..."),
                    ),
                  ),
                )),
          ],
        ));
  }

  /// Build the cities list at the bottom of the [Scaffold]
  /// the tap control will impact directly in [WeatherDetailsWidget]
  /// changing its state to the current current set by the index in
  /// [_weatherController.currentList]
  List<Widget> _weatherWidgetList() {
    List<Widget> widgetList = List();

    for (int index = 0;
        index < _weatherController.currentList.length;
        index++) {
      widgetList.add(GestureDetector(
        onTap: () {
          _weatherController.indexOfCity = index;
        },
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                color: Color(0xff233342).withOpacity(0.40)),
            width: 100,
            height: 100,
            padding: EdgeInsets.symmetric(horizontal: 5),
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Center(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 2),
                  child: Text(
                    _weatherController.currentList[index].cityName,
                    textAlign: TextAlign.center,
                  ),
                ),
                Icon(Util.getIconFromCode(
                    _weatherController.currentList[index].iconCode))
              ],
            ))),
      ));
    }

    return widgetList;
  }

  @override
  void initState() {
    ///Recover the regular view of the app, displaying the status bar
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    super.initState();

    ///After the bind of the widgets, we are safe to perform calls
    ///that will impact directly in the state of the view
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _weatherController.fetchWeather();
    });
  }
}
