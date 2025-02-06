import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_state.freezed.dart';

@freezed
class VideoState with _$VideoState {
  const factory VideoState({
    required bool isPlaying,
  }) = _VideoState;
}
