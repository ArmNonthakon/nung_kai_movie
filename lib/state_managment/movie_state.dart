part of 'movie_bloc.dart';

abstract class MovieState {}

final class MovieInitial extends MovieState {}

final class MovieLoading extends MovieState {}

final class MovieLoadSuccess extends MovieState {
  List<Movie> movies;
  MovieLoadSuccess({required this.movies});
}

final class MovieLoadFailed extends MovieState {
  String error;
  MovieLoadFailed({required this.error});
}
