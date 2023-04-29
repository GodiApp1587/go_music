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
          Positioned(
            left: 0,
            right: 0,
            bottom: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.circle, color: Colors.white, size: 12),
                  onPressed: () {
                    _controller.animateToPage(0,
                        duration: Duration(milliseconds: 400),
                        curve: Curves.easeInOut);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.circle, color: Colors.white, size: 12),
                  onPressed: () {
                    _controller.animateToPage(1,
                        duration: Duration(milliseconds: 400),
                        curve: Curves.easeInOut);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.circle, color: Colors.white, size: 12),
                  onPressed: () {
                    _controller.animateToPage(2,
                        duration: Duration(milliseconds: 400),
                        curve: Curves.easeInOut);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
