import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_streaming_app/views/video_screen.dart';
// import 'package:wakelock/wakelock.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
//   @override
// void initState() {
//   super.initState();
//   Wakelock.enable(); // Keeps the device screen on
// }

// @override
// void dispose() {
//   Wakelock.disable(); // Disables wakelock when the widget is removed
//   super.dispose();
// }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Streaming App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: VideoFeedScreen() ,
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';

// void main() {
//  WidgetsFlutterBinding.ensureInitialized(); // Ensure the Flutter engine is initialized
//  runApp(MyApp());
// }

// // Main App widget
// class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      home: VideoApp(),
//    );
//  }
// }

// // Stateful widget to manage video playback
// class VideoApp extends StatefulWidget {
//  @override
//  _VideoAppState createState() => _VideoAppState();
// }

// class _VideoAppState extends State<VideoApp> {
//  late VideoPlayerController _controller; // Late initialization of video controller
//  late Future<void> _initializeVideoPlayerFuture; // Future for video initialization
//  double _playbackSpeed = 1.0; // Variable to store the playback speed

//  @override
//  void initState() {
//    super.initState();
//    // Initialize the video controller with a network video
//    _controller = VideoPlayerController.networkUrl(
//      Uri.parse('https://res.cloudinary.com/demo/video/upload/samples/dance-2.mp4'),
//    );

//    // Store the initialization Future
//    _initializeVideoPlayerFuture = _controller.initialize().then((_) {
//      setState(() {}); // Update UI once the video is initialized
//    });
//  }

//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: const Text('Video Player'),
//      ),
//      body: Column(
//        children: [
//          // Center the video player
//          Center(
//            child: FutureBuilder(
//              future: _initializeVideoPlayerFuture,
//              builder: (context, snapshot) {
//                if (snapshot.connectionState == ConnectionState.done) {
//                  return AspectRatio(
//                    aspectRatio: _controller.value.aspectRatio, // Set aspect ratio
//                    child: VideoPlayer(_controller), // Show the video player
//                  );
//                } else {
//                  // Show loading indicator while the video is initializing
//                  return const Center(child: CircularProgressIndicator());
//                }
//              },
//            ),
//          ),
//          const SizedBox(height: 20), // Space between video and buttons
//          Row(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: [
//              // Play/Pause button
//              ElevatedButton(
//                onPressed: () {
//                  setState(() {
//                    if (_controller.value.isPlaying) {
//                      _controller.pause(); // Pause the video if it's playing
//                    } else {
//                      _controller.play(); // Play the video if it's paused
//                    }
//                  });
//                },
//                // Update button text based on the playing state
//                child: Text(_controller.value.isPlaying ? 'Pause' : 'Play'),
//              ),
//              const SizedBox(width: 10),
//              ElevatedButton(
//                onPressed: () {
//                  setState(() {
//                    _controller.seekTo(Duration.zero); // Stop the video (reset position)
//                    _controller.pause(); // Pause after resetting to the beginning
//                  });
//                },
//                child: const Text('Stop'),
//              ),
//            ],
//          ),
//          const SizedBox(height: 20), // Space between buttons and dropdown

//          // Dropdown to select the playback speed
//          Row(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: [
//              const Text('Playback Speed: '),
//              DropdownButton<double>(
//                value: _playbackSpeed,
//                items: [
//                  const DropdownMenuItem(value: 0.5, child: Text('0.5x')),
//                  const DropdownMenuItem(value: 1.0, child: Text('1x')),
//                  const DropdownMenuItem(value: 1.5, child: Text('1.5x')),
//                  const DropdownMenuItem(value: 2.0, child: Text('2x')),
//                ],
//                onChanged: (value) {
//                  setState(() {
//                    _playbackSpeed = value!;
//                    _controller.setPlaybackSpeed(_playbackSpeed); // Set the playback speed
//                  });
//                },
//              ),
//            ],
//          ),
//        ],
//      ),
//    );
//  }

//  @override
//  void dispose() {
//    _controller.dispose(); // Dispose of the controller to free resources
//    super.dispose();
//  }
// }