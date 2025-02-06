import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/videoModel.dart';
import '../repository/video_repository.dart';

final videoListProvider = FutureProvider<List<VideoModel>>((ref) async {
  final repository = VideoRepository();
  return repository.fetchVideos();
});

final videoPlaybackProvider = StateNotifierProvider<VideoPlaybackNotifier, VideoPlaybackState>((ref) {
  return VideoPlaybackNotifier();
});

class VideoPlaybackState {
  final bool isPlaying;
  final int currentIndex;

  VideoPlaybackState({this.isPlaying = true, this.currentIndex = 0});
}

class VideoPlaybackNotifier extends StateNotifier<VideoPlaybackState> {
  VideoPlaybackNotifier() : super(VideoPlaybackState());

  void togglePlayPause() {
    state = VideoPlaybackState(isPlaying: !state.isPlaying, currentIndex: state.currentIndex);
  }

  void setCurrentIndex(int index) {
    state = VideoPlaybackState(isPlaying: state.isPlaying, currentIndex: index);
  }
}