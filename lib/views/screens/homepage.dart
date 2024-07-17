import 'package:flutter/material.dart';
import 'package:media_player_app/views/Componants/audio_componants.dart';
import 'package:media_player_app/views/Componants/carousel_componant.dart';
import 'package:media_player_app/views/Componants/video_componants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home Page',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        bottom: TabBar(
          controller: tabController,
          indicatorColor: Colors.amber,
          labelColor: Colors.amber,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(
              text: "Carousel",
              icon: Icon(Icons.image),
            ),
            Tab(
              text: "Audio",
              icon: Icon(Icons.audiotrack),
            ),
            Tab(
              text: "Video",
              icon: Icon(Icons.video_library),
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.deepPurple.shade50,
        child: TabBarView(
          controller: tabController,
          children: [
            CarouselComponent(),
            AudioPlayerScreen(),
            VideoComponent(),
          ],
        ),
      ),
    );
  }
}
