import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../models/videoModel.dart';

final videoProvider = StateNotifierProvider<VideoViewModel, List<VideoModel>>((ref) {
  return VideoViewModel();
});

class VideoViewModel extends StateNotifier<List<VideoModel>> {
  VideoViewModel() : super([]);

  Future<void> fetchVideos() async {
    try {
      final videoIds = [
        'eFDFooCflDdkcFcYxeKDSXeyW00FA00nXeOoMJeakvVSA',
        'w9qAyPlIaEAaeSuoB36r22xutGF800mXxZ00skcDKsjFc',
        'g5CwrZaaTWYdjb2peU818fzGkSvASW00tHnziQAQJq5I',
      ];

      final videos = videoIds.map((id) {
        return VideoModel(id: id, url: 'https://stream.mux.com/$id.m3u8');
      }).toList();

      state = videos;
    } catch (e) {
      print('Error fetching videos: $e');
    }
  }
}
