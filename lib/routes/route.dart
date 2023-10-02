// GoRouter configuration
import 'package:go_router/go_router.dart';
import 'package:piduiteun/features/add_data/presentation/views/add_data_view.dart';
import 'package:piduiteun/features/home/presentation/views/bottom_nav_bar_view.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const BottomNavBarView(),
    ),
    GoRoute(
      path: '/add_data',
      name: 'add_data',
      builder: (context, state) => const AddDataView(),
    ),
  ],
);
