import 'package:hive_flutter/hive_flutter.dart';
import 'package:piduiteun/features/add_data/domain/entities/expenditure.dart';

abstract class AddDataLocalDataSource {
  Future<void>? saveExData(Expenditure expenditure);
  Future<void>? saveInData(Expenditure expenditure);
}

class AddDataLocalDataSourceImpl implements AddDataLocalDataSource {
  AddDataLocalDataSourceImpl({required this.exBox, required this.inBox});


  final Box<Expenditure> exBox;
  final Box<Expenditure> inBox;

  @override
  Future<void>? saveExData(Expenditure expenditure) {
    return exBox.add(expenditure);
  }

  @override
  Future<void>? saveInData(Expenditure expenditure) {
    return inBox.add(expenditure);
  }
}
