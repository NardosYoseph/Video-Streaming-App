import 'package:flutter/services.dart';

class NativeVideoCache {
  static const MethodChannel _channel = MethodChannel('com.example.video_swipe_app/video_cache');

  // Method to call Kotlin code for caching
  static Future<void> cacheVideo(String videoUrl) async {
    try {
      await _channel.invokeMethod('cacheVideo', {'videoUrl': videoUrl});
    } on PlatformException catch (e) {
      print("Failed to cache video: ${e.message}");
    }
  }

  // Method to call Kotlin code for background playback
  static Future<void> startBackgroundPlayback() async {
    try {
      await _channel.invokeMethod('startBackgroundPlayback');
    } on PlatformException catch (e) {
      print("Failed to start background playback: ${e.message}");
    }
  }
}