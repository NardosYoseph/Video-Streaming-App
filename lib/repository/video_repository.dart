import 'package:flutter/services.dart';

import '../services/video_services.dart';

class VideoRepository {
  final VideoService _videoService = VideoService();
  static const MethodChannel _channel = MethodChannel('com.example.video_swipe_app/video_cache');

  Future<List<String>> getVideoUrls(List<String> videoIds) async {
    final urls = await _videoService.fetchVideoUrls(videoIds);
    return urls;
  }

  Future<void> cacheVideo(String videoUrl) async {
    try {
      await _channel.invokeMethod('cacheVideo', {'videoUrl': videoUrl});
    } on PlatformException catch (e) {
      print("Failed to cache video: ${e.message}");
    }
  }
}