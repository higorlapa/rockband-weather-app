import 'package:mobx/mobx.dart';

part 'splash_controller.g.dart';

/// The controller of the [SplashScreen] view.
class SplashController = SplashBase with _$SplashController;

abstract class SplashBase with Store {
  /// img_guitar opacity value
  @observable
  double guitarOpacity = 0;

  ///Controls the opacity of the
  ///guitar image to animate it.
  @action
  initUI() {
    this.guitarOpacity = 1;
  }
}
