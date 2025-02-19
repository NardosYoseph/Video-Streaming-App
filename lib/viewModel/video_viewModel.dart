import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../models/connectivity_status.dart';
import '../models/videoModel.dart';
import 'package:flutter/services.dart';

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
  int _currentIndex = 0; 

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
    _loadVideo(0); 
    _preloadVideo(1); 
    _preloadVideo(2); 
  }
void _loadVideo(int index) async {
  if (index < 0 || index >= state.length) return;
  if (state[index].videoController != null && state[index].videoController!.value.isInitialized) {
    state[index].chewieController?.play();
    return;
  }

  final url = "https://stream.mux.com/${state[index].videoId}.m3u8";

  try {
    final cachedM3u8Path = await VideoCache.getCachedVideo(url);

    if (cachedM3u8Path != null) {
  final cachedFile = File(cachedM3u8Path);
  if (await cachedFile.exists()) {
    final controller = VideoPlayerController.file(cachedFile);
    await controller.initialize();

    final chewieController = ChewieController(
      videoPlayerController: controller,
      autoPlay: true,
      looping: true,
      showControls: false,
    );

    state[index] = state[index].copyWith(
      videoController: controller,
      chewieController: chewieController,
    );
  }
 else {
        print("M3U8 file does not exist at path: $cachedM3u8Path");
      }
    } else {
      // Download and cache the .m3u8 file
      final response = await Dio().get(
        url,
        options: Options(responseType: ResponseType.bytes),
      );

      final m3u8FilePath = await VideoCache.cacheVideo(url, response.data);
      if (m3u8FilePath != null) {
        final m3u8Content = String.fromCharCodes(response.data);
        final tsUrls = _extractTsUrls(m3u8Content);

        // Cache all .ts segments
        for (final tsUrl in tsUrls) {
          final tsResponse = await Dio().get(
            tsUrl,
            options: Options(responseType: ResponseType.bytes),
          );
          await VideoCache.cacheVideo(tsUrl, tsResponse.data);
        }

        // Update the .m3u8 file to point to the cached .ts files
        final updatedM3u8Content = await _updateM3u8Content(m3u8Content);
        await File(m3u8FilePath).writeAsString(updatedM3u8Content);

        // Initialize the video player with the updated .m3u8 file
        final controller = VideoPlayerController.file(File(m3u8FilePath));
        await controller.initialize();
        final chewieController = ChewieController(
          videoPlayerController: controller,
          autoPlay: true,
          looping: true,
          showControls: false,
        );

        state[index] = state[index].copyWith(
          videoController: controller,
          chewieController: chewieController,
        );
      }
    }
  } on DioException catch (e) {
    print("Network error: ${e.message}");
  } on SocketException catch (e) {
    print("Socket error: ${e.message}");
  } catch (e) {
    print("Failed to load video: $e");
  }
}

Future<String> _updateM3u8Content(String m3u8Content) async {
  final lines = m3u8Content.split('\n');
  final updatedLines = await Future.wait(lines.map((line) async {
    if (line.endsWith('.ts')) {
      final tsUrl = line.trim();
      final cachedTsPath = await VideoCache.getCachedVideo(tsUrl);
      if (cachedTsPath != null) {
        return "file://$cachedTsPath";
      }
    }
    return line;
  }));
  return updatedLines.join('\n');
}

List<String> _extractTsUrls(String m3u8Content) {
  final lines = m3u8Content.split('\n');
  final tsUrls = lines.where((line) => line.endsWith('.ts')).toList();
  return tsUrls;
}

  void _preloadVideo(int index) async {
  if (index < 0 || index >= state.length || state[index].videoController != null) return;

  final url = "https://stream.mux.com/${state[index].videoId}.m3u8";

  try {
    final cachedM3u8Path = await VideoCache.getCachedVideo(url);

    if (cachedM3u8Path == null) {
      final response = await Dio().get(
        url,
        options: Options(responseType: ResponseType.bytes),
      );

      final m3u8FilePath = await VideoCache.cacheVideo(url, response.data);
      if (m3u8FilePath != null) {
        final m3u8Content = String.fromCharCodes(response.data);
        final tsUrls = _extractTsUrls(m3u8Content);

        for (final tsUrl in tsUrls) {
          final tsResponse = await Dio().get(
            tsUrl,
            options: Options(responseType: ResponseType.bytes),
          );
          await VideoCache.cacheVideo(tsUrl, tsResponse.data);
        }
      }
    }

    final controller = VideoPlayerController.file(File(cachedM3u8Path!));
    await controller.initialize();

    state[index] = state[index].copyWith(videoController: controller);
  } on DioException catch (e) {
    print("Preload network error: ${e.message}");
  } on SocketException catch (e) {
    print("Preload socket error: ${e.message}");
  } catch (e) {
    print("Failed to preload video: $e");
  }
}
  void onPageChanged(int index) {
  if (index < 0 || index >= state.length) return;
  state[_currentIndex].chewieController?.pause();
  _currentIndex = index;
  _loadVideo(index);
  _preloadVideo(index + 1); // Preload the next video
  _preloadVideo(index + 2); // Preload the next next video
  if (index > 0) _preloadVideo(index - 1); // Preload the previous video
}

  @override
  void dispose() {
    state.forEach((video) {
      video.videoController?.dispose();
      video.chewieController?.dispose();
    });
    super.dispose();
  }
}



class VideoCache {
  static const platform = MethodChannel('com.example.app/video_cache');

  static Future<String?> cacheVideo(String url, List<int> data) async {
    try {
      final String? filePath = await platform.invokeMethod('cacheVideo', {
        'url': url,
        'data': data,
      });

      return filePath;
    } on PlatformException catch (e) {
      print("Failed to cache video: ${e.message}");
      return null;
    }
  }

  static Future<String?> getCachedVideo(String url) async {
    try {
      final String? filePath = await platform.invokeMethod('getCachedVideo', {
        'url': url,
      });

      return filePath;
    } on PlatformException catch (e) {
      print("Failed to get cached video: ${e.message}");
      return null;
    }
  }

  static Future<void> clearCache() async {
    try {
      await platform.invokeMethod('clearCache');
    } on PlatformException catch (e) {
      print("Failed to clear cache: ${e.message}");
    }
  }
}