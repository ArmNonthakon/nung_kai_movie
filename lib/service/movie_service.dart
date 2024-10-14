import 'dart:developer';

import 'package:final_mobile_project/model/moive.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class MovieService {
  Future<List<Movie>> getMovieDetail() async {
    List<Movie> movies = [];
    var url = Uri.https('my-json-server.typicode.com',
        '/horizon-code-academy/fake-movies-api/movies');

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body) as List<dynamic>;

      for (int i = 0; i < 4; i++) {
        var result = jsonResponse[i] as Map<String, dynamic>;
        Movie movie = Movie(
            title: result['Title'],
            year: result['Year'],
            runtime: result['Runtime'],
            poster: result['Poster']);
        movies.add(movie);
      }
    } else {
      log('error');
    }
    return movies;
  }
}
