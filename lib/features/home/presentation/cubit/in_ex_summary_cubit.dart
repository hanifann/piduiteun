import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:piduiteun/features/add_data/domain/entities/expenditure.dart';

part 'in_ex_summary_state.dart';

class InExSummaryCubit extends Cubit<InExSummaryState> {
  InExSummaryCubit() : super(InExSummaryInitial());

  void inExSummEvent(List<Expenditure> income, List<Expenditure> expense){
    emit(InExSummaryLoading());
    final inSum = income.fold(
      0, (previousValue, element) => previousValue+element.expenditure,
    );
    final exSum = income.fold(
      0, (previousValue, element) => previousValue+element.expenditure,
    );
    emit(InExSummaryLoaded(income: inSum, expenditure: exSum));
  }
}
