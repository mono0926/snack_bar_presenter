import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:snack_bar_presenter/snack_bar_presenter.dart';
import 'package:state_notifier/state_notifier.dart';

final dataSourceProvider =
    StateNotifierProvider.autoDispose((ref) => DataSource(ref));

class DataSource extends StateNotifier<List<String>> {
  DataSource(this._ref) : super(_initialState);

  final ProviderReference _ref;

  static final _initialState = ['🐶', '🦮', '🐕'];

  void reset() {
    state = _initialState;
  }

  void delete(String animal) {
    final lastState = state;
    state = List.of(state)..remove(animal);
    _ref.read(snackBarPresenterProvider).showUndo(
          '$animal was deleted',
          onUndo: () => state = lastState,
        );
  }

  int indexOfAnimal(String animal) => state.indexOf(animal);

  String animalOfIndex(int index) => state[index];

  String nextAnimal(String animal) {
    final index = state.indexOf(animal);
    if (index == -1) {
      return null;
    }

    return index < state.length - 1
        ? state[index + 1]
        : index > 0 ? state[index - 1] : null;
  }
}
