import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_streaming_app/widgets/bottomNavigationBar.dart';
import '../viewModel/video_viewModel.dart';
import '../widgets/videoPlayer.dart';

class VideoScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final videoAsync = ref.watch(videoListProvider);

    return Scaffold(
      backgroundColor: Colors.black,
       extendBody: true,
      bottomNavigationBar: CustomBottomBar(),
      body: SafeArea(
        // top: false,
        bottom: false,
        child: videoAsync.when(
          data: (videos) => PageView.builder(
            
            scrollDirection: Axis.vertical,
            itemCount: videos.length,
            itemBuilder: (context, index) => VideoPlayerWidget(videoUrl: videos[index].url),
          ),
          loading: () => Center(child: CircularProgressIndicator()),
          error: (err, _) => Center(child: Text('Error: $err')),
        ),
      ),
    );
  }
}
