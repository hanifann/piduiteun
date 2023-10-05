import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:piduiteun/features/add_data/domain/entities/expenditure.dart';

part 'summary_state.dart';

class SummaryCubit extends Cubit<SummaryState> {
  SummaryCubit() : super(SummaryInitial());

  void summInEx(List<Expenditure> expenditure){
    emit(SummaryLoading());
    final sum = expenditure.fold(
      0, (previousValue, element) => previousValue+element.expenditure,
    );
    emit(SummaryLoaded(summary: sum));
  }
}
