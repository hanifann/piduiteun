import 'package:hive_flutter/hive_flutter.dart';
import 'package:piduiteun/core/error/exception.dart';
import 'package:piduiteun/features/add_data/domain/entities/expenditure.dart';

abstract class HomeLocalDataSource {
  Future<List<Expenditure>> getExData();
  Future<List<Expenditure>> getInData();
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  HomeLocalDataSourceImpl({required this.exBox, required this.inBox});

  final Box<Expenditure> exBox;
  final Box<Expenditure> inBox;
  
  @override
  Future<List<Expenditure>> getExData() {
    final response = exBox.values.toList();
    if(response.isNotEmpty){
      return Future.value(response);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<List<Expenditure>> getInData() {
    final response = inBox.values.toList();
    if(response.isNotEmpty){
      return Future.value(response);
    } else {
      throw CacheException();
    }
  }
  
}
