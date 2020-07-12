import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:example/providers/providers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:state_notifier/state_notifier.dart';

final lightTheme =
    ThemeData.from(colorScheme: const ColorScheme.light())._applyCommon();
final darkTheme =
    ThemeData.from(colorScheme: const ColorScheme.dark())._applyCommon();

extension _ThemeDataEx on ThemeData {
  ThemeData _applyCommon() {
    return copyWith(
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

final themeProvider = StateNotifierProvider((ref) => _ThemeController(ref));

class _ThemeController extends StateNotifier<ThemeMode> {
  _ThemeController(this._ref) : super(ThemeMode.system);

  final ProviderReference _ref;

  Future<void> showThemeSelection() async {
    state = await showModalActionSheet(
      context: _ref.read(navigatorKeyProvider).currentState.descendantContext,
      title: 'Theme',
      message: 'Current: ${describeEnum(state)}',
      actions: ThemeMode.values
          .map((mode) => SheetAction(
                label: describeEnum(mode),
                key: mode,
              ))
          .toList(),
    );
  }
}
