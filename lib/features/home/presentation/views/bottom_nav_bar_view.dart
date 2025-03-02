import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:piduiteun/features/home/presentation/bloc/home_bloc.dart';
import 'package:piduiteun/features/home/presentation/cubit/in_ex_summary_cubit.dart';
import 'package:piduiteun/features/home/presentation/cubit/summary_cubit.dart';
import 'package:piduiteun/features/home/presentation/views/home_view.dart';
import 'package:piduiteun/features/statistic/presentation/views/statistic_view.dart';
import 'package:piduiteun/injection_container.dart';
import 'package:piduiteun/l10n/l10n.dart';

class BottomNavBarView extends StatelessWidget {
  const BottomNavBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => sl<HomeBloc>()..add(GetExDataEvent()),
          ),
          BlocProvider(
            create: (context) => sl<SummaryCubit>()..thisMonthSummaryEvent(),
          ),
          BlocProvider(
            create: (context) => sl<InExSummaryCubit>()..inExSummEvent(),
          ),
        ],
      child: const BottomNavBarPage(),
    );
  }
}

class BottomNavBarPage extends StatefulWidget {
  const BottomNavBarPage({super.key});

  @override
  State<BottomNavBarPage> createState() => _BottomNavBarPageState();
}

class _BottomNavBarPageState extends State<BottomNavBarPage> {
  int currentPageIndex = 0;

  static const List<Widget> body = <Widget>[
    HomeView(),
    StatisticView(),
    Center(
      child: Text('halaman 3'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final navigatorDestination = [
      NavigationDestination(
        icon: const Icon(Symbols.home_rounded),
        label: context.l10n.homeNavbarTitle,
      ),
      NavigationDestination(
        icon: const Icon(Symbols.analytics_rounded),
        label: context.l10n.statisticNavbarTitle,
      ),
      NavigationDestination(
        icon: const Icon(Symbols.receipt_long_rounded),
        label: context.l10n.transactionNavbarTitle,
      ),
    ];
    
    return Scaffold(
      appBar: currentPageIndex == 0 ? AppBar() : null,
      body: body[currentPageIndex],
      bottomNavigationBar: NavigationBar(
        destinations: navigatorDestination,
        selectedIndex: currentPageIndex,
        onDestinationSelected: (value) {
          setState(() {
            currentPageIndex = value;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: () {
          context.pushNamed(
            'add_data',
            extra:{
              'homeBloc': context.read<HomeBloc>(),
              'summaryCubit':  context.read<SummaryCubit>(),
              'inExSumCubit':  context.read<InExSummaryCubit>(),
            },
          );
        },
        elevation: 2,
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }
}
