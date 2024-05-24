import 'package:flutter/material.dart';
import 'package:news_watcher/features/home/data/models/article_model.dart';
import 'package:news_watcher/features/home/presentation/widgets/categorized_new_item.dart';

class SeeAllLatestNewsListView extends StatelessWidget {
  const SeeAllLatestNewsListView({
    super.key,
    required this.articles,
  });

  final List<ArticleModel> articles;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // shrinkWrap: true,
        itemCount: articles.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 20),
            child: CategorizedNewsItem(articleModel: articles[index],),
          );
        });
  }
}
