import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_streaming_app/views/video_screen.dart';
import 'package:wakelock/wakelock.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
void initState() {
  super.initState();
  Wakelock.enable(); // Keeps the device screen on
}

@override
void dispose() {
  Wakelock.disable(); // Disables wakelock when the widget is removed
  super.dispose();
}

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
// import 'package:chewie/chewie.dart';

// import 'models/connectivity_status.dart';
// import 'widgets/bottomNavigationBar.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: VideoFeedScreen(),
//     );
//   }
// }

// class VideoFeedScreen extends StatefulWidget {
//   @override
//   _VideoFeedScreenState createState() => _VideoFeedScreenState();
// }

// class _VideoFeedScreenState extends State<VideoFeedScreen> {
//   final PageController _pageController = PageController();
//   final List<String> videoIds = [
//     "eFDFooCflDdkcFcYxeKDSXeyW00FA00nXeOoMJeakvVSA",
//     "w9qAyPlIaEAaeSuoB36r22xutGF800mXxZ00skcDKsjFc",
//     "g5CwrZaaTWYdjb2peU818fzGkSvASW00tHnziQAQJq5I",
//     "WrEk1kQpRcqAeTGCnrU00nJOUekJesdIL43NrYz01RYc",
//     "zNvlO3QKLbe5Yu0101yQO8SRUDeycIL01cLOB02dhAvjhho",
//     "TU4tu02tS7702jWUDVk5275JZvlNgv5WmyT6kLcV6awDw",
//     "WVy89Zrbw15xAy8nFAGRljwAGGZq36BwNZSckOz1HU4"
//   ];

//   final List<VideoPlayerController?> _videoControllers = [];
//   final List<ChewieController?> _chewieControllers = [];
//   int _currentIndex = 0;

//   @override
//   void initState() {
//     super.initState();
//     _initializeControllers();
//     _monitorNetwork();
//   }
// void _monitorNetwork() {
//     Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> results) {
//       if (results.contains(ConnectivityResult.none)) {
//        OverlayEntry(
//     builder: (context) => Positioned(
//       top: MediaQuery.of(context).padding.top + 10, // Position below status bar
//       left: 20,
//       right: 20,
//       child: Material(
//         color: Colors.transparent,
//         child: Container(
//           padding: EdgeInsets.all(12),
//           decoration: BoxDecoration(
//             color: Colors.red,
//             borderRadius: BorderRadius.circular(8),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black26,
//                 blurRadius: 4,
//                 offset: Offset(0, 2),
//               ),
//             ],
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(Icons.wifi_off, color: Colors.white),
//               SizedBox(width: 8),
//               Text(
//                 "No internet",
//                 style: TextStyle(color: Colors.white),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ),
//   );
//       } else {
//         ConnectivityStatus.online;
//       }
//     });
//   }
//   void _initializeControllers() {
// print("initializing current video***************************");

//     for (int i = 0; i < videoIds.length; i++) {
//       _videoControllers.add(null);
//       _chewieControllers.add(null);
//     }
//     _loadVideo(0); // Load first video
//     _preloadVideo(1); // Preload second video
//   }

//   void _disposeController(int index) {
//   if (index < 0 || index >= videoIds.length) return;

//   _chewieControllers[index]?.pause();
//   _chewieControllers[index]?.dispose();
//   _chewieControllers[index] = null;

//   _videoControllers[index]?.dispose();
//   _videoControllers[index] = null;
// }

// void _loadVideo(int index) async {
//   if (index < 0 || index >= videoIds.length) return;
// print("loading current video $index*************************");
//   if (_videoControllers[index] != null && 
//       _chewieControllers[index] != null && 
//       _videoControllers[index]!.value.isInitialized) {
//     _chewieControllers[index]!.play();
//     return;
//   }

//   final url = "https://stream.mux.com/${videoIds[index]}.m3u8";
//   final controller = VideoPlayerController.network(url);

//   await controller.initialize(); // Ensure it's initialized before proceeding

//   if (!mounted) return; // Check if the widget is still mounted

//   final chewieController = ChewieController(
//     videoPlayerController: controller,
//     autoPlay: true,
//     looping: true,
//   );

//   setState(() {
//     _videoControllers[index] = controller;
//     _chewieControllers[index] = chewieController;
//   });
// }


// void _preloadVideo(int index) {
//   if (index < 0 || index >= videoIds.length) return;
//   if (_videoControllers[index] != null) return;
// print("preloading current video $index****************");

//   final url = "https://stream.mux.com/${videoIds[index]}.m3u8";
//   final controller = VideoPlayerController.network(url);

//   controller.initialize().then((_) {
//     setState(() {
//       _videoControllers[index] = controller;
//     });
//   });
// }

// void _onPageChanged(int index) {
//   if (index < 0 || index >= videoIds.length) return;

//   _chewieControllers[_currentIndex]?.pause();
//   setState(() {
//     _currentIndex = index;
//   });

//   _loadVideo(index);
//   _preloadVideo(index + 1);
//   if (index > 0) _preloadVideo(index - 1);
// }

//   @override
//   void dispose() {
//     for (var controller in _videoControllers) {
//       controller?.dispose();
//     }
//     for (var chewieController in _chewieControllers) {
//       chewieController?.dispose();
//     }
//     _pageController.dispose();
//     // _disposeController(_currentIndex);
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//        bottomNavigationBar: CustomBottomBar(),
//       backgroundColor: Colors.black,
//       body: PageView.builder(
//         controller: _pageController,
//         scrollDirection: Axis.vertical,
//         itemCount: videoIds.length,
//         onPageChanged: _onPageChanged,
//         itemBuilder: (context, index) {
//           if (_chewieControllers[index] == null) {
//             return Center(child: CircularProgressIndicator());
//           }
//           return Chewie(controller: _chewieControllers[index]!);
//         },
//       ),
//     );
//   }
// }
