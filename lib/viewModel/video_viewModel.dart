import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
// import 'package:video_player/video_player.dart';

import '../repository/video_repository.dart';

final videoViewModelProvider = StateNotifierProvider<VideoViewModel, List<String>>((ref) {
  return VideoViewModel();
});

class VideoViewModel extends StateNotifier<List<String>> {
  VideoViewModel() : super([]);

  final VideoRepository _repository = VideoRepository();
  final DefaultCacheManager _cacheManager = DefaultCacheManager();

  Future<void> fetchVideos(List<String> videoIds) async {
    final urls = await _repository.getVideoUrls(videoIds);
    state = urls;

    // Cache the first video
    if (urls.isNotEmpty) {
      await cacheVideo(urls[0]);
    }
  }

  Future<void> cacheVideo(String videoUrl) async {
    await _cacheManager.getSingleFile(videoUrl);
  }

  Future<String> getCachedVideoPath(String videoUrl) async {
    final file = await _cacheManager.getSingleFile(videoUrl);
    return file.path; // Returns the local file path
  }
}