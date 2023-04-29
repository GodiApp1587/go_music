import 'package:flutter/material.dart';

class VideoScreenYoutube extends StatefulWidget {
  @override
  _VideoScreenYoutubeState createState() => _VideoScreenYoutubeState();
}

class _VideoScreenYoutubeState extends State<VideoScreenYoutube> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.blue,
              child: Center(
                child: Text('Pantalla 1'),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.green,
              child: Center(
                child: Text('Pantalla 2'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
