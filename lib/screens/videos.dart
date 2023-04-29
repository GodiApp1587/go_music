import 'dart:async';import 'dart:async';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends StatefulWidget {
  final String videoUrl;

  VideoScreen({required this.videoUrl});

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> with TickerProviderStateMixin {
  late YoutubePlayerController _controller;

  List<Color> colorList = [
    Color(0xff171B70),
    Color(0xff171B70),
    Color(0xff171B70),
    Color(0xff410D75),
    Color(0xff410D75),
  ];

  List<Alignment> alignmentList = [Alignment.topCenter, Alignment.bottomCenter];
  int index = 0;
  Color bottomColor = Color(0xff092646);
  Color topColor = Color(0xff410D75);
  Alignment begin = Alignment.bottomCenter;
  Alignment end = Alignment.topCenter;

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.videoUrl)!,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
    _animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat();
    _animationController.addListener(() {
      setState(() {
        index = index + 1;
        begin = alignmentList[index % alignmentList.length];
        end = alignmentList[(index + 1) % alignmentList.length];
        bottomColor = colorList[index % colorList.length];
        topColor = colorList[(index + 1) % colorList.length];
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          height: 630,
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, _) {
                  return Center(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: begin,
                          end: end,
                          colors: [bottomColor, topColor],
                        ),
                      ),
                      child: Center(
                        child: Card(
                          elevation: 9,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                              border: Border.all(
                                color: Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: Container(
                              height: 550,
                              width: 340,
                              child: Column(
                                children: [
                                Expanded(
                                flex: 2,
                                child: YoutubePlayer(
                                  controller: _controller,
                                  showVideoProgressIndicator: true,
                                ),
                              ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      child: Column(
                                        children: [
                                          SizedBox(height: 10),
                                          Text(
                                            'Lista de reproducción',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          Expanded(
                                            child: ListView.builder(
                                              itemBuilder: (context, index) {
                                                // Aquí puedes construir cada elemento de la lista de videos
                                                return ListTile(
                                                  title: Text('Video ${index + 1}'),
                                                  onTap: () {
                                                    _controller.load(YoutubePlayer.convertUrlToId("https://www.youtube.com/watch?v=efgh5678")!);
                                                  },
                                                );
                                              },
                                              itemCount: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ));
  }
}
