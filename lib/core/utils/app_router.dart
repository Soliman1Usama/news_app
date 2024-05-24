
import 'package:go_router/go_router.dart';
import 'package:news_watcher/features/auth/login/presentation/views/login_view.dart';
import 'package:news_watcher/features/auth/sign_up/presentation/views/sign_up_view.dart';
import 'package:news_watcher/features/home/presentation/views/home_view.dart';
import 'package:news_watcher/features/home/presentation/views/profile_view.dart';
import 'package:news_watcher/features/home/presentation/views/see_all_latest_news.dart';


abstract class AppRouter {
  static const kLogin = '/';
  static const kSignUp = '/signUp';
  static const kHome = '/HomeView';
  static const kSeeAll = '/SeeAll';
  static const kProfile = '/Profile';

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: kSignUp,
        builder: (context, state) => const SignUpView(),
      ),
      GoRoute(
        path: kHome,
        builder: (context, state) => const HomeView(),
      ),
      GoRoute(
        path: kSeeAll,
        builder: (context, state) => const SeeAllLatestNews(),
      ),

      GoRoute(
        path: kProfile,
        builder: (context, state) => const ProfileView(),
      ),

    ],
  );
}
