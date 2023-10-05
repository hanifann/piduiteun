import 'package:dartz/dartz.dart';
import 'package:piduiteun/core/error/exception.dart';
import 'package:piduiteun/core/error/failures.dart';
import 'package:piduiteun/features/add_data/domain/entities/expenditure.dart';
import 'package:piduiteun/features/home/data/datasources/home_local_datasource.dart';
import 'package:piduiteun/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl({required this.localDataSource});

  final HomeLocalDataSource localDataSource;

  @override
  Future<Either<Failure, List<Expenditure>>>? getExData() async {
    try {
      final response = await localDataSource.getExData();
      return Right(response);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Expenditure>>>? getInData() async {
    try {
      final response = await localDataSource.getInData();
      return Right(response);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }
  
}
