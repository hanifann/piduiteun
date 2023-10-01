import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure({
    this.message = 'something went wrong',
  });

  final String message;
  
  @override
  List<Object> get props => [message];
}


class CacheFailure extends Failure {
  const CacheFailure({super.message});
}
