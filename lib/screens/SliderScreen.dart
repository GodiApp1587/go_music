import 'package:flutter/material.dart';
import 'package:vibe_music/screens/VideoScreen.dart';

class SliderScreen extends StatefulWidget {
  const SliderScreen({Key? key}) : super(key: key);

  @override
  _SliderScreenState createState() => _SliderScreenState();
}

class _SliderScreenState extends State<SliderScreen> {
  final PageController _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            children: [
              Container(
                color: Colors.red,
                child: SizedBox.expand(
                  child: VideoScreen(),
                ),
              ),
              Container(color: Colors.green,
              child: SizedBox.expand(),),
              Container(color: Colors.blue),
            ],
          ),

        ],
      ),
    );
  }
}
