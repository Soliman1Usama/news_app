import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_watcher/constants.dart';
import 'package:news_watcher/core/utils/app_router.dart';
import 'package:news_watcher/core/utils/styles.dart';
import 'package:news_watcher/features/home/data/models/article_model.dart';
import 'package:news_watcher/features/home/presentation/widgets/categorized_news_list_view_builder.dart';
import 'package:news_watcher/features/home/presentation/widgets/custom_appbar_home_view.dart';
import 'package:news_watcher/features/home/presentation/widgets/latest_news_section_builder.dart';
import 'package:news_watcher/services/news_service.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  int _selectedIndex = 0;
  List<String> categories = [
    'Business',
    'Entertainment',
    'Health',
    'Science',
    'Sports'
  ];

  late Future<List<ArticleModel>>
      future; // Declare future variable outside the function
  @override
  void initState() {
    super.initState();
    future = NewsService(Dio())
        .getTopHeadLines(category: categories[_selectedIndex]);
  }

  void onCategorySelected(int index) {
    setState(() {
      _selectedIndex = index;
      future = NewsService(Dio())
          .getTopHeadLines(category: categories[_selectedIndex]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      const SliverToBoxAdapter(child: CustomHomeViewAppBar()),
      SliverToBoxAdapter(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 24, bottom: 16, left: 15, right: 15),
          child: Row(
            children: [
              const Text(
                'Latest New',
                style: AppStyles.textStyleBold18,
              ),
              const Spacer(),
              Text(
                'See All',
                style: AppStyles.textStyleSemiBold12
                    .copyWith(color: const Color(0xFF0080FF)),
              ),
              IconButton(
                  onPressed: () {
                    GoRouter.of(context).push(AppRouter.kSeeAll);
                  },
                  icon: const Icon(
                    Icons.arrow_forward,
                    color: Color(0xFF0080FF),
                    size: 18,
                  ))
            ],
          ),
        ),
      ),
      const LatestNewsSectionBuilder(
        category: 'general',
      ),
      SliverToBoxAdapter(
          child: Padding(
        padding: const EdgeInsets.only(left: 10, top: 24),
        child: SizedBox(
          height: 40,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  onCategorySelected(index);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  decoration: BoxDecoration(
                    color: _selectedIndex == index
                        ? kPrimaryColor // Color for selected item
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  margin: const EdgeInsets.only(bottom: 5.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      categories[index],
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: _selectedIndex == index
                            ? Colors.white // Color for selected item
                            : Colors.black,
                      ),
                    ),
                  ), // Add space between items
                ),
              );
            },
          ),
        ),
      )),
      CategorizedNewsListViewVerticalBuilder(
        category: categories[_selectedIndex],
        future: future,
      ),
    ]);
  }
}
