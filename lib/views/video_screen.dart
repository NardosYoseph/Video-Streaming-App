import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:video_streaming_app/widgets/custom_snackbar.dart';

import '../viewModel/video_viewModel.dart';
import '../widgets/bottomNavigationBar.dart';

class VideoFeedScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final videoFeed = ref.watch(videoFeedProvider);
    final connectivityStatus = ref.watch(connectivityProvider);
if (!connectivityStatus.isOnline) {
    // Show the snackbar when there is no internet
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showInternetSnackbar(context, "No Internet Connection");
    });
  }
    return Scaffold(
      bottomNavigationBar: CustomBottomBar(),
      backgroundColor: Colors.black,
      body: PageView.builder(
              scrollDirection: Axis.vertical,
              itemCount: videoFeed.length,
              onPageChanged: (index) => ref.read(videoFeedProvider.notifier).onPageChanged(index),
              itemBuilder: (context, index) {
                final chewieController = videoFeed[index].chewieController;

                return Stack(
                  children: [
                    // Video player
                    if (chewieController != null)
                      Chewie(controller: chewieController),

                    // Controls overlay (like, save, share buttons)
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 250,),

                            IconButton(
                              icon: Icon(Icons.favorite, color: Colors.white,size: 30,),
                              onPressed: () {
                                // Handle like action
                                _handleLike(index);
                              },
                            ),
                            SizedBox(height: 20),
                            IconButton(
                              icon: Icon(Icons.save_alt, color: Colors.white,size: 30,),
                              onPressed: () {
                                // Handle save action
                                _handleSave(index);
                              },
                            ),
                            SizedBox(height: 20),
                            IconButton(
                              icon: Icon(Icons.share, color: Colors.white,size: 30,),
                              onPressed: () {
                                // Handle share action
                                _handleShare(index);
                              },
                            ),

                          ],
                        ),
                      ),
                    ),

                    // Show loading indicator when video is not loaded
                    if (chewieController == null || !chewieController.videoPlayerController.value.isInitialized)
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                  ],
                );
              },
            )
    );
  }

  // Handle Like action
  void _handleLike(int index) {
    print("Liked video at index: $index");
    // Implement like functionality here
  }

  // Handle Save action
  void _handleSave(int index) {
    print("Saved video at index: $index");
    // Implement save functionality here
  }

  // Handle Share action
  void _handleShare(int index) {
    print("Shared video at index: $index");
    // Implement share functionality here
  }
}
