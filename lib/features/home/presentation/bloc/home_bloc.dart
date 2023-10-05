import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:piduiteun/core/usecase/usecase.dart';
import 'package:piduiteun/features/add_data/domain/entities/expenditure.dart';
import 'package:piduiteun/features/home/domain/usecases/get_ex_data_usecase.dart';
import 'package:piduiteun/features/home/domain/usecases/get_in_data_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required this.getExDataUseCase, 
    required this.getInDataUseCase,
  }) : super(HomeInitial()) {
    on<GetExDataEvent>(_onGetExDataEvent);
    on<GetInDataEvent>(_onGetInDataEvent);
  }

  final GetExDataUseCase getExDataUseCase;
  final GetInDataUseCase getInDataUseCase;

  Future<void> _onGetExDataEvent(
    GetExDataEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    final result = await getExDataUseCase(NoParams());
    result!.fold(
      (l) => emit(HomeFailed(errorMessage: l.message)), 
      (r) {
        r.sort((a, b){
          b.dateTime.compareTo(a.dateTime);
          return b.time.compareTo(a.time);
        });
        emit(HomeLoaded(expenditure: r));
      }
    );
  }
  Future<void> _onGetInDataEvent(
    GetInDataEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    final result = await getInDataUseCase(NoParams());
    result!.fold(
      (l) => emit(HomeFailed(errorMessage: l.message)), 
      (r) {
        r.sort((a, b){
          b.dateTime.compareTo(a.dateTime);
          return b.time.compareTo(a.time);
        });
        emit(HomeLoaded(expenditure: r));
        emit(HomeLoaded(expenditure: r));
      }
    );
  }
}
