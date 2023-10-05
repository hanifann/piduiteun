part of 'add_data_bloc.dart';

sealed class AddDataState extends Equatable {
  const AddDataState();
  
  @override
  List<Object> get props => [];
}

final class AddDataInitial extends AddDataState {}

final class AddDataSucceed extends AddDataState {}

final class AddDataFailed extends AddDataState {
  const AddDataFailed({required this.errorMessage});

  final String errorMessage;
}
