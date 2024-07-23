import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:media_player_app/utils/videoData.dart'; // Ensure this import is correct

class VideoComponent extends StatefulWidget {
  const VideoComponent({super.key});

  @override
  State<VideoComponent> createState() => _VideoComponentState();
}

class _VideoComponentState extends State<VideoComponent> {
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    if (VideoItems.isNotEmpty) {
      loadVideo(VideoItems[0]['videoPath']);
    }
  }

  Future<void> loadVideo(String videoPath) async {
    videoPlayerController = VideoPlayerController.asset(videoPath);
    await videoPlayerController!.initialize();

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController!,
      autoPlay: false,
    );

    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    videoPlayerController?.dispose();
    chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          isLoading
              ? Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 20, right: 16, left: 16),
                  child: Column(
                    children: VideoItems.map(
                      (e) => Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              'videoDetailPage',
                              arguments: e,
                            );
                          },
                          child: Card(
                            elevation: 3,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    height: 120,
                                    color: Colors.white,
                                    child: AspectRatio(
                                      aspectRatio: videoPlayerController
                                              ?.value.aspectRatio ??
                                          16 / 9,
                                      child: videoPlayerController != null
                                          ? VideoPlayer(videoPlayerController!)
                                          : Center(child: Text('No video')),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 150,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "${e['title']},",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "${e['artist']},",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                "${e['description']}",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ).toList(),
                  ),
                ),
        ],
      ),
    );
  }
}
