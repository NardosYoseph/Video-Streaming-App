// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'videoModel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$VideoModel {
  String get videoId => throw _privateConstructorUsedError;
  VideoPlayerController? get videoController =>
      throw _privateConstructorUsedError;
  ChewieController? get chewieController => throw _privateConstructorUsedError;

  /// Create a copy of VideoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VideoModelCopyWith<VideoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VideoModelCopyWith<$Res> {
  factory $VideoModelCopyWith(
          VideoModel value, $Res Function(VideoModel) then) =
      _$VideoModelCopyWithImpl<$Res, VideoModel>;
  @useResult
  $Res call(
      {String videoId,
      VideoPlayerController? videoController,
      ChewieController? chewieController});
}

/// @nodoc
class _$VideoModelCopyWithImpl<$Res, $Val extends VideoModel>
    implements $VideoModelCopyWith<$Res> {
  _$VideoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VideoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? videoId = null,
    Object? videoController = freezed,
    Object? chewieController = freezed,
  }) {
    return _then(_value.copyWith(
      videoId: null == videoId
          ? _value.videoId
          : videoId // ignore: cast_nullable_to_non_nullable
              as String,
      videoController: freezed == videoController
          ? _value.videoController
          : videoController // ignore: cast_nullable_to_non_nullable
              as VideoPlayerController?,
      chewieController: freezed == chewieController
          ? _value.chewieController
          : chewieController // ignore: cast_nullable_to_non_nullable
              as ChewieController?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VideoModelImplCopyWith<$Res>
    implements $VideoModelCopyWith<$Res> {
  factory _$$VideoModelImplCopyWith(
          _$VideoModelImpl value, $Res Function(_$VideoModelImpl) then) =
      __$$VideoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String videoId,
      VideoPlayerController? videoController,
      ChewieController? chewieController});
}

/// @nodoc
class __$$VideoModelImplCopyWithImpl<$Res>
    extends _$VideoModelCopyWithImpl<$Res, _$VideoModelImpl>
    implements _$$VideoModelImplCopyWith<$Res> {
  __$$VideoModelImplCopyWithImpl(
      _$VideoModelImpl _value, $Res Function(_$VideoModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of VideoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? videoId = null,
    Object? videoController = freezed,
    Object? chewieController = freezed,
  }) {
    return _then(_$VideoModelImpl(
      videoId: null == videoId
          ? _value.videoId
          : videoId // ignore: cast_nullable_to_non_nullable
              as String,
      videoController: freezed == videoController
          ? _value.videoController
          : videoController // ignore: cast_nullable_to_non_nullable
              as VideoPlayerController?,
      chewieController: freezed == chewieController
          ? _value.chewieController
          : chewieController // ignore: cast_nullable_to_non_nullable
              as ChewieController?,
    ));
  }
}

/// @nodoc

class _$VideoModelImpl implements _VideoModel {
  const _$VideoModelImpl(
      {required this.videoId, this.videoController, this.chewieController});

  @override
  final String videoId;
  @override
  final VideoPlayerController? videoController;
  @override
  final ChewieController? chewieController;

  @override
  String toString() {
    return 'VideoModel(videoId: $videoId, videoController: $videoController, chewieController: $chewieController)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VideoModelImpl &&
            (identical(other.videoId, videoId) || other.videoId == videoId) &&
            (identical(other.videoController, videoController) ||
                other.videoController == videoController) &&
            (identical(other.chewieController, chewieController) ||
                other.chewieController == chewieController));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, videoId, videoController, chewieController);

  /// Create a copy of VideoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VideoModelImplCopyWith<_$VideoModelImpl> get copyWith =>
      __$$VideoModelImplCopyWithImpl<_$VideoModelImpl>(this, _$identity);
}

abstract class _VideoModel implements VideoModel {
  const factory _VideoModel(
      {required final String videoId,
      final VideoPlayerController? videoController,
      final ChewieController? chewieController}) = _$VideoModelImpl;

  @override
  String get videoId;
  @override
  VideoPlayerController? get videoController;
  @override
  ChewieController? get chewieController;

  /// Create a copy of VideoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VideoModelImplCopyWith<_$VideoModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
