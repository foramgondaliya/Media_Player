import 'package:flutter/material.dart';
import 'package:media_player_app/Modal/audio.dart';
import 'package:media_player_app/provider/player_Provider.dart';
import 'package:media_player_app/views/screens/audioFullScreen.dart';
import 'package:media_player_app/views/screens/homepage.dart';
import 'package:provider/provider.dart';

import 'views/screens/videoFullScreen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PlayerProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => HomePage(),
          'detailPage': (context) => FullScreenAudioPlayer(),
          'videoDetailPage': (context) => VideoDetailPage(),
        },
      ),
    ),
  );
}
