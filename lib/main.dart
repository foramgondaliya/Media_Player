import 'package:flutter/material.dart';
import 'package:media_player_app/Modal/audio.dart';
import 'package:media_player_app/views/screens/audioFullScreen.dart';
import 'package:media_player_app/views/screens/homepage.dart';

import 'views/screens/videoFullScreen.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => HomePage(),
        'detailPage': (context) => FullScreenAudioPlayer(),
        'videoDetailPage': (context) => VideoDetailPage(),
      },
    ),
  );
}
