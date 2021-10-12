import 'package:cleanarchitectureproject/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
 import 'package:cleanarchitectureproject/features/number_trivia/domain/repositories/number_trivia_repository.dart';
 import 'package:cleanarchitectureproject/core/error/errors.dart';
import 'package:cleanarchitectureproject/features/number_trivia/domain/entities/number_trivia.dart';

class GetRandomNumber extends UseCase<RandomNumber, NoParameters> {
  final RandomNumberRepository repository;

  GetRandomNumber(this.repository);

  @override
  Future<Either<Failure, RandomNumber>> call(NoParameters params) async {
    return await repository.getRandomNumber();
  }
}