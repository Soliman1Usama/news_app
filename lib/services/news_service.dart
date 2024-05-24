import 'package:dio/dio.dart';
import 'package:news_watcher/features/home/data/models/article_model.dart';

class NewsService {
  final Dio dio;

  NewsService(this.dio);

  Future<List<ArticleModel>> getTopHeadLines({required String category}) async {
    try {
      var response = await dio.get(
          'https://newsapi.org/v2/top-headlines?country=us&apiKey=a65c88ea29ca4b119a9a1b4a907e2ff5&category=$category');

      Map<String, dynamic> jsonData = response.data;

      List<dynamic> articles = jsonData['articles'];

      List<ArticleModel> articlesList = [];

      for (var article in articles) {
        ArticleModel articleModel = ArticleModel.fromJson(article);
        if (articleModel.image != null) { // Check for non-null imageUrl
          articlesList.add(articleModel);
        }
      }
      return articlesList;
    } catch (e) {
      return [];
    }
  }
}
