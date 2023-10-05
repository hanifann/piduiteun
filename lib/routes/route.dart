// GoRouter configuration
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:piduiteun/features/add_data/presentation/views/add_data_view.dart';
import 'package:piduiteun/features/home/presentation/bloc/home_bloc.dart';
import 'package:piduiteun/features/home/presentation/cubit/in_ex_summary_cubit.dart';
import 'package:piduiteun/features/home/presentation/cubit/summary_cubit.dart';
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
      builder: (context, state) {
        final extra = state.extra! as Map;
        final homeBloc = extra['homeBloc'] as HomeBloc;
        final summCubit = extra['summaryCubit'] as SummaryCubit;
        final inExSumCubit = extra['inExSumCubit'] as InExSummaryCubit;
        return MultiBlocProvider(
          providers: [
            BlocProvider.value(value: homeBloc),
            BlocProvider.value(value: summCubit),
            BlocProvider.value(value: inExSumCubit),
          ],
          child: const AddDataView(),
        );
      },
    ),
  ],
);
