// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../home_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HomeState {
  List<NoteModel> get pinnedNotes => throw _privateConstructorUsedError;
  List<NoteModel> get otherNotes => throw _privateConstructorUsedError;
  List<NoteModel> get items => throw _privateConstructorUsedError;
  dynamic get status => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HomeStateCopyWith<HomeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeStateCopyWith<$Res> {
  factory $HomeStateCopyWith(HomeState value, $Res Function(HomeState) then) =
      _$HomeStateCopyWithImpl<$Res, HomeState>;
  @useResult
  $Res call(
      {List<NoteModel> pinnedNotes,
      List<NoteModel> otherNotes,
      List<NoteModel> items,
      dynamic status,
      String? errorMessage});
}

/// @nodoc
class _$HomeStateCopyWithImpl<$Res, $Val extends HomeState>
    implements $HomeStateCopyWith<$Res> {
  _$HomeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pinnedNotes = null,
    Object? otherNotes = null,
    Object? items = null,
    Object? status = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      pinnedNotes: null == pinnedNotes
          ? _value.pinnedNotes
          : pinnedNotes // ignore: cast_nullable_to_non_nullable
              as List<NoteModel>,
      otherNotes: null == otherNotes
          ? _value.otherNotes
          : otherNotes // ignore: cast_nullable_to_non_nullable
              as List<NoteModel>,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<NoteModel>,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as dynamic,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HomeStateImplCopyWith<$Res>
    implements $HomeStateCopyWith<$Res> {
  factory _$$HomeStateImplCopyWith(
          _$HomeStateImpl value, $Res Function(_$HomeStateImpl) then) =
      __$$HomeStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<NoteModel> pinnedNotes,
      List<NoteModel> otherNotes,
      List<NoteModel> items,
      dynamic status,
      String? errorMessage});
}

/// @nodoc
class __$$HomeStateImplCopyWithImpl<$Res>
    extends _$HomeStateCopyWithImpl<$Res, _$HomeStateImpl>
    implements _$$HomeStateImplCopyWith<$Res> {
  __$$HomeStateImplCopyWithImpl(
      _$HomeStateImpl _value, $Res Function(_$HomeStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pinnedNotes = null,
    Object? otherNotes = null,
    Object? items = null,
    Object? status = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_$HomeStateImpl(
      pinnedNotes: null == pinnedNotes
          ? _value._pinnedNotes
          : pinnedNotes // ignore: cast_nullable_to_non_nullable
              as List<NoteModel>,
      otherNotes: null == otherNotes
          ? _value._otherNotes
          : otherNotes // ignore: cast_nullable_to_non_nullable
              as List<NoteModel>,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<NoteModel>,
      status: freezed == status ? _value.status! : status,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$HomeStateImpl implements _HomeState {
  _$HomeStateImpl(
      {final List<NoteModel> pinnedNotes = const [],
      final List<NoteModel> otherNotes = const [],
      final List<NoteModel> items = const [],
      this.status = Status.initial,
      this.errorMessage})
      : _pinnedNotes = pinnedNotes,
        _otherNotes = otherNotes,
        _items = items;

  final List<NoteModel> _pinnedNotes;
  @override
  @JsonKey()
  List<NoteModel> get pinnedNotes {
    if (_pinnedNotes is EqualUnmodifiableListView) return _pinnedNotes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pinnedNotes);
  }

  final List<NoteModel> _otherNotes;
  @override
  @JsonKey()
  List<NoteModel> get otherNotes {
    if (_otherNotes is EqualUnmodifiableListView) return _otherNotes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_otherNotes);
  }

  final List<NoteModel> _items;
  @override
  @JsonKey()
  List<NoteModel> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  @JsonKey()
  final dynamic status;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'HomeState(pinnedNotes: $pinnedNotes, otherNotes: $otherNotes, items: $items, status: $status, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeStateImpl &&
            const DeepCollectionEquality()
                .equals(other._pinnedNotes, _pinnedNotes) &&
            const DeepCollectionEquality()
                .equals(other._otherNotes, _otherNotes) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            const DeepCollectionEquality().equals(other.status, status) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_pinnedNotes),
      const DeepCollectionEquality().hash(_otherNotes),
      const DeepCollectionEquality().hash(_items),
      const DeepCollectionEquality().hash(status),
      errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeStateImplCopyWith<_$HomeStateImpl> get copyWith =>
      __$$HomeStateImplCopyWithImpl<_$HomeStateImpl>(this, _$identity);
}

abstract class _HomeState implements HomeState {
  factory _HomeState(
      {final List<NoteModel> pinnedNotes,
      final List<NoteModel> otherNotes,
      final List<NoteModel> items,
      final dynamic status,
      final String? errorMessage}) = _$HomeStateImpl;

  @override
  List<NoteModel> get pinnedNotes;
  @override
  List<NoteModel> get otherNotes;
  @override
  List<NoteModel> get items;
  @override
  dynamic get status;
  @override
  String? get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$HomeStateImplCopyWith<_$HomeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
