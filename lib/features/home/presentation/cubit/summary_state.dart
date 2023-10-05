part of 'summary_cubit.dart';

sealed class SummaryState extends Equatable {
  const SummaryState();

  @override
  List<Object> get props => [];
}

final class SummaryInitial extends SummaryState {}

final class SummaryLoading extends SummaryState {}

final class SummaryLoaded extends SummaryState {
  const SummaryLoaded({required this.summary});

  final int summary;
}
