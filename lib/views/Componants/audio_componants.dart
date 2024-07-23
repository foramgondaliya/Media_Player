import 'package:flutter/material.dart';
import 'package:media_player_app/provider/player_Provider.dart';
import 'package:media_player_app/utils/audioData.dart';
import 'package:provider/provider.dart';

class AudioPlayerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerProvider>(
      builder: (context, playerProvider, child) {
        return Scaffold(
          body: Container(
            color: Colors.deepPurple.shade50,
            child: Column(
              children: [
                SizedBox(height: 10),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: popularItems.map((e) {
                      return GestureDetector(
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
                                playerProvider.togglePlayPause(e['audioPath']);
                              },
                              icon: Icon(
                                playerProvider.isPlaying &&
                                        playerProvider.currentAudioPath ==
                                            e['audioPath']
                                    ? Icons.pause
                                    : Icons.play_arrow,
                              ),
                              color: Colors.deepPurple,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
