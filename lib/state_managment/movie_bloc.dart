import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_mobile_project/service/movie_service.dart';
import '../model/moive.dart';
import 'movie_event.dart';

part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieService service;
  List<Movie> result = [];

  MovieBloc({required this.service}) : super(MovieInitial()) {
    on<GetMovieEvent>(getAllMovie);
    on<GetMovieByNameEvent>(getMovieByName);
    on<GetMovieByFavoriteEvent>(getMovieByFavorite);
  }

  Future<void> getAllMovie(
      GetMovieEvent event, Emitter<MovieState> emit) async {
    try {
      emit(MovieLoading());
      result = await service.getMovieDetail();
      emit(MovieLoadSuccess(movies: result));
    } catch (e) {
      emit(MovieLoadFailed(error: 'An error occurred: ${e.toString()}'));
    }
  }

  Future<void> getMovieByFavorite(
      GetMovieByFavoriteEvent event, Emitter<MovieState> emit) async {
    try {
      List<Movie> favoriteResult = [];
      result = await service.getMovieDetail();
      emit(MovieLoading());
      for (final data in result) {
        if (event.favorite.indexWhere((element) => element == data.title) ==
            -1) {
          continue;
        } else {
          favoriteResult.add(data);
        }
      }
      if (favoriteResult.isEmpty) {
        emit(MovieLoadFailed(error: 'Not found'));
      } else {
        emit(MovieLoadSuccess(movies: favoriteResult));
      }
    } catch (e) {
      emit(MovieLoadFailed(error: 'An error occurred: ${e.toString()}'));
    }
  }

  Future<void> getMovieByName(
      GetMovieByNameEvent event, Emitter<MovieState> emit) async {
    try {
      if (event.name.isEmpty) {
        emit(MovieLoadSuccess(movies: result));
      } else {
        final movie = result.firstWhere(
          (element) => element.title.toLowerCase() == event.name.toLowerCase(),
          orElse: () => throw Exception('Not found'),
        );
        emit(MovieLoadSuccess(movies: [movie]));
      }
    } catch (e) {
      emit(MovieLoadFailed(error: e.toString()));
    }
  }
}
