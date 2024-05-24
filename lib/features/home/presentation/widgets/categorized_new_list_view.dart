import 'package:flutter/material.dart';
import 'package:news_watcher/features/home/data/models/article_model.dart';
import 'package:news_watcher/features/home/presentation/widgets/categorized_new_item.dart';

class CategorizedNewsListViewVertical extends StatelessWidget {
  const CategorizedNewsListViewVertical({super.key, required this.articles});
  final List<ArticleModel> articles;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return SizedBox(
      height: 600,
      width: width,
      child: ListView.builder(
          itemCount: articles.length,
          itemBuilder: (con,index){
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: CategorizedNewsItem(articleModel: articles[index],),
        );
      }),
    );
  }
}
