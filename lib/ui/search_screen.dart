import 'package:flutter/material.dart';
import 'package:flutter_news_app/data/remote/response/status.dart';
import 'package:flutter_news_app/models/news_api_response.dart';
import 'package:flutter_news_app/ui/bottom_nav_bar.dart';
import 'package:flutter_news_app/ui/news_article.dart';
import 'package:flutter_news_app/ui/widget/loading_widget.dart';
import 'package:flutter_news_app/ui/widget/my_error_widget.dart';
import 'package:flutter_news_app/viewmodel/headlines_response_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'dart:developer' as developer;

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  static const routeName = '/search';

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final HeadlinesResponseViewModel viewModel = HeadlinesResponseViewModel();
  final TextEditingController searchQuery = TextEditingController();
  bool isSearching = false;

  @override
  void initState() {
    isSearching = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: TextField(
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      isSearching = true;
                      developer.log('Searching news for ${searchQuery.text}');
                      viewModel.searchHeadlines(searchQuery.text);
                      FocusScope.of(context).unfocus();
                    },
                  ),
                  hintText: 'Search...',
                  border: InputBorder.none,
                ),
                controller: searchQuery,
              ),
            ),
          )),
      bottomNavigationBar: const BottomNavBar(index: 1),
      body: ChangeNotifierProvider<HeadlinesResponseViewModel>(
        create: (BuildContext context) => viewModel,
        child: Consumer<HeadlinesResponseViewModel>(
            builder: (context, viewModel, _) {
          switch (viewModel.searchResponse.status) {
            case Status.LOADING:
              {
                if (isSearching) {
                  return const LoadingWidget();
                } else {
                  return Container();
                }
              }
            case Status.ERROR:
              return MyErrorWidget(viewModel.searchResponse.message ?? "NA");
            case Status.COMPLETED:
              {
                isSearching = false;
                return _getNewsListView(viewModel.searchResponse.data);
              }
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
