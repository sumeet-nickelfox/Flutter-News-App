import 'package:flutter/material.dart';
import 'package:flutter_news_app/models/news_api_response.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NewsArticleScreen extends StatelessWidget {
  const NewsArticleScreen(this.articlesData, {Key? key}) : super(key: key);

  static const routeName = '/news_article';

  final Articles? articlesData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(articlesData?.source?.name ?? ""),
        actions: [
          IconButton(
              onPressed: () {
                Fluttertoast.showToast(
                    msg: "This feature is not yet implemented",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.redAccent,
                    textColor: Colors.white,
                    fontSize: 14.0);
              },
              icon: const Icon(Icons.bookmark)),
          IconButton(
              onPressed: () {
                Share.share(articlesData?.url ?? "",
                    subject: articlesData?.title);
              },
              icon: const Icon(Icons.ios_share))
        ],
      ),
      body: WebView(
        initialUrl: articlesData?.url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
