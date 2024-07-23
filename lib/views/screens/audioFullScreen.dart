import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:media_player_app/Modal/audio.dart';
import 'package:media_player_app/provider/player_Provider.dart';
import 'package:provider/provider.dart';

class FullScreenAudioPlayer extends StatefulWidget {
  final AudioItem? audioItem;

  FullScreenAudioPlayer({this.audioItem});

  @override
  _FullScreenAudioPlayerState createState() => _FullScreenAudioPlayerState();
}

class _FullScreenAudioPlayerState extends State<FullScreenAudioPlayer> {
  @override
  Widget build(BuildContext context) {
    final data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final playerProvider = Provider.of<PlayerProvider>(context);
    final String title = ("${data['title']}") ?? 'No Title';
    final String artist = ("${data['artist']}") ?? 'No Artist';
    final String imagePath =
        ("${data['imagePath']}") ?? 'assets/maxresdefault.jpg';
    final String audioPath = widget.audioItem?.audioPath ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text("${data['title']}"),
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
              title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              artist,
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
                  icon: Icon(playerProvider.isPlaying &&
                          playerProvider.currentAudioPath == audioPath
                      ? Icons.pause
                      : Icons.play_arrow),
                  onPressed: () {
                    playerProvider.togglePlayPause(audioPath);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.skip_next),
                  onPressed: () {},
                ),
              ],
            ),
            StreamBuilder<Duration>(
              stream: playerProvider.currentPosition,
              builder: (context, positionSnapshot) {
                Duration? currentPosition = positionSnapshot.data;
                return StreamBuilder<Playing?>(
                  stream: playerProvider.current,
                  builder: (context, playingSnapshot) {
                    Playing? playing = playingSnapshot.data;
                    Duration? totalDuration = playing?.audio.duration;
                    return Column(
                      children: [
                        Slider(
                          min: 0,
                          max: totalDuration?.inSeconds.toDouble() ?? 0,
                          value: currentPosition?.inSeconds.toDouble() ?? 0,
                          onChanged: (val) {
                            playerProvider.seek(Duration(seconds: val.toInt()));
                          },
                        ),
                        Text(
                          "${currentPosition?.toString().split('.')[0] ?? '00:00'} / ${totalDuration?.toString().split('.')[0] ?? '00:00'}",
                        ),
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
