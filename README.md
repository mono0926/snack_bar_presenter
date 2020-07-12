# snack_bar_presenter

Provider easy and flexible way to show SnackBar


. | . | .
--- | --- | ---
![Screenshot_1594537088](https://user-images.githubusercontent.com/1255062/87240896-8a057100-c458-11ea-9343-9855868f723b.png) | ![Screenshot_1594537095](https://user-images.githubusercontent.com/1255062/87240897-8c67cb00-c458-11ea-958a-cbe70134903c.png) | ![Screenshot_1594537100](https://user-images.githubusercontent.com/1255062/87240899-8eca2500-c458-11ea-9efa-c23e4e386ec3.png)

## Usage

```dart
import 'package:example/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:snack_bar_presenter/snack_bar_presenter.dart';

class BasicPage extends HookWidget {
  const BasicPage({
    Key key,
    this.index = 0,
  }) : super(key: key);

  final int index;

  static const routeName = '/basic';

  @override
  Widget build(BuildContext context) {
    final controller = useProvider(_controllers(index));
    final canPop = useProvider(navigatorKeyProvider).currentState.canPop();
    return Scaffold(
      key: controller.scaffoldKey,
      appBar: AppBar(title: Text('index: $index')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RaisedButton(
              child: const Text('Show SnackBar'),
              onPressed: () => controller.showSnackBarMessage('Hey(　´･‿･｀)'),
            ),
            RaisedButton(
              child: const Text('👉 Navigate to next page'),
              onPressed: () {
                Navigator.of(context).push<void>(
                  MaterialPageRoute(
                    builder: (context) => BasicPage(
                      index: index + 1,
                    ),
                  ),
                );
              },
            ),
            if (canPop)
              RaisedButton(
                child: const Text('👈 Pop and show SnackBar'),
                onPressed: controller.popAndShowSnackBar,
              ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}

final _controllers = Provider.autoDispose.family<_Controller, int>(
  (ref, __) {
    final controller = _Controller(ref);
    ref.onDispose(controller.dispose);
    return controller;
  },
);

class _Controller with SnackBarMixin {
  _Controller(this._ref) {
    registerToStackBarPresenter();
  }

  final ProviderReference _ref;

  @override
  SnackBarPresenter get snackBarPresenter =>
      _ref.read(snackBarPresenterProvider);

  void popAndShowSnackBar() {
    _ref.read(navigatorKeyProvider).currentState.pop();
    // Remove registration before showing SnackBar
    unregisterFromStackBarPresenter();
    showSnackBarMessage('Came back(　´･‿･｀)');
  }

  void dispose() {
    unregisterFromStackBarPresenter();
  }
}
```