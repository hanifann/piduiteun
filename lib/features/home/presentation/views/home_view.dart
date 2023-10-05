import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:piduiteun/features/add_data/domain/entities/expenditure.dart';
import 'package:piduiteun/features/home/domain/entities/segmented_choice.dart';
import 'package:piduiteun/features/home/presentation/bloc/home_bloc.dart';
import 'package:piduiteun/features/home/presentation/widgets/category_segmented_btn_widget.dart';
import 'package:piduiteun/features/home/presentation/widgets/in_ex_container_data_widget.dart';
import 'package:piduiteun/features/home/presentation/widgets/transaction_container_widget.dart';
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
  SegmentedChoice selectedSegmented = SegmentedChoice.pengeluaran;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        children: [
          thisMonthExpanseTextWidget(context),
          expanseTextWidget(),
          SizedBox(height: 24.h),
          summaryRowWidget(),
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
        if(selectedSegmented == SegmentedChoice.pengeluaran){
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
      text: 'Transaksi terakhir',
      size: 16.sp,
      weight: FontWeight.w500,
    );
  }

  Row summaryRowWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const InExContainerDataWidget(
          title: 'Pengeluaran',
          money: 300000,
          isIncome: false,
        ),
        SizedBox(width: 24.w,),
        const InExContainerDataWidget(
          title: 'Pemasukan',
          money: 5000000,
          isIncome: true,
        ),
      ],
    );
  }

  Center expanseTextWidget() {
    return Center(
      child: CustomTextWidget(
        text: NumberFormat.currency(
          locale: 'id',
          symbol: 'Rp.',
          decimalDigits: 0,
        ).format(4700000),
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
              text: 'Saldo bulan',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 13.sp,
              ),
            ),
            TextSpan(
              text: DateFormat(' MMMM', 'id').format(DateTime.now()),
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
