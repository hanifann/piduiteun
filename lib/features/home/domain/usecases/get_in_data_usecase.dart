import 'package:dartz/dartz.dart';
import 'package:piduiteun/core/error/failures.dart';
import 'package:piduiteun/core/usecase/usecase.dart';
import 'package:piduiteun/features/add_data/domain/entities/expenditure.dart';
import 'package:piduiteun/features/home/domain/repositories/home_repository.dart';

class GetInDataUseCase extends UseCase<List<Expenditure>, NoParams> {
  GetInDataUseCase({required this.repository});

  final HomeRepository repository;

  @override
  Future<Either<Failure, List<Expenditure>>?> call(NoParams params) async {
    return repository.getInData();
  }
  
}
