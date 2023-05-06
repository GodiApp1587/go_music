import 'dart:async';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:vibe_music/widgets/Controller_Video.dart';

class VideoScreen extends StatefulWidget {
  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen>
    with TickerProviderStateMixin {
  List<Color> colorList = [
    Color(0xff2c3e50),
    Color(0xff0a0a1e),
    Color(0xff0d1f1b),
    Color(0xff0d171f),
    Color(0xff010409),
    Color(0xff3c3c41),
    Color(0xffbdc3c7),  ];
  List<Alignment> alignmentList = [Alignment.topCenter, Alignment.bottomCenter];
  int index = 0;
  Color bottomColor = Color(0xff030303);
  Color topColor = Color(0xffdbe0ee);
  Alignment begin = Alignment.bottomCenter;
  Alignment end = Alignment.topCenter;

  @override
  void initState() {
    super.initState();
    Timer(
      Duration(microseconds: 0),
          () {
        setState(
              () {
            bottomColor = Color(0xffffffff);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedContainer(
          duration: Duration(seconds: 2),
          onEnd: () {
            setState(
                  () {
                index = index + 1;
                bottomColor = colorList[index % colorList.length];
                topColor = colorList[(index + 1) % colorList.length];
              },
            );
          },
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: begin,
              end: end,
              colors: [bottomColor, topColor],
            ),
          ),
          child: SizedBox.expand(),
        ),

        Column(
          children: [
            SizedBox(height: 115),

            SizedBox(height: 27),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.88,
                height: MediaQuery.of(context).size.height * 0.35,
                decoration: BoxDecoration(
                  color: Colors.black87.withOpacity(0.88),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Center(
                  child: AspectRatio(
                    aspectRatio: 16/9,
                    child: YoutubePlayerWidget(
    videoUrl: 'https://music.youtube.com/watch?v=QD1Ae_7JGUM&list=RDAMVM3jwxZ3EjCs4',
    ),
                  ),
                ),
              ),
            ), SizedBox(height: 45),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    // Lógica para cuando se presiona el icono de impressed
                  },
                  child: Column(
                    children: [
                      Icon(Icons.play_arrow_outlined, size: 30),
                      SizedBox(height: 10),
                      Text('Impressed', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Lógica para cuando se presiona el icono de lista de videos
                  },
                  child: Column(
                    children: [
                      Icon(Icons.video_collection, size: 30),
                      SizedBox(height: 10),
                      Text('Lista de videos', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Lógica para cuando se presiona el icono de reconocer audio
                  },
                  child: Column(
                    children: [
                      Icon(Icons.mic, size: 30),
                      SizedBox(height: 10),
                      Text('Reconocer audio', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 53),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.088,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(0),
                  ),
                ),
                child: CarouselSlider(
                  items: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: AssetImage('assets/images/fondo_des_light.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: AssetImage('assets/images/fondo_des.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: AssetImage('assets/images/fondo_dark.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: AssetImage('assets/images/fondo_dark.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: AssetImage('assets/images/fondo_dark.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                  options: CarouselOptions(
                    height: 100,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: true,
                    autoPlay: true, // Activa el modo auto-play
                    autoPlayInterval: Duration(milliseconds: 5000) // Cambia de página cada 3 segundos
                  ),
                ),
              ),
            ),
          ],
        ),


      ],
    );
  }
}
