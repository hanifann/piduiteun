import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:piduiteun/features/home/domain/entities/segmented_choice.dart';
import 'package:piduiteun/features/home/presentation/bloc/home_bloc.dart';
import 'package:piduiteun/features/home/presentation/widgets/category_segmented_btn_widget.dart';
import 'package:piduiteun/features/statistic/presentation/cubit/statistic_cubit.dart';
import 'package:piduiteun/injection_container.dart';

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
  SegmentedChoice selectedSegmented = SegmentedChoice.pengeluaran;
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context),
      body: ListView(
        padding: EdgeInsets.all(16.r),
        children: [
          statisticSummaryBlocBuilderWidget(),
          SizedBox(height: 16.h,),
          catagorySegmentedBtnWidget(),
        ],
      ),
    );
  }

  CategorySegmentedBtnWidget catagorySegmentedBtnWidget() {
    return CategorySegmentedBtnWidget(
      selectedValue: <SegmentedChoice>{selectedSegmented},
      onSelectionChanged: (value) {
        setState(() {
          selectedSegmented = value.first;
        });
        if(selectedSegmented == SegmentedChoice.pengeluaran){
          context.read<HomeBloc>().add(GetExDataEvent());
        } else {
          context.read<HomeBloc>().add(GetInDataEvent());
        }
      },
    );
  }

  BlocBuilder<StatisticCubit, StatisticState> statisticSummaryBlocBuilderWidget() {
    return BlocBuilder<StatisticCubit, StatisticState>(
      builder: (context, state) {
        if(state is StatisticLoaded){
          return RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
              style: Theme.of(context).textTheme.bodySmall!
              .copyWith(
                color: Theme.of(context).colorScheme.secondary,
              ),
              children: [
                const TextSpan(
                  text: 'Anda telah menghabiskan ',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextSpan(
                  text: '-${NumberFormat.currency(
                    locale: 'id',
                    name: 'Rp.',
                  ).format(state.expense)} ',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const TextSpan(
                  text: 'dan pemasukan anda ',
                  style: TextStyle(
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
            const TextSpan(
              text: 'Statistik Bulan ',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextSpan(
              text: DateFormat.MMMM('id').format(DateTime.now()),
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
}
