part of 'in_ex_summary_cubit.dart';

sealed class InExSummaryState extends Equatable {
  const InExSummaryState();

  @override
  List<Object> get props => [];
}

final class InExSummaryInitial extends InExSummaryState {}

final class InExSummaryLoaded extends InExSummaryState {
  const InExSummaryLoaded({required this.income, required this.expenditure});

  final int income;
  final int expenditure;
}

final class InExSummaryLoading extends InExSummaryState {}
