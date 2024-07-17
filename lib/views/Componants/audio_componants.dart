import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:media_player_app/Modal/audio.dart';
import 'package:media_player_app/utils/audioData.dart';

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
      // appBar: AppBar(
      //   title: Text(
      //     "Audio Player",
      //     style: TextStyle(
      //       color: Colors.white,
      //       fontWeight: FontWeight.bold,
      //       fontSize: 24,
      //     ),
      //   ),
      //   //backgroundColor: Colors.deepPurple,
      // ),
      body: Container(
        color: Colors.deepPurple.shade50,
        child: Column(
          children: [
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
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
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          color: Colors.white,
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 16,
                            ),
                            title: Text(
                              "${e['title']}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple,
                              ),
                            ),
                            subtitle: Text(
                              "${e['artist']}",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.deepPurple.shade300,
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
                              color: Colors.deepPurple,
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
      ),
    );
  }
}
