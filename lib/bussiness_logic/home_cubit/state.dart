part of 'cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class MoviesLoaded extends HomeState {}

class MoviesSuccess extends HomeState {}

class MoviesError extends HomeState {
  final String error;

  MoviesError(this.error);

}

class LocalMoviesLoaded extends HomeState {}

class LocalMoviesSuccess extends HomeState {}

class LocalMoviesError extends HomeState {
  final String error;

  LocalMoviesError(this.error);

}

class RefreshMoviesLoaded extends HomeState {}

class RefreshMoviesSuccess extends HomeState {}

class RefreshMoviesError extends HomeState {
  final String error;

  RefreshMoviesError(this.error);

}