import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:video_streaming_app/widgets/bottomNavigationBar.dart';

import '../viewModel/video_viewModel.dart';
import '../widgets/videoPlayer.dart';

class VideoSwipeScreen extends ConsumerStatefulWidget {
  @override
  _VideoSwipeScreenState createState() => _VideoSwipeScreenState();
}

class _VideoSwipeScreenState extends ConsumerState<VideoSwipeScreen> {
  late PageController _pageController;
  List<VlcPlayerController?> _controllers = []; // Use nullable controllers
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
   
    _pageController = PageController();
    ref.read(videoViewModelProvider.notifier).fetchVideos([
      "eFDFooCflDdkcFcYxeKDSXeyW00FA00nXeOoMJeakvVSA",
      "w9qAyPlIaEAaeSuoB36r22xutGF800mXxZ00skcDKsjFc",
      // Add other video IDs here
    ]).then((_) {
      
      _initializeControllers();
    });
  }
void _initializeControllers() {
  print("inside initializer");

  final videoUrls = ref.read(videoViewModelProvider);
  _controllers = [];

  WidgetsBinding.instance.addPostFrameCallback((_) async {
    for (var url in videoUrls) {
      print("inside for");

      try {
        print("inside try");

        // Always use network source for HLS videos
        if (url.endsWith(".m3u8") || url.endsWith(".x-mpegurl")) {
          print("Detected HLS format, using network stream");

          final controller = VlcPlayerController.network(
            url, 
            hwAcc: HwAcc.full, // Enable hardware acceleration
            autoPlay: false,
            options: VlcPlayerOptions(),
          );

          _controllers.add(controller);

          await Future.delayed(Duration(milliseconds: 500)); // Small delay
          print("Waiting for VLC player widget to build...");
          await controller.initialize();  // <-- Only initialize after widget is ready

          print("Controller initialized for HLS");
        } 
      } catch (e, stackTrace) {
        print("Failed to initialize VLC Player: $e");
        print(stackTrace);
        _controllers.add(null);
      }
    }

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  });
}


 void _preloadNextVideo(int currentIndex) async {
  final nextIndex = currentIndex + 1;
  if (nextIndex < _controllers.length && _controllers[nextIndex] == null) {
    final videoUrls = ref.read(videoViewModelProvider);
    try {
      final cachedPath = await ref.read(videoViewModelProvider.notifier).getCachedVideoPath(videoUrls[nextIndex]);
      
      if (!File(cachedPath).existsSync()) {
        print("Preload skipped: File does not exist.");
        return;
      }

      final controller = VlcPlayerController.file(
        File(cachedPath),
        options: VlcPlayerOptions(),
      );

      await Future.delayed(Duration(milliseconds: 300)); // Delay before initializing
      await controller.initialize();
      
      if (mounted) {
        setState(() {
          _controllers[nextIndex] = controller;
        });
      }
    } catch (e) {
      print("Error preloading video: $e");
    }
  }
}

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller?.dispose();
    }
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final videoUrls = ref.watch(videoViewModelProvider);

    // Show a loading indicator if videos are still being fetched
    if (_isLoading || videoUrls.isEmpty) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      bottomNavigationBar: CustomBottomBar(),
      body: PageView.builder(
        controller: _pageController,
        itemCount: videoUrls.length,
        onPageChanged: (index) {
          _preloadNextVideo(index);
        },
        itemBuilder: (context, index) {
          if (index >= _controllers.length || _controllers[index] == null) {
            return Center(child: CircularProgressIndicator());
          }
          return VlcPlayerWidget(videoUrl: videoUrls[index]);
        },
      ),
    );
  }
}