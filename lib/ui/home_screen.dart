import 'package:flutter/material.dart';
import 'package:flutter_news_app/data/remote/response/status.dart';
import 'package:flutter_news_app/models/news_api_response.dart';
import 'package:flutter_news_app/res/app_context_extension.dart';
import 'package:flutter_news_app/ui/bottom_nav_bar.dart';
import 'package:flutter_news_app/ui/news_article.dart';
import 'package:flutter_news_app/ui/widget/loading_widget.dart';
import 'package:flutter_news_app/ui/widget/my_error_widget.dart';
import 'package:flutter_news_app/ui/widget/my_text_view.dart';
import 'package:flutter_news_app/viewmodel/headlines_response_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'dart:developer' as developer;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HeadlinesResponseViewModel viewModel = HeadlinesResponseViewModel();

  @override
  void initState() {
    viewModel.fetchHeadlines();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: MyTextView(
                context.resources.strings.homeScreen,
                context.resources.color.colorWhite,
                context.resources.dimension.bigText)),
        backgroundColor: Theme.of(context).primaryColor,
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: const BottomNavBar(index: 0),
      body: ChangeNotifierProvider<HeadlinesResponseViewModel>(
        create: (BuildContext context) => viewModel,
        child: Consumer<HeadlinesResponseViewModel>(
            builder: (context, viewModel, _) {
          switch (viewModel.newsApiResponse.status) {
            case Status.LOADING:
              return const LoadingWidget();
            case Status.ERROR:
              return MyErrorWidget(viewModel.newsApiResponse.message ?? "NA");
            case Status.COMPLETED:
              return _getNewsListView(viewModel.newsApiResponse.data);
            default:
          }
          return Container();
        }),
      ),
    );
  }

  Widget _getNewsListView(NewsApiResponse? newsApiResponse) {
    return ListView.builder(
        itemCount: newsApiResponse?.articles?.length,
        itemBuilder: (context, position) {
          developer.log("logging ${newsApiResponse?.totalResults}",
              name: "getting results");
          return _getNewsListItem(newsApiResponse?.articles?[position]);
        });
  }

  Widget _getNewsListItem(Articles? article) {
    developer.log('Sumeet ${article?.author}');
    ImageProvider itemImage = const AssetImage('assets/images/img_error.png');
    if (article?.urlToImage != null) {
      itemImage = NetworkImage(article?.urlToImage ?? "");
    }
    return Container(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          _sendDataToNewsDetailScreen(context, article);
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                    image: DecorationImage(
                        image: itemImage,
                        onError: (exception, stackTrace) {
                          developer.log('Home Screen Image Loading $exception');
                        },
                        fit: BoxFit.cover)),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: SizedBox(
                  height: 120,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          article?.title ?? "NA",
                          style: Theme.of(context).textTheme.bodyText1,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        article?.source?.name ?? "",
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        timeago
                            .format(DateTime.parse(article?.publishedAt ?? "")),
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _sendDataToNewsDetailScreen(BuildContext context, Articles? article) {
    Navigator.pushNamed(context, NewsArticleScreen.routeName,
        arguments: article);
  }
}
