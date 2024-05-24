import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_watcher/core/widgets/error_message.dart';
import 'package:news_watcher/core/widgets/loading_indicator.dart';
import 'package:news_watcher/features/home/data/models/article_model.dart';
import 'package:news_watcher/features/home/presentation/widgets/latest_news_item.dart';
import 'package:news_watcher/features/home/presentation/widgets/latest_news_list.dart';
import 'package:news_watcher/features/home/presentation/widgets/see_all_latest_news_list_view.dart';
import 'package:news_watcher/services/news_service.dart';

class SeeAllLatestNews extends StatefulWidget {
  const SeeAllLatestNews({super.key});

  @override
  State<SeeAllLatestNews> createState() => _SeeAllLatestNewsState();
}

class _SeeAllLatestNewsState extends State<SeeAllLatestNews> {

  late Future<List<ArticleModel>> future2;

  var future;

  final String category = 'general';


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    future = NewsService(Dio()).getTopHeadLines(category: category);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,),
      body: FutureBuilder<List<ArticleModel>>(
          future: future, builder: (context, snapshot) {

        if (snapshot.hasData) {
          print('x');
          return SeeAllLatestNewsListView(articles: snapshot.data!);
        } else if (snapshot.hasData) {
          return const Center(
            child: ErrorMessage(message: 'OOPS There Was An Error,try later'),
          );
        } else {
          return const Center(child: SizedBox(
              height: 50,
              width: 50,
              child: LoadingIndicator()),);
        }

      }),
    );
  }
}
