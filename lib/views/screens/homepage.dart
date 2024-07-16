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
        title: Text('Home Page'),
        bottom: TabBar(
          controller: tabController,
          tabs: [
            Tab(
              text: "Carousel",
            ),
            Tab(
              text: "Audio",
            ),
            Tab(
              text: "Video",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          CarouselComponent(),
          AudioPlayerScreen(),
          VideoComponent(),
        ],
      ),
      // floatingActionButton: Row(
      //   mainAxisAlignment: MainAxisAlignment.end,
      //   children: [
      //     FloatingActionButton(
      //       onPressed: () {
      //         if (tabController!.index > 0) {
      //           tabController!.animateTo(tabController!.index - 1);
      //         }
      //       },
      //       child: Icon(Icons.arrow_back_ios),
      //     ),
      //     SizedBox(
      //       width: 20,
      //     ),
      //     FloatingActionButton(
      //       onPressed: () {
      //         if (tabController!.index < 2) {
      //           tabController!.animateTo(tabController!.index + 1);
      //         }
      //       },
      //       child: Icon(Icons.arrow_forward_ios),
      //     )
      //   ],
      // ),
      // Container(
      //   height: 60,
      //   color: Colors.white,
      //   child: Column(
      //     children: [
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //         children: [
      //           IconButton(
      //             icon: Icon(
      //               Icons.home,
      //               size: 30,
      //             ),
      //             onPressed: () async {},
      //           ),
      //           IconButton(
      //             icon: Icon(
      //               Icons.bookmark_border,
      //               size: 30,
      //             ),
      //             onPressed: () async {},
      //           ),
      //           IconButton(
      //             icon: Icon(
      //               Icons.arrow_back_ios,
      //               size: 30,
      //             ),
      //             onPressed: () async {},
      //           ),
      //           IconButton(
      //             icon: Icon(
      //               Icons.refresh,
      //               size: 30,
      //             ),
      //             onPressed: () async {},
      //           ),
      //           IconButton(
      //             icon: Icon(
      //               Icons.arrow_forward_ios,
      //               size: 30,
      //             ),
      //             onPressed: () async {},
      //           ),
      //         ],
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
