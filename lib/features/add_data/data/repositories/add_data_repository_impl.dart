import 'package:dartz/dartz.dart';
import 'package:piduiteun/core/error/exception.dart';
import 'package:piduiteun/core/error/failures.dart';
import 'package:piduiteun/features/add_data/data/datasources/add_data_local_datasource.dart';
import 'package:piduiteun/features/add_data/domain/entities/expenditure.dart';
import 'package:piduiteun/features/add_data/domain/repositories/add_data_repository.dart';

class AddDataRepositoryImpl implements AddDataRepository {
  AddDataRepositoryImpl({required this.localDataSource});

  final AddDataLocalDataSource localDataSource;

  @override
  Future<Either<Failure, String>>? addExData(Expenditure expenditure) async {
    try {
      await localDataSource.saveExData(expenditure);
      return const Right('success');
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>>? addInData(Expenditure expenditure) async {
    try {
      await localDataSource.saveInData(expenditure);
      return const Right('success');
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }
  
}
