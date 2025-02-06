import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_streaming_app/models/connectivity_status.dart';
import 'package:video_streaming_app/widgets/custom_snackbar.dart';
import '../viewModel/connectivity_viewModel.dart';
import '../viewModel/video_viewModel.dart';
class VideoPlayerWidget extends ConsumerStatefulWidget {
  final String videoUrl;
  const VideoPlayerWidget({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends ConsumerState<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  late VideoPlayerController _nextController;
  bool isNextVideoPreloaded = false;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer(widget.videoUrl);
  }

  void _initializeVideoPlayer(String url) async {
    _controller = VideoPlayerController.networkUrl( Uri.parse(url),
    formatHint: VideoFormat.hls, )
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _preloadNextVideo();
      });
  }

  void _preloadNextVideo() {
    final videoAsync = ref.read(videoListProvider); // Get the video list AsyncValue

    videoAsync.when(
      data: (videos) {
        if (videos.isNotEmpty) {
          final nextIndex = (videos.indexWhere((video) => video.url == widget.videoUrl) + 1) % videos.length;
          _nextController = VideoPlayerController.network(videos[nextIndex].url)
            ..initialize().then((_) {
              setState(() {});
              _nextController.setLooping(true);
              isNextVideoPreloaded = true;
            });
        }
      },
      loading: () => null, // Handle loading state if needed
      error: (err, stackTrace) {
        print('Error loading video list: $err');
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    if (_nextController != null) {
      _nextController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final videoState = ref.watch(videoPlaybackProvider);
    final videoNotifier = ref.read(videoPlaybackProvider.notifier);

    return Stack(
      alignment: Alignment.center,
      children: [
        GestureDetector(
          onTap: () {
            videoNotifier.togglePlayPause();
            videoState.isPlaying ? _controller.pause() : _controller.play();
          },
          child: _controller.value.isInitialized
              ?
               AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : Center(child: CircularProgressIndicator()),
        ),
        if (!videoState.isPlaying)
          Icon(
            Icons.play_arrow,
            size: 80,
            color: Colors.white.withOpacity(0.7),
          ),
      ],
    );
  }
}
