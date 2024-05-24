class ArticleModel
{
  final String? url;
  final String? image;
  final String title;
  final String? subtitle;



  ArticleModel(
      {required this.url,required this.image, required this.title, required this.subtitle});

  factory ArticleModel.fromJson(json)
  {
    return ArticleModel(
        url: json['url'],
        image: json['urlToImage'],
        title: json['title'],
        subtitle: json['description']
    );
  }
}