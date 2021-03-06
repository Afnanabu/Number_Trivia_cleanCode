import 'dart:convert';

import 'package:cleanarchitectureproject/core/error/exceptions.dart';
import 'package:cleanarchitectureproject/features/number_trivia/data/models/number_trivia_models.dart';
import 'package:shared_preferences/shared_preferences.dart';


abstract class RandomNumberLocalDataSource {
  Future<RandomNumberModel> getLastRandomNumber();

  Future<void> cacheRandomNumber(RandomNumberModel triviaToCache);
}

const CACHED_NUMBER_TRIVIA = 'CACHED_NUMBER_TRIVIA';

class RandomNumberLocalDataSourceImpl implements RandomNumberLocalDataSource {
  final SharedPreferences sharedPreferences;

  RandomNumberLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<RandomNumberModel> getLastRandomNumber() {
    final jsonString = sharedPreferences.getString(CACHED_NUMBER_TRIVIA);
    if (jsonString != null) {
      return Future.value(RandomNumberModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheRandomNumber(RandomNumberModel triviaToCache) {
    return sharedPreferences.setString(
      CACHED_NUMBER_TRIVIA,
      json.encode(triviaToCache.toJson()),
    );
  }
}