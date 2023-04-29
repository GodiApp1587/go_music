import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ListYoutube extends StatefulWidget {
  final String query;

  ListYoutube({required this.query});

  @override
  _ListYoutubeState createState() => _ListYoutubeState();
}

class _ListYoutubeState extends State<ListYoutube> {
  late Future<List<Video>> _futureVideos;

  @override
  void initState() {
    super.initState();
    _futureVideos = _fetchVideos();
  }

  Future<List<Video>> _fetchVideos() async {
    final url = Uri.parse(
        'https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=10&q=${widget.query}&key={API_KEY}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final videosJson = json['items'] as List<dynamic>;
      final videos = videosJson.map((video) => Video.fromJson(video)).toList();
      return videos;
    } else {
      throw Exception('Failed to load videos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _futureVideos,
      builder: (BuildContext context, AsyncSnapshot<List<Video>> snapshot) {
        if (snapshot.hasData) {
          final videos = snapshot.data!;

          return ListView.builder(
            itemCount: videos.length,
            itemBuilder: (BuildContext context, int index) {
              final video = videos[index];
              final controller = YoutubePlayerController(
                initialVideoId: video.id,
                flags: YoutubePlayerFlags(
                  autoPlay: false,
                ),
              );

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    YoutubePlayer(
                      controller: controller,
                      showVideoProgressIndicator: true,
                    ),
                    SizedBox(height: 8),
                    Text(
                      video.title,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      video.channelTitle,
                      style: TextStyle(fontSize: 16),
                    ),
                    Divider(),
                  ],
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class Video {
  final String id;
  final String title;
  final String channelTitle;

  Video({required this.id, required this.title, required this.channelTitle});

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id']['videoId'],
      title: json['snippet']['title'],
      channelTitle: json['snippet']['channelTitle'],
    );
  }
}
