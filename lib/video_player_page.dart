import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerPage extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerPage({required this.videoUrl, Key? key}) : super(key: key);

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();

    _videoPlayerController = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
      });

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: false,
      allowFullScreen: true,
      allowPlaybackSpeedChanging: true,
      allowMuting: true,
      additionalOptions: (context) {
        return <OptionItem>[
          OptionItem(
            onTap: (context) {
              _videoPlayerController.seekTo(
                _videoPlayerController.value.position - const Duration(seconds: 10),
              );
            },
            iconData: Icons.replay_10,
            title: 'رجوع 10 ثواني',
          ),
          OptionItem(
            onTap: (context) {
              _videoPlayerController.seekTo(
                _videoPlayerController.value.position + const Duration(seconds: 10),
              );
            },
            iconData: Icons.forward_10,
            title: 'تقديم 10 ثواني',
          ),
        ];
      },
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("مشغل الفيديو"),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: _chewieController != null &&
            _videoPlayerController.value.isInitialized
            ? Chewie(controller: _chewieController!)
            : const CircularProgressIndicator(),
      ),
    );
  }
}
