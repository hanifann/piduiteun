import 'package:dartz/dartz.dart';
import 'package:piduiteun/core/error/failures.dart';
import 'package:piduiteun/features/add_data/domain/entities/expenditure.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<Expenditure>>>? getExData();
  Future<Either<Failure, List<Expenditure>>>? getInData();
}
