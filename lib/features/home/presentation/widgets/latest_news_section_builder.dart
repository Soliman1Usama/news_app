import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_watcher/core/widgets/error_message.dart';
import 'package:news_watcher/core/widgets/loading_indicator.dart';
import 'package:news_watcher/features/home/data/models/article_model.dart';
import 'package:news_watcher/features/home/presentation/widgets/latest_news_item.dart';
import 'package:news_watcher/features/home/presentation/widgets/latest_news_list_view.dart';
import 'package:news_watcher/services/news_service.dart';

class LatestNewsSectionBuilder extends StatefulWidget {
  const LatestNewsSectionBuilder({super.key, required this.category});

  final String category;

  @override
  State<LatestNewsSectionBuilder> createState() => _LatestNewsSectionBuilderState();
}

class _LatestNewsSectionBuilderState extends State<LatestNewsSectionBuilder> {

  late Future<List<ArticleModel>> future2;

  var future;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    future = NewsService(Dio()).getTopHeadLines(category: widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ArticleModel>>(
        future: future, builder: (context, snapshot) {

      if (snapshot.hasData) {
        print('x');
        return LatestNewsListView(articles: snapshot.data!,);
      } else if (snapshot.hasData) {
        return const SliverToBoxAdapter(
          child: Center(
            child: ErrorMessage(message: 'OOPS There Was An Error,try later'),
          ),
        );
      } else {
        return const SliverToBoxAdapter(
          child: Center(child: LoadingIndicator(),),
        );
      }

    });
  }
}
