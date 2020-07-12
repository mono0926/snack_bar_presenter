import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';

final snackBarPresenterProvider = Provider((_) => SnackBarPresenter());

class SnackBarPresenter {
  final _scaffoldKeys = <GlobalKey<ScaffoldState>>[];

  ScaffoldState get scaffoldState {
    if (_scaffoldKeys.isEmpty) {
      assert(false, '_scaffoldKeys should not be empty');
      return null;
    }
    // Show SnackBar by using last ScaffoldKey
    return _scaffoldKeys.last.currentState;
  }

  BuildContext get context => scaffoldState.context;

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
    String text,
  ) {
    return show(
      SnackBar(
        content: Text(text),
      ),
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showUndo(
    String text, {
    @required VoidCallback onUndo,
    Color undoButtonColor,
    SnackBarL10n l10n = const SnackBarL10n(),
  }) {
    return show(
      SnackBar(
        content: Text(text),
        action: SnackBarAction(
          textColor: undoButtonColor ?? Theme.of(context).textSelectionColor,
          label: l10n.undo,
          onPressed: onUndo,
        ),
      ),
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showError(
    dynamic error, {
    SnackBarL10n l10n = const SnackBarL10n(),
  }) {
    return show(
      SnackBar(
        backgroundColor: Theme.of(context).colorScheme.error,
        content: Text(
          l10n.localizeError(error),
        ),
      ),
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> show(
    SnackBar snackBar,
  ) {
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

@immutable
class SnackBarL10n {
  const SnackBarL10n();
  String get undo => 'UNDO';
  String localizeError(dynamic error) => '$error';
}
