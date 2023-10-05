part of 'add_data_bloc.dart';

sealed class AddDataEvent extends Equatable {
  const AddDataEvent();

  @override
  List<Object> get props => [];
}

class AddInDataEvent extends AddDataEvent {
  const AddInDataEvent({required this.expenditure});

  final Expenditure expenditure;
}

class AddExDataEvent extends AddDataEvent {
  const AddExDataEvent({required this.expenditure});

  final Expenditure expenditure;
}
