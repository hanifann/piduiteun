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
import 'package:piduiteun/features/home/data/datasources/home_local_datasource.dart';
import 'package:piduiteun/features/home/data/repositories/home_repository_impl.dart';
import 'package:piduiteun/features/home/domain/repositories/home_repository.dart';
import 'package:piduiteun/features/home/domain/usecases/get_ex_data_usecase.dart';
import 'package:piduiteun/features/home/domain/usecases/get_in_data_usecase.dart';
import 'package:piduiteun/features/home/presentation/bloc/home_bloc.dart';
import 'package:piduiteun/features/home/presentation/cubit/in_ex_summary_cubit.dart';
import 'package:piduiteun/features/home/presentation/cubit/summary_cubit.dart';

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
  final exBox = await Hive.openBox<Expenditure>('expenditure');
  final inBox = await Hive.openBox<Expenditure>('income');
  sl.registerLazySingleton<AddDataLocalDataSource>(
  () => AddDataLocalDataSourceImpl(
    exBox: exBox, inBox: inBox,
  ),);

  //home
  //bloc
  sl.registerFactory(() => HomeBloc(
    getExDataUseCase: sl(), 
    getInDataUseCase: sl(),
  ),);
  //cubit
  sl.registerFactory(SummaryCubit.new);
  sl.registerFactory(InExSummaryCubit.new);
  //usecases
  sl.registerLazySingleton(() => GetExDataUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetInDataUseCase(repository: sl()));
  //repositories
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(localDataSource: sl()),
  );
  //datasources
  sl.registerLazySingleton<HomeLocalDataSource>(
    () => HomeLocalDataSourceImpl(exBox: exBox, inBox: inBox),
  );
}
