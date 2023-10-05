part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();
  
  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  const HomeLoaded({required this.expenditure});

  final List<Expenditure> expenditure;
}

final class HomeFailed extends HomeState {
  const HomeFailed({required this.errorMessage});

  final String errorMessage;
}
