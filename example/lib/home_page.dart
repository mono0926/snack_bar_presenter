import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:snack_bar_presenter/snack_bar_presenter.dart';

import 'providers/providers.dart';

class HomePage extends HookWidget {
  const HomePage({Key key}) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: useProvider(_controller).scaffoldKey,
      appBar: AppBar(
        title: Text(useProvider(titleProvider)),
      ),
      body: ListView(
        children: [
          ...PageInfo.all.map((info) {
            return ListTile(
              title: Text(info.pageName),
              subtitle: info.subTitle == null ? null : Text(info.subTitle),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.of(context).pushNamed(info.routeName),
            );
          }),
        ],
      ),
    );
  }
}

final _controller = Provider.autoDispose((ref) => _Controller(ref));

class _Controller with SnackBarMixin {
  _Controller(this._ref) {
    registerToStackBarPresenter();
  }

  final ProviderReference _ref;

  @override
  SnackBarPresenter get snackBarPresenter =>
      _ref.read(snackBarPresenterProvider);

  void dispose() {
    unregisterFromStackBarPresenter();
  }
}
