import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:piduiteun/features/add_data/domain/entities/expenditure.dart';

part 'in_ex_summary_state.dart';

class InExSummaryCubit extends Cubit<InExSummaryState> {
  InExSummaryCubit(this.income, this.expense) : super(InExSummaryInitial());

  final Box<Expenditure> income;
  final Box<Expenditure> expense;

  void inExSummEvent(){
    emit(InExSummaryLoading());
    final inSum = income.values.fold(
      0, (previousValue, element) => previousValue+element.expenditure,
    );
    final exSum = expense.values.fold(
      0, (previousValue, element) => previousValue+element.expenditure,
    );
    emit(InExSummaryLoaded(income: inSum, expenditure: exSum));
  }
}
