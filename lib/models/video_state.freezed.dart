// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'video_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$VideoState {
  bool get isPlaying => throw _privateConstructorUsedError;

  /// Create a copy of VideoState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VideoStateCopyWith<VideoState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VideoStateCopyWith<$Res> {
  factory $VideoStateCopyWith(
          VideoState value, $Res Function(VideoState) then) =
      _$VideoStateCopyWithImpl<$Res, VideoState>;
  @useResult
  $Res call({bool isPlaying});
}

/// @nodoc
class _$VideoStateCopyWithImpl<$Res, $Val extends VideoState>
    implements $VideoStateCopyWith<$Res> {
  _$VideoStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VideoState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isPlaying = null,
  }) {
    return _then(_value.copyWith(
      isPlaying: null == isPlaying
          ? _value.isPlaying
          : isPlaying // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VideoStateImplCopyWith<$Res>
    implements $VideoStateCopyWith<$Res> {
  factory _$$VideoStateImplCopyWith(
          _$VideoStateImpl value, $Res Function(_$VideoStateImpl) then) =
      __$$VideoStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isPlaying});
}

/// @nodoc
class __$$VideoStateImplCopyWithImpl<$Res>
    extends _$VideoStateCopyWithImpl<$Res, _$VideoStateImpl>
    implements _$$VideoStateImplCopyWith<$Res> {
  __$$VideoStateImplCopyWithImpl(
      _$VideoStateImpl _value, $Res Function(_$VideoStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of VideoState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isPlaying = null,
  }) {
    return _then(_$VideoStateImpl(
      isPlaying: null == isPlaying
          ? _value.isPlaying
          : isPlaying // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$VideoStateImpl implements _VideoState {
  const _$VideoStateImpl({required this.isPlaying});

  @override
  final bool isPlaying;

  @override
  String toString() {
    return 'VideoState(isPlaying: $isPlaying)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VideoStateImpl &&
            (identical(other.isPlaying, isPlaying) ||
                other.isPlaying == isPlaying));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isPlaying);

  /// Create a copy of VideoState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VideoStateImplCopyWith<_$VideoStateImpl> get copyWith =>
      __$$VideoStateImplCopyWithImpl<_$VideoStateImpl>(this, _$identity);
}

abstract class _VideoState implements VideoState {
  const factory _VideoState({required final bool isPlaying}) = _$VideoStateImpl;

  @override
  bool get isPlaying;

  /// Create a copy of VideoState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VideoStateImplCopyWith<_$VideoStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
