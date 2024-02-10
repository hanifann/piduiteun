import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:piduiteun/features/add_data/domain/entities/expenditure.dart';

part 'statistic_state.dart';

class StatisticCubit extends Cubit<StatisticState> {
  StatisticCubit(this.income, this.expense) : super(StatisticInitial());

  final Box<Expenditure> income;
  final Box<Expenditure> expense;

  void getYearlyStatistic() {
    final year = DateTime.now().year;

    emit(StatisticLoading());

    final inMonthly = income.values.where(
      (element) => element.dateTime.year == year,
    ).fold(0, (previousValue, element) => previousValue+element.expenditure);

    final exMonthly = expense.values.where(
      (element) => element.dateTime.year == year,
    ).fold(0, (previousValue, element) => previousValue+element.expenditure);

    emit(StatisticLoaded(income: inMonthly, expense: exMonthly));
  }

  void getMonthlyStatistic() {
    final month = DateTime.now().month;
    emit(StatisticLoading());
    final inMonthly = income.values.where(
      (element) => element.dateTime.month == month,
    ).fold(0, (previousValue, element) => previousValue+element.expenditure);

    final exMonthly = expense.values.where(
      (element) => element.dateTime.month == month,
    ).fold(0, (previousValue, element) => previousValue+element.expenditure);

    emit(StatisticLoaded(income: inMonthly, expense: exMonthly));
  }

  void getWeeklyStatistic() {
    final currentData = DateTime.now();
    final aWeekAgo = currentData.subtract(const Duration(days: 7));

    emit(StatisticLoading());

    final inMonthly = income.values.where(
      (element) => element.dateTime.isAfter(aWeekAgo) && 
        element.dateTime.isBefore(currentData),
    ).fold(0, (previousValue, element) => previousValue+element.expenditure);

    final exMonthly = expense.values.where(
      (element) => element.dateTime.isAfter(aWeekAgo) && 
        element.dateTime.isBefore(currentData),
    ).fold(0, (previousValue, element) => previousValue+element.expenditure);

    emit(StatisticLoaded(income: inMonthly, expense: exMonthly));

  }

}
