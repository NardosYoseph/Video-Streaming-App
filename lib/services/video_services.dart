import 'dart:convert';
import 'package:http/http.dart' as http;

class VideoService {
  final String baseUrl = "https://stream.mux.com";

  Future<List<String>> fetchVideoUrls(List<String> videoIds) async {
    final List<String> videoUrls = [];
    for (var id in videoIds) {
      videoUrls.add("$baseUrl/$id.m3u8");
    }
    return videoUrls;
  }
}