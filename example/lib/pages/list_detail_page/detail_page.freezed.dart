// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'detail_page.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

class _$_DetailPageStateTearOff {
  const _$_DetailPageStateTearOff();

  __DetailPageState call(
      {int currentPage = 0, @required List<String> animals}) {
    return __DetailPageState(
      currentPage: currentPage,
      animals: animals,
    );
  }
}

// ignore: unused_element
const _$DetailPageState = _$_DetailPageStateTearOff();

mixin _$_DetailPageState {
  int get currentPage;
  List<String> get animals;

  _$DetailPageStateCopyWith<_DetailPageState> get copyWith;
}

abstract class _$DetailPageStateCopyWith<$Res> {
  factory _$DetailPageStateCopyWith(
          _DetailPageState value, $Res Function(_DetailPageState) then) =
      __$DetailPageStateCopyWithImpl<$Res>;
  $Res call({int currentPage, List<String> animals});
}

class __$DetailPageStateCopyWithImpl<$Res>
    implements _$DetailPageStateCopyWith<$Res> {
  __$DetailPageStateCopyWithImpl(this._value, this._then);

  final _DetailPageState _value;
  // ignore: unused_field
  final $Res Function(_DetailPageState) _then;

  @override
  $Res call({
    Object currentPage = freezed,
    Object animals = freezed,
  }) {
    return _then(_value.copyWith(
      currentPage:
          currentPage == freezed ? _value.currentPage : currentPage as int,
      animals: animals == freezed ? _value.animals : animals as List<String>,
    ));
  }
}

abstract class _$_DetailPageStateCopyWith<$Res>
    implements _$DetailPageStateCopyWith<$Res> {
  factory _$_DetailPageStateCopyWith(
          __DetailPageState value, $Res Function(__DetailPageState) then) =
      __$_DetailPageStateCopyWithImpl<$Res>;
  @override
  $Res call({int currentPage, List<String> animals});
}

class __$_DetailPageStateCopyWithImpl<$Res>
    extends __$DetailPageStateCopyWithImpl<$Res>
    implements _$_DetailPageStateCopyWith<$Res> {
  __$_DetailPageStateCopyWithImpl(
      __DetailPageState _value, $Res Function(__DetailPageState) _then)
      : super(_value, (v) => _then(v as __DetailPageState));

  @override
  __DetailPageState get _value => super._value as __DetailPageState;

  @override
  $Res call({
    Object currentPage = freezed,
    Object animals = freezed,
  }) {
    return _then(__DetailPageState(
      currentPage:
          currentPage == freezed ? _value.currentPage : currentPage as int,
      animals: animals == freezed ? _value.animals : animals as List<String>,
    ));
  }
}

class _$__DetailPageState
    with DiagnosticableTreeMixin
    implements __DetailPageState {
  _$__DetailPageState({this.currentPage = 0, @required this.animals})
      : assert(currentPage != null),
        assert(animals != null);

  @JsonKey(defaultValue: 0)
  @override
  final int currentPage;
  @override
  final List<String> animals;

  bool _didpageDesc = false;
  String _pageDesc;

  @override
  String get pageDesc {
    if (_didpageDesc == false) {
      _didpageDesc = true;
      _pageDesc =
          animals.isEmpty ? '' : '${currentPage + 1} / ${animals.length}';
    }
    return _pageDesc;
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_DetailPageState(currentPage: $currentPage, animals: $animals, pageDesc: $pageDesc)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', '_DetailPageState'))
      ..add(DiagnosticsProperty('currentPage', currentPage))
      ..add(DiagnosticsProperty('animals', animals))
      ..add(DiagnosticsProperty('pageDesc', pageDesc));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is __DetailPageState &&
            (identical(other.currentPage, currentPage) ||
                const DeepCollectionEquality()
                    .equals(other.currentPage, currentPage)) &&
            (identical(other.animals, animals) ||
                const DeepCollectionEquality().equals(other.animals, animals)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(currentPage) ^
      const DeepCollectionEquality().hash(animals);

  @override
  _$_DetailPageStateCopyWith<__DetailPageState> get copyWith =>
      __$_DetailPageStateCopyWithImpl<__DetailPageState>(this, _$identity);
}

abstract class __DetailPageState implements _DetailPageState {
  factory __DetailPageState({int currentPage, @required List<String> animals}) =
      _$__DetailPageState;

  @override
  int get currentPage;
  @override
  List<String> get animals;
  @override
  _$_DetailPageStateCopyWith<__DetailPageState> get copyWith;
}
