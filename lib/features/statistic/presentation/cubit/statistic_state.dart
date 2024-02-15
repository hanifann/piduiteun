part of 'statistic_cubit.dart';

sealed class StatisticState extends Equatable {
  const StatisticState();

  @override
  List<Object> get props => [];
}

final class StatisticInitial extends StatisticState {}

final class StatisticLoaded extends StatisticState {
  const StatisticLoaded({
    required this.income, 
    required this.expense, 
  });


  final int income;
  final int expense;
}

final class StatisticFailed extends StatisticState {}

final class StatisticLoading extends StatisticState {}
