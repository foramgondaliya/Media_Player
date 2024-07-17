import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:media_player_app/Modal/audio.dart';
import 'package:media_player_app/utils/audioData.dart';

class FullScreenAudioPlayer extends StatefulWidget {
  final AudioItem? audioItem;

  FullScreenAudioPlayer({this.audioItem});

  @override
  _FullScreenAudioPlayerState createState() => _FullScreenAudioPlayerState();
}

class _FullScreenAudioPlayerState extends State<FullScreenAudioPlayer> {
  final AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();

  @override
  void initState() {
    super.initState();
    if (widget.audioItem != null) {
      assetsAudioPlayer.open(
        Audio(widget.audioItem!.audioPath),
        autoStart: true,
        showNotification: true,
      );
    }
  }

  @override
  void dispose() {
    assetsAudioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String title = widget.audioItem?.title ?? 'No Title';
    final String artist = widget.audioItem?.artist ?? 'No Artist';
    final String imagePath =
        widget.audioItem?.imagePath ?? 'assets/maxresdefault.jpg';
    final String audioPath = widget.audioItem?.audioPath ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: 300,
              height: 300,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              "${data['title']}",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              "${data['artist']}",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.skip_previous),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.play_arrow),
                  onPressed: () {
                    assetsAudioPlayer.play();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.pause),
                  onPressed: () {
                    assetsAudioPlayer.pause();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.skip_next),
                  onPressed: () {
                    assetsAudioPlayer.next();
                  },
                ),
              ],
            ),
            StreamBuilder(
              stream: assetsAudioPlayer.currentPosition,
              builder: (context, snapshot) {
                Duration? data = snapshot.data as Duration?;
                String currentPosition = data.toString().split('.')[0];
                return StreamBuilder(
                  stream: assetsAudioPlayer.current,
                  builder: (context, ss) {
                    Playing? playing = ss.data as Playing?;
                    Duration? totalDuration = playing?.audio.duration;
                    String totalDurationString =
                        totalDuration.toString().split('.')[0];
                    return Column(
                      children: [
                        Slider(
                          min: 0,
                          max: totalDuration == null
                              ? 0
                              : totalDuration.inSeconds.toDouble(),
                          value: data == null ? 0 : data.inSeconds.toDouble(),
                          onChanged: (val) {
                            assetsAudioPlayer
                                .seek(Duration(seconds: val.toInt()));
                          },
                        ),
                        Text("$currentPosition / $totalDurationString"),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
