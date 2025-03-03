import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:piduiteun/features/add_data/domain/entities/expenditure.dart';
import 'package:piduiteun/features/home/domain/entities/segmented_choice.dart';
import 'package:piduiteun/features/home/presentation/bloc/home_bloc.dart';
import 'package:piduiteun/features/home/presentation/cubit/in_ex_summary_cubit.dart';
import 'package:piduiteun/features/home/presentation/cubit/summary_cubit.dart';
import 'package:piduiteun/features/home/presentation/widgets/category_segmented_btn_widget.dart';
import 'package:piduiteun/features/home/presentation/widgets/in_ex_container_data_widget.dart';
import 'package:piduiteun/features/home/presentation/widgets/transaction_container_widget.dart';
import 'package:piduiteun/l10n/l10n.dart';
import 'package:piduiteun/widgets/text_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomePage();
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SegmentedChoice selectedSegmented = SegmentedChoice.expense;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        children: [
          thisMonthExpanseTextWidget(context),
          summaryBlocBuilderWidget(),
          SizedBox(height: 24.h),
          inExSummaryBlocBuilderWidget(),
          SizedBox(height: 24.h,),
          catagorySegmentedBtnWidget(),
          SizedBox(height: 16.h,),
          lastTransTextWidget(),
          SizedBox(height: 8.h),
          inExBlocBuilderWidget(),  
        ],
      ),
    );
  }

  BlocBuilder<InExSummaryCubit, InExSummaryState>inExSummaryBlocBuilderWidget(){
    return BlocBuilder<InExSummaryCubit, InExSummaryState>(
      builder: (context, state) {
        if(state is InExSummaryLoaded){
          return summaryRowWidget(state.income, state.expenditure);
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  BlocBuilder<SummaryCubit, SummaryState> summaryBlocBuilderWidget() {
    return BlocBuilder<SummaryCubit, SummaryState>(
      builder: (context, state) {
        if(state is SummaryLoaded){
          return expanseTextWidget(state.summary);
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  BlocBuilder<HomeBloc, HomeState> inExBlocBuilderWidget() {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if(state is HomeLoaded){
          return expenditureListViewWidget(state.expenditure);
        } else if (state is HomeFailed){
          return const Center(
            child: Text('Belum ada data'),
          );
        } else {
          return const CircularProgressIndicator.adaptive();
        }
      },
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

  ListView expenditureListViewWidget(List<Expenditure> expenditure) {
    return ListView.separated(
      shrinkWrap: true,
      primary: false,
      itemBuilder: (context, index) {
        return TransactionContainerWidget(
          category: expenditure[index].tag, 
          value: expenditure[index].expenditure,
          title: expenditure[index].information,
          dateTime: expenditure[index].dateTime,
        );
      }, 
      separatorBuilder: (_,__) => SizedBox(height: 12.h,), 
      itemCount: expenditure.length <= 10 ? expenditure.length : 10,
    );
  }

  CustomTextWidget lastTransTextWidget() {
    return CustomTextWidget(
      text: context.l10n.latestTransaction,
      size: 16.sp,
      weight: FontWeight.w500,
    );
  }

  Row summaryRowWidget(int income, int expense) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: InExContainerDataWidget(
            title: context.l10n.expenses,
            money: expense,
            isIncome: false,
          ),
        ),
        SizedBox(width: 24.w,),
        Expanded(
          child: InExContainerDataWidget(
            title: context.l10n.income,
            money: income,
            isIncome: true,
          ),
        ),
      ],
    );
  }

  Center expanseTextWidget(int summary) {
    return Center(
      child: CustomTextWidget(
        text: NumberFormat.currency(
          locale: 'id',
          symbol: 'Rp. ',
          decimalDigits: 0,
        ).format(summary),
        size: 24.sp,
        weight: FontWeight.w500,
      ),
    );
  }

  Center thisMonthExpanseTextWidget(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: context.l10n.balance,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 13.sp,
              ),
            ),
            TextSpan(
              text: DateFormat(' MMMM').format(DateTime.now()),
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w500,
                fontSize: 13.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
