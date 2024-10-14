class Movie {
  String title;
  String year;
  String runtime;
  String? poster;
  Movie(
      {required this.title,
      required this.year,
      required this.runtime,
      required this.poster});
}

class MovieAddOn {
  String title;
  String director;
  List<String> stars;
  bool isSupportDisney;
  bool isSupportNetflix;
  bool isSupportHbo;
  bool isSupportPrime;
  String disneyUrl = '';
  String netflixUrl = '';
  String hboUrl = '';
  String primeUrl = '';
  MovieAddOn(
      {required this.title,
      required this.director,
      required this.stars,
      required this.isSupportDisney,
      required this.isSupportHbo,
      required this.isSupportNetflix,
      required this.isSupportPrime,
      required this.primeUrl,
      required this.netflixUrl,
      required this.hboUrl,
      required this.disneyUrl});
}
