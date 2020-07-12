import 'package:example/pages/list_detail_page/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:snack_bar_presenter/snack_bar_presenter.dart';

import 'data_source.dart';

class GridPage extends HookWidget {
  const GridPage({Key key}) : super(key: key);

  static const routeName = '/list_detail';

  @override
  Widget build(BuildContext context) {
    final controller = useProvider(_controller);
    final dataSource = useProvider(dataSourceProvider);
    final animals = useProvider(dataSourceProvider.state);
    return Scaffold(
      key: controller.scaffoldKey,
      backgroundColor: Colors.blueGrey[
          Theme.of(context).brightness == Brightness.light ? 50 : 800],
      appBar: AppBar(title: const Text('List')),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        child: animals.isEmpty
            ? Center(
                child: Text(
                  'No dogs 😢',
                  style: Theme.of(context).textTheme.headline4,
                ),
              )
            : GridView.count(
                padding: const EdgeInsets.all(8),
                crossAxisCount: 2,
                children: animals
                    .map((animal) => Card(
                          margin: const EdgeInsets.all(8),
                          child: Stack(
                            children: [
                              InkWell(
                                onTap: () {
                                  initialAnimal.read(context).state = animal;
                                  return Navigator.of(context).push<void>(
                                    MaterialPageRoute(
                                      builder: (context) => const DetailPage(),
                                    ),
                                  );
                                },
                                child: Center(
                                  child: Hero(
                                    tag: animal,
                                    // For hero
                                    child: Material(
                                      child: Text(
                                        animal,
                                        style: const TextStyle(
                                          fontSize: 64,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () => dataSource.delete(animal),
                              ),
                            ],
                          ),
                        ))
                    .toList(),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.restore),
        onPressed: dataSource.reset,
      ),
    );
  }
}

final _controller = Provider.autoDispose(
  (ref) {
    final controller = _ListPageController(ref);
    ref.onDispose(controller.dispose);
    return controller;
  },
);

class _ListPageController with SnackBarMixin {
  _ListPageController(this._ref) {
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
