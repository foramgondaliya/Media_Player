import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:media_player_app/Modal/audio.dart';
import 'package:media_player_app/utils/alllData.dart';

class AudioPlayerScreen extends StatefulWidget {
  @override
  _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  final AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();
  bool isPlaying = false;
  String? currentAudioPath;

  @override
  void initState() {
    super.initState();
    assetsAudioPlayer.playlistAudioFinished.listen((event) {
      setState(() {
        isPlaying = false;
        currentAudioPath = null;
      });
    });
  }

  @override
  void dispose() {
    assetsAudioPlayer.dispose();
    super.dispose();
  }

  void togglePlayPause(String audioPath) async {
    if (isPlaying && currentAudioPath == audioPath) {
      await assetsAudioPlayer.pause();
      setState(() {
        isPlaying = false;
      });
    } else {
      await assetsAudioPlayer.open(
        Audio(audioPath),
        autoStart: true,
        showNotification: true,
      );
      setState(() {
        isPlaying = true;
        currentAudioPath = audioPath;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 10),
          Expanded(
            child: ListView(
              children: popularItems
                  .map(
                    (e) => GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          'detailPage',
                          arguments: e,
                        );
                      },
                      child: Card(
                        elevation: 3,
                        color: Colors.grey.shade400,
                        margin: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        child: ListTile(
                          title: Text(
                            "${e['title']}",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          subtitle: Text(
                            "${e['artist']}",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              togglePlayPause(e['audioPath']);
                            },
                            icon: Icon(
                              isPlaying && currentAudioPath == e['audioPath']
                                  ? Icons.pause
                                  : Icons.play_arrow,
                            ),
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
