import 'package:cleanarchitectureproject/core/error/errors.dart';
import 'package:cleanarchitectureproject/core/error/exceptions.dart';
import 'package:cleanarchitectureproject/core/network/network_information.dart';
import 'package:cleanarchitectureproject/features/number_trivia/data/datasource/number_trivia_local_datasource.dart';
import 'package:cleanarchitectureproject/features/number_trivia/data/datasource/number_trivia_remote_datasource.dart';
import 'package:cleanarchitectureproject/features/number_trivia/data/models/number_trivia_models.dart';
import 'package:cleanarchitectureproject/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:cleanarchitectureproject/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:dartz/dartz.dart';

typedef Future<RandomNumberModel> _ConcreteOrRandomChooser();

class RandomNumberRepositoryImpl implements RandomNumberRepository {
  final RandomNumberRemoteDataSource remoteDataSource;
  final RandomNumberLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  RandomNumberRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, RandomNumber>> getConcreteRandomNumber(
      int number,
      ) async {
    return await _getRandomNumber(() {
      return remoteDataSource.getConcreteRandomNumber(number);
    });
  }

  @override
  Future<Either<Failure, RandomNumber>> getRandomNumber() async {
    return await _getRandomNumber(() {
      return remoteDataSource.getRandomNumber();
    });
  }

  Future<Either<Failure, RandomNumber>> _getRandomNumber(
      _ConcreteOrRandomChooser getConcreteOrRandom,
      ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteRandom = await getConcreteOrRandom();
        localDataSource.cacheRandomNumber(remoteRandom);
        return Right(remoteRandom);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localRandom = await localDataSource.getLastRandomNumber();
        return Right(localRandom);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}