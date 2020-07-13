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

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showUndoSnackBar(
    String text, {
    @required VoidCallback onUndo,
    Color undoButtonColor,
    SnackBarL10n l10n = const SnackBarL10n(),
  }) {
    return snackBarPresenter.showUndo(
      text,
      onUndo: onUndo,
      undoButtonColor: undoButtonColor,
      l10n: l10n,
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
      showSnackBarMessageWithAction(
    String text, {
    @required VoidCallback onAction,
    @required String actionLabel,
    Color actionColor,
  }) {
    return snackBarPresenter.showMessageWithAction(
      text,
      onAction: onAction,
      actionLabel: actionLabel,
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showErrorSnackBar(
    dynamic error, {
    SnackBarL10n l10n = const SnackBarL10n(),
  }) {
    return snackBarPresenter.showError(
      error,
      l10n: l10n,
    );
  }
}
