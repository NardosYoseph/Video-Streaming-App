import 'package:chewie/chewie.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:video_player/video_player.dart';
part 'videoModel.freezed.dart';

// part 'videoModel.g.dart';

@freezed
class VideoModel with _$VideoModel {
  const factory VideoModel({
   required String videoId,
   VideoPlayerController? videoController,
  ChewieController? chewieController,
  }) = _VideoModel;

  // factory VideoModel.fromJson(Map<String, dynamic> json) => _$VideoModelFromJson(json);
}
