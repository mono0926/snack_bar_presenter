import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';

final snackBarPresenterProvider = Provider((_) => SnackBarPresenter());

class SnackBarPresenter {
  final _scaffoldKeys = <GlobalKey<ScaffoldState>>[];

  VoidCallback register(GlobalKey<ScaffoldState> scaffoldKey) {
    assert(!_scaffoldKeys.contains(scaffoldKey));
    _scaffoldKeys.add(scaffoldKey);
    return () => _unregister(scaffoldKey);
  }

  void _unregister(GlobalKey<ScaffoldState> key) {
    assert(_scaffoldKeys.isEmpty ||
        _scaffoldKeys.last == key ||
        !_scaffoldKeys.contains(key));
    _scaffoldKeys.remove(key);
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showMessage(
    String message,
  ) {
    return show(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> show(
    SnackBar snackBar,
  ) {
    if (_scaffoldKeys.isEmpty) {
      assert(false, '_scaffoldKeys should not be empty');
      return null;
    }
    // Show SnackBar by using last ScaffoldKey
    final scaffoldState = _scaffoldKeys.last.currentState;
    if (scaffoldState == null) {
      assert(false, 'scaffoldState should not be null');
      return null;
    }
    scaffoldState.removeCurrentSnackBar();
    return scaffoldState.showSnackBar(snackBar);
  }

  void dispose() {
    _scaffoldKeys.clear();
  }
}
