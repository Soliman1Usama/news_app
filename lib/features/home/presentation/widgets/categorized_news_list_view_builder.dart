import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_watcher/core/widgets/error_message.dart';
import 'package:news_watcher/core/widgets/loading_indicator.dart';
import 'package:news_watcher/features/home/data/models/article_model.dart';
import 'package:news_watcher/features/home/presentation/widgets/categorized_new_list_view.dart';
import 'package:news_watcher/services/news_service.dart';
import 'package:provider/provider.dart';

class CategorizedNewsListViewVerticalBuilder extends StatefulWidget {
  const CategorizedNewsListViewVerticalBuilder(
      {super.key, required this.category, required this.future});

  final String category;
   final Future<List<ArticleModel>> future;

  @override
  State<CategorizedNewsListViewVerticalBuilder> createState() => _CategorizedNewsListViewVerticalBuilderState();
}

class _CategorizedNewsListViewVerticalBuilderState extends State<CategorizedNewsListViewVerticalBuilder> {
  late bool _isLoading;
  @override
  void initState() {
    super.initState();
    _isLoading = true; // Initially, set loading to true
  }
  @override
  Widget build(BuildContext context) {

    return FutureBuilder<List<ArticleModel>>(
        future: widget.future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // If data is loading, show loading indicator
            return const SliverFillRemaining(
              child: Center(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: LoadingIndicator(),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            // If there's an error, show error message
            return SliverToBoxAdapter(
              child: Center(
                child: ErrorMessage(
                  message: 'Oops! There was an error. Please try again later.',
                ),
              ),
            );
          } else if (snapshot.hasData) {
            // If data is available, hide loading indicator and show data
            _isLoading = false; // Set loading to false
            return SliverToBoxAdapter(
              child: CategorizedNewsListViewVertical(
                articles: snapshot.data!,
              ),
            );
          } else {
            // If no data, show some default message
            return const SliverToBoxAdapter(
              child: Center(
                child: Text('No data available.'),
              ),
            );
          }
        },
    );
  }
}
