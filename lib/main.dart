import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rockband_weather_app/stores/weather/weather_controller.dart';
import 'package:rockband_weather_app/ui/splash/splash_screen.dart';

/// the app starts here.
/// this method must execute [MyApp] to
/// successfully initialize the app
void main() async {
  ///This call is necessary to perform other calls before the `runApp`
  WidgetsFlutterBinding.ensureInitialized();

  ///Write the API key in the [FlutterSecureStorage]
  await FlutterSecureStorage()
      .write(key: 'api_key', value: "c8358c60ad214af3a2abcd4ea803a09f");

  ///Register [WeatherController] as a singleton to share
  ///code
  GetIt getIt = GetIt.I;
  getIt.registerSingleton<WeatherController>(WeatherController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RockBand Weather',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.purple,
          fontFamily: GoogleFonts.montserrat().fontFamily),
      home: SplashScreen(),
    );
  }
}
