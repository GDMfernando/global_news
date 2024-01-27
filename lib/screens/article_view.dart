import 'package:flutter/material.dart';
import 'package:global_news/utils/main_body.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:share_plus/share_plus.dart';

class ArticleView extends StatefulWidget {
  String blogUrl;

  ArticleView({required this.blogUrl});

  @override
  State<ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  bool isPageLoaded = false;

  @override
  Widget build(BuildContext context) {
    return MainBody(
      appBarColor: Colors.black,
      title: 'GlobalNews',
      body: WebView(
        initialUrl: widget.blogUrl,
        javascriptMode: JavascriptMode.unrestricted,
        onPageFinished: (String url) {
          setState(() {
            isPageLoaded = true;
          });
        },
      ),
      floatingActionButton: isPageLoaded
          ? FloatingActionButton(
              onPressed: () {
                _shareArticle(widget.blogUrl);
              },
        backgroundColor: Color.fromARGB(186, 15, 15, 15),
              tooltip: 'Share',
              child: Icon(Icons.share,
              color: Colors.yellow.shade800,), // Set to transparent
              // Remove the shadow
            )
          : null,
    );
  }

  void _shareArticle(String url) {
    try {
      Share.share(url, subject: 'Check out this article!');
    } catch (e) {
      print('Error sharing: $e');
    }
  }
}
