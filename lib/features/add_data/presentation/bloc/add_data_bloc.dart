import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:piduiteun/features/add_data/domain/entities/expenditure.dart';
import 'package:piduiteun/features/add_data/domain/usecases/add_ex_data_usecase.dart';
import 'package:piduiteun/features/add_data/domain/usecases/add_in_data_usecase.dart';

part 'add_data_event.dart';
part 'add_data_state.dart';

class AddDataBloc extends Bloc<AddDataEvent, AddDataState> {
  AddDataBloc({
    required this.addExDataUseCase, 
    required this.addInDataUseCase,
  }) : super(AddDataInitial()) {
    on<AddInDataEvent>(_onAddInDataEvent);
    on<AddExDataEvent>(_onAddExDataEvent);
  }

  final AddExDataUseCase addExDataUseCase;
  final AddInDataUseCase addInDataUseCase;

  Future<void> _onAddInDataEvent(
    AddInDataEvent event,
    Emitter<AddDataState> emit,
  ) async {
    final result = await addInDataUseCase(
      AddDataParams(expenditure: event.expenditure),
    );

    result!.fold(
      (l) => emit(AddDataFailed(errorMessage: l.message)), 
      (r) => emit(AddDataSucceed()),
    );
  }

  Future<void> _onAddExDataEvent(
    AddExDataEvent event,
    Emitter<AddDataState> emit,
  ) async {
    final result = await addExDataUseCase(
      AddDataParams(expenditure: event.expenditure),
    );

    result!.fold(
      (l) => emit(AddDataFailed(errorMessage: l.message)), 
      (r) => emit(AddDataSucceed()),
    );
  }
}
