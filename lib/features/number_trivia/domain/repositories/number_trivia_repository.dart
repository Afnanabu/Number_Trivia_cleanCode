import 'package:cleanarchitectureproject/core/error/errors.dart';
import 'package:cleanarchitectureproject/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:dartz/dartz.dart';

abstract class RandomNumberRepository {
 Future<Either<Failure, RandomNumber>> getConcreteRandomNumber(int number);

 Future<Either<Failure, RandomNumber>> getRandomNumber();
}
