import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'expenditure.g.dart';

@HiveType(typeId: 1)
class Expenditure extends Equatable {
  const Expenditure({
    required this.expenditure, 
    required this.dateTime, 
    required this.information, 
    required this.time,
    required this.tag,
  });

  @HiveField(0)
  final double expenditure;
  @HiveField(1)
  final DateTime dateTime;
  @HiveField(2)
  final String information;
  @HiveField(3)
  final String time;
  @HiveField(4)
  final String tag;

  @override
  List<Object?> get props => throw UnimplementedError();
  
}
