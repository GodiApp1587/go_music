import 'dart:async';import 'dart:async';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideosScreen extends StatefulWidget {
  final String videoUrl;

  VideosScreen({required this.videoUrl});

  @override
  _VideosScreenState createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen> with TickerProviderStateMixin {
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
          height: 750,
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
