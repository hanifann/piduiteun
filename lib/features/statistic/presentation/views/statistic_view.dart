import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:piduiteun/features/home/domain/entities/segmented_choice.dart';
import 'package:piduiteun/features/home/presentation/bloc/home_bloc.dart';
import 'package:piduiteun/features/home/presentation/widgets/category_segmented_btn_widget.dart';
import 'package:piduiteun/features/statistic/presentation/cubit/statistic_cubit.dart';
import 'package:piduiteun/features/statistic/presentation/widgets/dropwodn_time_interval_widget.dart';
import 'package:piduiteun/injection_container.dart';
import 'package:piduiteun/l10n/l10n.dart';

class StatisticView extends StatelessWidget {
  const StatisticView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<StatisticCubit>()..getMonthlyStatistic(),
      child: const StatisticPage(),
    );
  }
}

class StatisticPage extends StatefulWidget {
  const StatisticPage({super.key});

  @override
  State<StatisticPage> createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  SegmentedChoice selectedSegmented = SegmentedChoice.expense;
  final dropwownController = TextEditingController();

  TimeIntervals selectedInterval = TimeIntervals.monthly;

  final List<ChartData> chartData = [
      ChartData('David', 25),
      ChartData('Steve', 38),
      ChartData('Jack', 34),
      ChartData('Others', 52),
  ];
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context),
      body: RefreshIndicator(
        onRefresh: () async {
          intervalToEvent(selectedInterval);
        },
        child: ListView(
          padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
          children: [
            titleRowWidget(context),
            SizedBox(height: 8.h,),
            statisticSummaryBlocBuilderWidget(),
            SizedBox(height: 16.h,),
            catagorySegmentedBtnWidget(),
            SizedBox(height: 16.h,),
            // BlocBuilder<StatisticCubit, StatisticState>(
            //   builder: (context, state) {
            //     if(state is StatisticLoaded){
            //       return SfCircularChart(
            //         series: [
            //           // Render pie chart

            //         ]
            //       );
            //     } else {
            //       return const SizedBox.shrink();
            //     }
            //   },
            // ),
          ],
        ),
      ),
    );
  }

  Text subtitleWidget(BuildContext context, String subtitle) {
    return Text(
      subtitle,
      style: Theme.of(context).textTheme.titleMedium,
    );
  }

  Row titleRowWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          context.l10n.summary,
          style: Theme.of(context).textTheme.titleLarge!
            .copyWith(
              fontWeight: FontWeight.w600,
            ),
        ),
        DropdownTimeIntervalWidget(
          controller: dropwownController, 
          onSelected: (interval) {
            setState(() {
              selectedInterval = interval!;
            });
            intervalToEvent(selectedInterval);
          },
        ),
      ],
    );
  }

  CategorySegmentedBtnWidget catagorySegmentedBtnWidget() {
    return CategorySegmentedBtnWidget(
      selectedValue: <SegmentedChoice>{selectedSegmented},
      onSelectionChanged: (value) {
        setState(() {
          selectedSegmented = value.first;
        });
        if(selectedSegmented == SegmentedChoice.expense){
          context.read<HomeBloc>().add(GetExDataEvent());
        } else {
          context.read<HomeBloc>().add(GetInDataEvent());
        }
      },
    );
  }

  BlocBuilder<StatisticCubit, StatisticState> 
    statisticSummaryBlocBuilderWidget() {
    return BlocBuilder<StatisticCubit, StatisticState>(
      builder: (context, state) {
        if(state is StatisticLoaded){
          return SizedBox(
            child: RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.bodySmall!
                .copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
                children: [
                  TextSpan(
                    text: '${context.l10n.spent} ',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(
                    text: '-${NumberFormat.currency(
                      locale: 'id',
                      name: 'Rp. ',
                    ).format(state.expense)} ',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(
                    text: '${context.l10n.yourIncome} ',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(
                    text: '+${NumberFormat.currency(
                      locale: 'id',
                      name: 'Rp.',
                    ).format(state.income)}.',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  AppBar appBarWidget(BuildContext context) {
    return AppBar(
      title: RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.titleLarge,
          children: [
            TextSpan(
              text: '${context.l10n.monthStatisticsAppBarTitle} ',
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextSpan(
              text: DateFormat.MMMM().format(DateTime.now()),
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(10.h), 
        child: const Divider(),
      ),
    );
  }

  void intervalToEvent(TimeIntervals intervals) {
    switch (intervals) {
      case TimeIntervals.weekly:
        context.read<StatisticCubit>().getWeeklyStatistic();
      case TimeIntervals.monthly:
        context.read<StatisticCubit>().getMonthlyStatistic();  
      case TimeIntervals.yearly:
        context.read<StatisticCubit>().getYearlyStatistic();
    }
  }
}

class ChartData {
    ChartData(this.x, this.y, [this.color]);
    final String x;
    final double y;
    final Color? color;
}
