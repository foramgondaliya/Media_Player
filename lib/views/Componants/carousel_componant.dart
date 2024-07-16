import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:media_player_app/utils/carouselData.dart';

class CarouselComponent extends StatefulWidget {
  const CarouselComponent({Key? key}) : super(key: key);

  @override
  State<CarouselComponent> createState() => _CarouselComponentState();
}

class _CarouselComponentState extends State<CarouselComponent> {
  int sliderIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Text(
                    "Popular albums",
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            CarouselSlider(
              options: CarouselOptions(
                height: 250,
                enlargeCenterPage: true,
                autoPlay: true,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                viewportFraction: 0.6,
                initialPage: sliderIndex,
                onPageChanged: (val, _) {
                  setState(() {
                    sliderIndex = val;
                  });
                },
              ),
              items: topSongs.map((imageUrl) {
                return Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width / 1.6,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                );
              }).toList(),
            ),
            //SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: topSongs.map((e) {
                int index = topSongs.indexOf(e);
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: CircleAvatar(
                    radius: 5,
                    backgroundColor: (index == sliderIndex)
                        ? Colors.purple.shade800
                        : Colors.grey,
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Text(
                    "Top Hits",
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            CarouselSlider(
              options: CarouselOptions(
                height: 150,
                //enlargeCenterPage: true,
                //autoPlay: true,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                viewportFraction: 0.45,
                initialPage: sliderIndex,
                onPageChanged: (val, _) {
                  setState(() {
                    sliderIndex = val;
                  });
                },
              ),
              items: topHits.map((imageUrl) {
                return Stack(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width / 1.9,
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: IconButton(
                          icon: Icon(Icons.play_circle_filled,
                              size: 50, color: Colors.white),
                          onPressed: () {
                            // Handle play button press here
                          },
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Text(
                    "Top artists",
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: topArtists.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(topArtists[index]),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Text(
                    "Best of artists",
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            CarouselSlider(
              options: CarouselOptions(
                height: 150,
                //enlargeCenterPage: true,
                //autoPlay: true,
                autoPlayCurve: Curves.fastOutSlowIn,
                //enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                viewportFraction: 0.40,
                initialPage: sliderIndex,
                onPageChanged: (val, _) {
                  setState(() {
                    sliderIndex = val;
                  });
                },
              ),
              items: best.map((imageUrl) {
                return Stack(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width / 1.9,
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: IconButton(
                          icon: Icon(Icons.play_circle_filled,
                              size: 50, color: Colors.white),
                          onPressed: () {
                            // Handle play button press here
                          },
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
            SizedBox(height: 10),
          ],
        ),
      ],
    );
  }
}
