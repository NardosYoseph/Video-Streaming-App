import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

class VlcPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const VlcPlayerWidget({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _VlcPlayerWidgetState createState() => _VlcPlayerWidgetState();
}

class _VlcPlayerWidgetState extends State<VlcPlayerWidget> {
  late VlcPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();

    _controller = VlcPlayerController.network(
      widget.videoUrl,
      hwAcc: HwAcc.full,
      autoPlay: false,
      options: VlcPlayerOptions(),
    );

    Future.delayed(Duration(milliseconds: 500), () async {
      await _controller.initialize();
      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.stop();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isInitialized
        ? VlcPlayer(
            controller: _controller,
            aspectRatio: 16 / 9,
            placeholder: Center(child: CircularProgressIndicator()),
          )
        : Center(child: CircularProgressIndicator()); // Show loading indicator
  }
}
