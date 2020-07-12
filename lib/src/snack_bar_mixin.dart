import 'package:flutter/material.dart';
import 'package:snack_bar_presenter/snack_bar_presenter.dart';

mixin SnackBarMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  SnackBarPresenter get snackBarPresenter;
  VoidCallback _unregisterSnackBarRegistration;

  @protected
  void registerToStackBarPresenter() {
    _unregisterSnackBarRegistration = snackBarPresenter.register(scaffoldKey);
  }

  @protected
  void unregisterFromStackBarPresenter() {
    _unregisterSnackBarRegistration();
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBarMessage(
    String message,
  ) {
    return snackBarPresenter.showMessage(message);
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
    SnackBar snackBar,
  ) {
    return snackBarPresenter.show(snackBar);
  }
}
