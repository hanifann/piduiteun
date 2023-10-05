import 'package:dartz/dartz.dart';
import 'package:piduiteun/core/error/failures.dart';
import 'package:piduiteun/core/usecase/usecase.dart';
import 'package:piduiteun/features/add_data/domain/repositories/add_data_repository.dart';
import 'package:piduiteun/features/add_data/domain/usecases/add_ex_data_usecase.dart';

class AddInDataUseCase extends UseCase<String, AddDataParams> {
  AddInDataUseCase({required this.repository});


  final AddDataRepository repository;

  @override
  Future<Either<Failure, String>?> call(AddDataParams params) async {
    return repository.addInData(params.expenditure);
  }
  
}
