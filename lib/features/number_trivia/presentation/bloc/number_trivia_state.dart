import 'package:cleanarchitectureproject/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RandomNumberState extends Equatable {
  @override
  List<Object> get props => [];
}

class Empty extends RandomNumberState {}

class Loading extends RandomNumberState {}

class Loaded extends RandomNumberState {
  final RandomNumber random;

  Loaded({required this.random});

  @override
  List<Object> get props => [random];
}

class Error extends RandomNumberState {
  final String message;

  Error({required this.message});

  @override
  List<Object> get props => [message];
}