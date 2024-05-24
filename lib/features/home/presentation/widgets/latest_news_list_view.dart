import 'package:flutter/material.dart';
import 'package:news_watcher/features/home/data/models/article_model.dart';
import 'package:news_watcher/features/home/presentation/widgets/latest_news_list.dart';

class LatestNewsListView extends StatelessWidget {
  const LatestNewsListView({super.key, required this.articles});
  final List<ArticleModel> articles;


  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 240,
        child: LatestNewsList(articles: articles),
      ),
    );
  }
}

