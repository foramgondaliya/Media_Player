import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoDetailPage extends StatefulWidget {
  @override
  _VideoDetailPageState createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  late VideoPlayerController controller;
  late ChewieController chewieController;

  @override
  void initState() {
    super.initState();
    loadVideo();
  }

  Future<void> loadVideo() async {
    controller = VideoPlayerController.asset("assets/videos/sample.mp4");
    await controller.initialize();
    chewieController = ChewieController(
      videoPlayerController: controller,
      autoPlay: false,
    );

    setState(() {});
  }

  @override
  void dispose() {
    controller.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    return Scaffold(
      appBar: AppBar(
        title: Text(data?['title']),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 100),
              child: Container(
                height: 280,
                width: double.infinity,
                //color: Colors.blue,
                child: controller.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: 8 / 6,
                        child: Chewie(
                          controller: chewieController,
                        ),
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
