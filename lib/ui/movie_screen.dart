import 'package:final_mobile_project/model/moive.dart';
import 'package:final_mobile_project/service/movie_service.dart';
import 'package:final_mobile_project/state_managment/movie_bloc.dart';
import 'package:final_mobile_project/ui/movie_detail_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../state_managment/movie_event.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen(
      {super.key,
      required this.inputMovieAddOn,
      required this.inputFavoriteMovie,
      required this.addFavorite,
      required this.removeFavorite});
  final List<MovieAddOn> inputMovieAddOn;
  final List<String> inputFavoriteMovie;
  final Function(String) addFavorite;
  final Function(String) removeFavorite;
  @override
  State<MovieScreen> createState() => _MovieScreenState();

  bool checkFavorite(String title) {
    if (inputFavoriteMovie.indexWhere((element) => element == title) == -1) {
      return false;
    } else {
      return true;
    }
  }
}

class _MovieScreenState extends State<MovieScreen> {
  late List<MovieAddOn> movieAddon;
  late MovieBloc movieBloc;
  late List<String> favoriteMovie;
  MovieAddOn findMovieAddOn(String title) {
    final index = movieAddon.indexWhere((element) => element.title == title);
    return movieAddon[index];
  }

  void addFavorite(String title) {
    setState(() {});
  }

  void removeFavorite(String title) {
    setState(() {
      widget.removeFavorite(title);
    });
  }

  @override
  void initState() {
    super.initState();
    movieBloc = MovieBloc(service: MovieService());
    movieBloc.add(GetMovieEvent());

    movieAddon = widget.inputMovieAddOn;
    favoriteMovie = widget.inputFavoriteMovie;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MovieBloc>(
      create: (context) => movieBloc,
      child: Container(
        color: Colors.black,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 10),
                child: Row(
                  children: [
                    Text('Welcome to NungKai Movie',
                        style: GoogleFonts.ubuntu(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(
                      Icons.waving_hand_rounded,
                      color: Color.fromRGBO(255, 197, 0, 1.0),
                      size: 30,
                      weight: 20,
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      'Find movie that you want.',
                      style: GoogleFonts.ubuntu(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: TextField(
                  cursorColor: Colors.yellow,
                  onChanged: (String input) {
                    movieBloc.add(GetMovieByNameEvent(name: input));
                  },
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      border: OutlineInputBorder(),
                      hintText: 'Enter movie name',
                      hintStyle: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 20),
              BlocBuilder<MovieBloc, MovieState>(
                builder: (context, state) {
                  if (state is MovieLoading) {
                    return Container(
                      height: 650,
                      color: Colors.black,
                      child: const Center(
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  } else if (state is MovieLoadSuccess) {
                    return Wrap(
                      children: state.movies
                          .map((movie) => MovieBox(
                                moviePoster: movie.poster,
                                movieName: movie.title,
                                movieRuntime: movie.runtime,
                                movieYear: movie.year,
                                isFavorite: widget.checkFavorite(movie.title),
                                addFavorite: (String title) {
                                  setState(() {
                                    widget.addFavorite(title);
                                  });
                                },
                                removeFavorite: (String title) {
                                  setState(() {
                                    widget.removeFavorite(title);
                                  });
                                },
                                movieAddOn: findMovieAddOn(movie.title),
                              ))
                          .toList(),
                    );
                  } else {
                    return const Text(
                      'No movies available',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MovieBox extends StatelessWidget {
  const MovieBox(
      {super.key,
      required this.moviePoster,
      required this.movieName,
      required this.movieRuntime,
      required this.movieYear,
      required this.isFavorite,
      required this.addFavorite,
      required this.removeFavorite,
      required this.movieAddOn});
  final String? moviePoster;
  final String? movieName;
  final String? movieRuntime;
  final String? movieYear;
  final MovieAddOn movieAddOn;
  final bool isFavorite;
  final Function(String) addFavorite;
  final Function(String) removeFavorite;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      margin: const EdgeInsets.all(7),
      width: 175,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MovieDetailScreen(
                              moviePoster: moviePoster ?? '',
                              movieTitle: movieName ?? '',
                              movieRuntime: movieRuntime ?? '',
                              movieYear: movieYear ?? '',
                              movieAddOn: movieAddOn,
                              isFavorite: isFavorite,
                              addFavorite: addFavorite,
                              removeFavorite: removeFavorite,
                            )),
                  );
                },
                child: Image.network(moviePoster ?? '',
                    errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error);
                }),
              ),
              if (isFavorite)
                IconButton(
                    onPressed: () {
                      removeFavorite(movieName!);
                    },
                    icon: const Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 32,
                    ))
              else
                IconButton(
                    onPressed: () {
                      addFavorite(movieName!);
                    },
                    icon: const Icon(
                      Icons.star_border_outlined,
                      color: Colors.white,
                      size: 32,
                    ))
            ],
          ),
          Container(
            color: Colors.black,
            height: 50,
            width: double.infinity,
            child: Center(
              child: Text(
                movieName!,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
