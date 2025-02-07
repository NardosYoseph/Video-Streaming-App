import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

import '../models/connectivity_status.dart';
import '../models/videoModel.dart';

// Provider for Connectivity Status
final connectivityProvider = StateNotifierProvider<ConnectivityNotifier, ConnectivityModel>((ref) {
  return ConnectivityNotifier();
});

class ConnectivityNotifier extends StateNotifier<ConnectivityModel> {
  ConnectivityNotifier() : super(ConnectivityModel(isOnline: true)) {
    _monitorNetwork();
  }

  void _monitorNetwork() {
    Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> results) {
      final isOnline = results.any((result) => result != ConnectivityResult.none);
      state = ConnectivityModel(isOnline: isOnline);
    });
  }
}

// Provider for Video Feed
final videoFeedProvider = StateNotifierProvider<VideoFeedNotifier, List<VideoModel>>((ref) {
  return VideoFeedNotifier(ref);
});

class VideoFeedNotifier extends StateNotifier<List<VideoModel>> {
  final Ref ref;
  int _currentIndex = 0; // Define _currentIndex here

  VideoFeedNotifier(this.ref) : super([]) {
    _initializeVideos();
  }

  void _initializeVideos() {
    final videoIds = [
      "eFDFooCflDdkcFcYxeKDSXeyW00FA00nXeOoMJeakvVSA",
      "w9qAyPlIaEAaeSuoB36r22xutGF800mXxZ00skcDKsjFc",
      "g5CwrZaaTWYdjb2peU818fzGkSvASW00tHnziQAQJq5I",
      "WrEk1kQpRcqAeTGCnrU00nJOUekJesdIL43NrYz01RYc",
      "zNvlO3QKLbe5Yu0101yQO8SRUDeycIL01cLOB02dhAvjhho",
      "TU4tu02tS7702jWUDVk5275JZvlNgv5WmyT6kLcV6awDw",
      "WVy89Zrbw15xAy8nFAGRljwAGGZq36BwNZSckOz1HU4"
    ];

    state = List.generate(
      videoIds.length,
      (index) => VideoModel(videoId: videoIds[index]),
    );
    _loadVideo(0); // Load first video immediately
    _preloadVideo(1); // Preload second video for faster transition
    _preloadVideo(2); // Preload the third video as well
  }

  void _loadVideo(int index) async {
    if (index < 0 || index >= state.length) return;
    if (state[index].videoController != null && state[index].videoController!.value.isInitialized) {
      state[index].chewieController?.play();
      return;
    }

    final url = "https://stream.mux.com/${state[index].videoId}.m3u8";
    final controller = VideoPlayerController.network(url);

    await controller.initialize();
    final chewieController = ChewieController(
      videoPlayerController: controller,
      autoPlay: true,
      looping: true,
      // Enable buffering options to improve performance
      showControls: false, // Hide controls if not needed to save resources
    );

    state[index] = state[index].copyWith(
      videoController: controller,
      chewieController: chewieController,
    );
  }

  void _preloadVideo(int index) {
    if (index < 0 || index >= state.length || state[index].videoController != null) return;

    final url = "https://stream.mux.com/${state[index].videoId}.m3u8";
    final controller = VideoPlayerController.network(url);

    controller.initialize().then((_) {
      state[index] = state[index].copyWith(videoController: controller);
    });
  }

  void onPageChanged(int index) {
    if (index < 0 || index >= state.length) return;
    state[_currentIndex].chewieController?.pause();
    _currentIndex = index;
    _loadVideo(index);
    _preloadVideo(index + 1); // Preload the next video
    if (index > 0) _preloadVideo(index - 1); // Preload the previous video
  }
}
