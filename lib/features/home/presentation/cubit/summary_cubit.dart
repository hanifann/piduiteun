import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:piduiteun/features/add_data/domain/entities/expenditure.dart';

part 'summary_state.dart';

class SummaryCubit extends Cubit<SummaryState> {
  SummaryCubit(this.income, this.expense) : super(SummaryInitial());

  final Box<Expenditure> income;
  final Box<Expenditure> expense;

  void thisMonthSummaryEvent(){
    emit(SummaryLoading());
    final inSum = income.values.toList().fold(
      0, (previousValue, element) => previousValue+element.expenditure,
    );
    final exSum = expense.values.toList().fold(
      0, (previousValue, element) => previousValue+element.expenditure,
    );
    final sum = inSum-exSum;
    emit(SummaryLoaded(summary: sum));
  }
}
