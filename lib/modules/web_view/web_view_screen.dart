import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore: must_be_immutable
class WebViewScreen extends StatelessWidget {
  final String url;
  late var webViewController = WebViewController()
    ..loadRequest(
      Uri.parse(url),
    );

  WebViewScreen({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: WebViewWidget(
        controller: webViewController,
      ),
    );
  }
}
