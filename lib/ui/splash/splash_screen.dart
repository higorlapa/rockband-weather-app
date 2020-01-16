import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:rockband_weather_app/stores/splash/splash_controller.dart';
import 'package:rockband_weather_app/ui/main/main_page.dart';

///The SplashScreen is used as the initial screen you see in the app to start it
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _splashController = SplashController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1C2834),
      body: Stack(
        children: <Widget>[
          Positioned(
              top: 0,
              child: Opacity(
                opacity: 0.3,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Image.asset('images/img_rain.png',
                      repeat: ImageRepeat.repeat),
                ),
              )),
          Center(child: Observer(
            builder: (_) {
              return AnimatedOpacity(
                opacity: _splashController.guitarOpacity,
                duration: const Duration(seconds: 1),
                child: Container(
                  width: 250,
                  child: Image.asset('images/img_guitar.png'),
                ),
              );
            },
          ))
        ],
      ),
    );
  }

  @override
  void initState() {
    ///Hide the Status Bar
    SystemChrome.setEnabledSystemUIOverlays([]);

    super.initState();

    ///After the bind of the widgets, we are safe to perform calls
    ///that will impact directly in the state of the view
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _splashController.initUI();

      _initMainPage();
    });
  }

  ///After 1.5 seconds, this method will open the [MainPage]
  Future<void> _initMainPage() async {
    await Future.delayed(const Duration(milliseconds: 1500), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => MainPage()));
    });
  }
}
