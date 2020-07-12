import 'package:example/providers/navigator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:snack_bar_presenter/snack_bar_presenter.dart';
import 'package:state_notifier/state_notifier.dart';

import 'data_source.dart';

part 'detail_page.freezed.dart';

class DetailPage extends HookWidget {
  const DetailPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = useProvider(_controller);
    return Scaffold(
      key: controller.scaffoldKey,
      appBar: AppBar(
        title: Text(useProvider(_controller.state.select((s) => s.pageDesc))),
      ),
      body: PageView(
        controller: controller.pageController,
        children: useProvider(_controller.state.select((s) => s.animals))
            .map((animal) => _Page(
                  animal: animal,
                ))
            .toList(),
      ),
    );
  }
}

class _Page extends HookWidget {
  const _Page({
    Key key,
    @required this.animal,
  }) : super(key: key);

  final String animal;

  @override
  Widget build(BuildContext context) {
    final controller = useProvider(_controller);
    const buttonSize = 36.0;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final buttonColor = colorScheme.secondaryVariant;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Hero(
            tag: animal,
            child: Text(
              animal,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.75,
              ),
            ),
          ),
          const Gap(32),
          FlatButton.icon(
            icon: Icon(
              Icons.delete_outline,
              size: buttonSize,
              color: buttonColor,
            ),
            onPressed: () => controller.delete(animal),
            label: Text(
              'DELETE',
              style: TextStyle(
                fontSize: buttonSize,
                color: buttonColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final initialAnimal = StateProvider<String>((_) => null);

final _controller = StateNotifierProvider.autoDispose<_DetailPageController>(
  (ref) => _DetailPageController(ref),
);

@freezed
abstract class _DetailPageState with _$_DetailPageState {
  factory _DetailPageState({
    @Default(0) int currentPage,
    @required List<String> animals,
  }) = __DetailPageState;

  @late
  String get pageDesc =>
      animals.isEmpty ? '' : '${currentPage + 1} / ${animals.length}';
}

class _DetailPageController extends StateNotifier<_DetailPageState>
    with SnackBarMixin {
  _DetailPageController(this._ref)
      : pageController = PageController(
            initialPage: _ref
                .read(dataSourceProvider)
                .state
                .indexOf(_ref.read(initialAnimal).state)),
        super(_DetailPageState(
          animals: _ref.read(dataSourceProvider).state,
        )) {
    registerToStackBarPresenter();
    state = state.copyWith(
      currentPage: pageController.initialPage,
    );
    pageController.addListener(() {
      state = state.copyWith(
        currentPage: pageController.page.round(),
      );
    });
    removeDataSourceListener = _dataSource.addListener((animals) {
      if (!pageController.hasClients) {
        return;
      }
      final animal = state.animals[pageController.page.toInt()];
      pageController.jumpToPage(_dataSource.indexOfAnimal(animal));
      state = state.copyWith(
        animals: animals,
        currentPage: animals.indexOf(animal),
      );
    });
  }

  final ProviderReference _ref;
  final PageController pageController;
  RemoveListener removeDataSourceListener;

  DataSource get _dataSource => _ref.read(dataSourceProvider);
  NavigatorState get _navigatorState =>
      _ref.read(navigatorKeyProvider).currentState;

  void delete(String animal) {
    final nextAnimal = _dataSource.nextAnimal(animal);
    if (nextAnimal == null) {
      unregisterFromStackBarPresenter();
      _navigatorState.pop();
      _dataSource.delete(animal);
    } else {
      _dataSource.delete(animal);
      pageController.jumpToPage(
        _dataSource.indexOfAnimal(nextAnimal),
      );
    }
  }

  @override
  SnackBarPresenter get snackBarPresenter =>
      _ref.read(snackBarPresenterProvider);

  @override
  void dispose() {
    unregisterFromStackBarPresenter();
    pageController.dispose();
    removeDataSourceListener();

    super.dispose();
  }
}
