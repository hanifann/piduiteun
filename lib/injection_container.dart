//ignore_for_file: cascade_invocations, inference_failure_on_function_invocation

import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:piduiteun/features/add_data/data/datasources/add_data_local_datasource.dart';
import 'package:piduiteun/features/add_data/data/repositories/add_data_repository_impl.dart';
import 'package:piduiteun/features/add_data/domain/entities/expenditure.dart';
import 'package:piduiteun/features/add_data/domain/repositories/add_data_repository.dart';
import 'package:piduiteun/features/add_data/domain/usecases/add_ex_data_usecase.dart';
import 'package:piduiteun/features/add_data/domain/usecases/add_in_data_usecase.dart';
import 'package:piduiteun/features/add_data/presentation/bloc/add_data_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {

  //add data
  //bloc
  sl.registerFactory(() => AddDataBloc(
    addExDataUseCase: sl(), 
    addInDataUseCase: sl(),
  ),);
  //usecases
  sl.registerLazySingleton(() => AddExDataUseCase(repository: sl()));
  sl.registerLazySingleton(() => AddInDataUseCase(repository: sl()));
  //respositories
  sl.registerLazySingleton<AddDataRepository>(
    () => AddDataRepositoryImpl(localDataSource: sl()),
  );
  //datasources
  sl.registerLazySingleton(() => AddDataLocalDataSourceImpl(
    exBox: sl(), inBox: sl(),
  ),);

  //core
  final exBox = await Hive.openLazyBox<Expenditure>('expenditure');
  final inBox = await Hive.openLazyBox<Expenditure>('income');
  sl.registerLazySingleton(() => exBox);
  sl.registerLazySingleton(() => inBox);
}
