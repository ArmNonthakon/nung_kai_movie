abstract class MovieEvent {}

class GetMovieEvent extends MovieEvent {}

class GetMovieByNameEvent extends MovieEvent {
  String name;
  GetMovieByNameEvent({required this.name});
}

class GetMovieByFavoriteEvent extends MovieEvent {
  List<String> favorite;
  GetMovieByFavoriteEvent({required this.favorite});
}
