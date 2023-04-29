import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class MyWebBrowser extends StatefulWidget {
  final String url;

  const MyWebBrowser({Key? key, required this.url}) : super(key: key);

  @override
  _MyWebBrowserState createState() => _MyWebBrowserState();
}

class _MyWebBrowserState extends State<MyWebBrowser> {
  InAppWebViewController? _webViewController;
  bool _isLoading = true;
  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.url),
      ),
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            children: [
              Container(
                child: InAppWebView(
                  initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
                  initialOptions: InAppWebViewGroupOptions(
                    crossPlatform: InAppWebViewOptions(
                      userAgent:
                      'Mozilla/5.0 (Linux; Android 11; SM-G965F) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Mobile Safari/537.36',
                    ),
                  ),
                  onWebViewCreated: (InAppWebViewController controller) {
                    _webViewController = controller;
                  },
                  onLoadStart:
                      (InAppWebViewController controller, Uri? url) {
                    setState(() {
                      _isLoading = true;
                    });
                  },
                  onLoadStop:
                      (InAppWebViewController controller, Uri? url) async {
                    setState(() {
                      _isLoading = false;
                    });
                  },
                ),
              ),
            ],
          ),
          if (_isLoading)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
