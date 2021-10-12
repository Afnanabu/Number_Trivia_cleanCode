
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:cleanarchitectureproject/core/error/errors.dart';
import 'package:cleanarchitectureproject/core/usecase/usecase.dart';
import 'package:cleanarchitectureproject/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:cleanarchitectureproject/features/number_trivia/domain/repositories/number_trivia_repository.dart';
 class GetConcreteRandomNumber implements UseCase <RandomNumber,Params>{
  final RandomNumberRepository repository;

  GetConcreteRandomNumber(this.repository);

  Future<Either<Failure, RandomNumber>> call(Params params) async {
    return await repository.getConcreteRandomNumber(params.number);
  }
}

class Params extends Equatable
{
  final int number;
  Params({required this.number});
  @override
  List<Object> get props => [ number];

}