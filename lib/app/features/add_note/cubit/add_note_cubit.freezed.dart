// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_note_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AddNoteState {
  dynamic get status => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AddNoteStateCopyWith<AddNoteState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddNoteStateCopyWith<$Res> {
  factory $AddNoteStateCopyWith(
          AddNoteState value, $Res Function(AddNoteState) then) =
      _$AddNoteStateCopyWithImpl<$Res, AddNoteState>;
  @useResult
  $Res call({dynamic status, String? errorMessage});
}

/// @nodoc
class _$AddNoteStateCopyWithImpl<$Res, $Val extends AddNoteState>
    implements $AddNoteStateCopyWith<$Res> {
  _$AddNoteStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
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
abstract class _$$AddNoteStateImplCopyWith<$Res>
    implements $AddNoteStateCopyWith<$Res> {
  factory _$$AddNoteStateImplCopyWith(
          _$AddNoteStateImpl value, $Res Function(_$AddNoteStateImpl) then) =
      __$$AddNoteStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({dynamic status, String? errorMessage});
}

/// @nodoc
class __$$AddNoteStateImplCopyWithImpl<$Res>
    extends _$AddNoteStateCopyWithImpl<$Res, _$AddNoteStateImpl>
    implements _$$AddNoteStateImplCopyWith<$Res> {
  __$$AddNoteStateImplCopyWithImpl(
      _$AddNoteStateImpl _value, $Res Function(_$AddNoteStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_$AddNoteStateImpl(
      status: freezed == status ? _value.status! : status,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$AddNoteStateImpl implements _AddNoteState {
  _$AddNoteStateImpl({this.status = Status.initial, this.errorMessage});

  @override
  @JsonKey()
  final dynamic status;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'AddNoteState(status: $status, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddNoteStateImpl &&
            const DeepCollectionEquality().equals(other.status, status) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(status), errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddNoteStateImplCopyWith<_$AddNoteStateImpl> get copyWith =>
      __$$AddNoteStateImplCopyWithImpl<_$AddNoteStateImpl>(this, _$identity);
}

abstract class _AddNoteState implements AddNoteState {
  factory _AddNoteState({final dynamic status, final String? errorMessage}) =
      _$AddNoteStateImpl;

  @override
  dynamic get status;
  @override
  String? get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$AddNoteStateImplCopyWith<_$AddNoteStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
