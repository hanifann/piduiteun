import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:piduiteun/core/error/failures.dart';
import 'package:piduiteun/core/usecase/usecase.dart';
import 'package:piduiteun/features/add_data/domain/entities/expenditure.dart';
import 'package:piduiteun/features/add_data/domain/repositories/add_data_repository.dart';

class AddExDataUseCase extends UseCase<String, AddDataParams> {
  AddExDataUseCase({required this.repository});


  final AddDataRepository repository;

  @override
  Future<Either<Failure, String>?> call(AddDataParams params) async {
    return repository.addExData(params.expenditure);
  }
  
}

class AddDataParams extends Equatable{
  const AddDataParams({required this.expenditure});

  final Expenditure expenditure;
  @override
  List<Object?> get props => [
    expenditure,
  ];
}
