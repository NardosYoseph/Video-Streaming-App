import 'dart:async';
import 'package:flutter/services.dart';
import '../models/videoModel.dart';

class VideoRepository {
  static const MethodChannel _channel = MethodChannel('video_cache');
  List<VideoModel> _videoQueue = [];

  Future<List<VideoModel>> fetchVideos() async {
    try {
      final videoIds = [
        'eFDFooCflDdkcFcYxeKDSXeyW00FA00nXeOoMJeakvVSA',
        'w9qAyPlIaEAaeSuoB36r22xutGF800mXxZ00skcDKsjFc',
        'g5CwrZaaTWYdjb2peU818fzGkSvASW00tHnziQAQJq5I',
        'WrEk1kQpRcqAeTGCnrU00nJOUekJesdIL43NrYz01RYc',
        'zNvlO3QKLbe5Yu0101yQO8SRUDeycIL01cLOB02dhAvjhho',
        'TU4tu02tS7702jWUDVk5275JZvlNgv5WmyT6kLcV6awDw',
        'WVy89Zrbw15xAy8nFAGRljwAGGZq36BwNZSckOz1HU4',
        'ApFgkkaJc1SPL64C7XF2dA00Nh1iny00Dr67kVZxRptfQ'
      ];

      final videos = await Future.wait(videoIds.map((id) async {
        final url = 'https://stream.mux.com/$id.m3u8';
        await _channel.invokeMethod('cacheVideo', {'url': url}); // Cache the video
        return VideoModel(id: id, url: url);
      }));

      _videoQueue = videos; // Store the video queue for preloading
      _preloadNextVideo(0); // Start preloading the first video

      return videos;
    } catch (e) {
      throw Exception('Error fetching videos: $e');
    }
  }

  void _preloadNextVideo(int currentIndex) {
    print("preloading inside repo************************");
    if (currentIndex + 1 < _videoQueue.length) {
      final nextUrl = _videoQueue[currentIndex + 1].url;
      _channel.invokeMethod('cacheVideo', {'url': nextUrl});
    print("preloaded inside repo************************");
       // Cache the next video
    }
  }
}