import 'package:flutter_test/flutter_test.dart';
import 'package:final_mobile_project/ui/movie_screen.dart';

void main() {
  group('MovieScreen', () {
    late MovieScreen movieScreen;
    late List<String> favoriteMovies;

    setUp(() {
      favoriteMovies = ['The Lion King', 'John wick'];
      movieScreen = MovieScreen(
        inputMovieAddOn: const [], // Provide necessary MovieAddOn data
        inputFavoriteMovie: favoriteMovies,
        addFavorite: (String title) {
          favoriteMovies.add(title);
        },
        removeFavorite: (String title) {
          favoriteMovies.remove(title);
        },
      );
    });

    test('Test checkFavorite() should return true when input The Lion King',
        () {
      expect(movieScreen.checkFavorite('The Lion King'), true);
    });

    test('Test checkFavorite() should return false when input John Wick part 2',
        () {
      expect(movieScreen.checkFavorite('John Wick part 2'), false);
    });
  });
}
