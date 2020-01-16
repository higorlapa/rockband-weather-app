// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'splash_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SplashController on SplashBase, Store {
  final _$guitarOpacityAtom = Atom(name: 'SplashBase.guitarOpacity');

  @override
  double get guitarOpacity {
    _$guitarOpacityAtom.context.enforceReadPolicy(_$guitarOpacityAtom);
    _$guitarOpacityAtom.reportObserved();
    return super.guitarOpacity;
  }

  @override
  set guitarOpacity(double value) {
    _$guitarOpacityAtom.context.conditionallyRunInAction(() {
      super.guitarOpacity = value;
      _$guitarOpacityAtom.reportChanged();
    }, _$guitarOpacityAtom, name: '${_$guitarOpacityAtom.name}_set');
  }

  final _$SplashBaseActionController = ActionController(name: 'SplashBase');

  @override
  dynamic initUI() {
    final _$actionInfo = _$SplashBaseActionController.startAction();
    try {
      return super.initUI();
    } finally {
      _$SplashBaseActionController.endAction(_$actionInfo);
    }
  }
}
