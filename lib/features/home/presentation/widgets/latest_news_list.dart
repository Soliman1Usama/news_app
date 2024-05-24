import 'package:flutter/material.dart';
import 'package:news_watcher/features/home/data/models/article_model.dart';
import 'package:news_watcher/features/home/presentation/widgets/latest_news_item.dart';

class LatestNewsList extends StatelessWidget {
  const LatestNewsList({
    super.key,
    required this.articles,
  });

  final List<ArticleModel> articles;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // shrinkWrap: true,
        scrollDirection: Axis.horizontal, // Set horizontal scrolling
        itemCount: 3,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 10,right: 10),
            child: LatestNewsItem(articleModel: articles[index],),
          );
        });
  }
}
