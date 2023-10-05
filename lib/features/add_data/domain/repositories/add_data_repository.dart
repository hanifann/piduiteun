import 'package:dartz/dartz.dart';
import 'package:piduiteun/core/error/failures.dart';
import 'package:piduiteun/features/add_data/domain/entities/expenditure.dart';

abstract class AddDataRepository {
  Future<Either<Failure, String>>? addExData(Expenditure expenditure);
  Future<Either<Failure, String>>? addInData(Expenditure expenditure);
}
