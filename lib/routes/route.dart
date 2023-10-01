// GoRouter configuration
import 'package:go_router/go_router.dart';
import 'package:piduiteun/features/home/presentation/views/bottom_nav_bar_view.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const BottomNavBarView(),
    ),
  ],
);
