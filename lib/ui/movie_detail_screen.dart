import 'package:final_mobile_project/model/moive.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({
    super.key,
    required this.moviePoster,
    required this.movieTitle,
    required this.movieRuntime,
    required this.movieYear,
    required this.movieAddOn,
    required this.isFavorite,
    required this.addFavorite,
    required this.removeFavorite,
  });

  final String movieTitle;
  final String moviePoster;
  final String movieRuntime;
  final String movieYear;
  final bool isFavorite;
  final MovieAddOn movieAddOn;
  final Function(String) addFavorite;
  final Function(String) removeFavorite;

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite; // Initialize the state
  }

  void openUrl(String url) {
    launchUrl(Uri.parse(url));
  }

  String? genStars() {
    return widget.movieAddOn.stars.join(', '); // Simplified star generation
  }

  void _toggleFavorite() {
    setState(() {
      if (_isFavorite) {
        widget.removeFavorite(widget.movieTitle);
      } else {
        widget.addFavorite(widget.movieTitle);
      }
      _isFavorite = !_isFavorite; // Toggle the favorite state
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Colors.black,
          actions: [
            IconButton(
              icon: Icon(
                _isFavorite ? Icons.star : Icons.star_border,
                size: 32,
              ),
              color: _isFavorite ? Colors.yellow : Colors.white,
              onPressed: _toggleFavorite,
            ),
            const SizedBox(width: 10),
          ],
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Text(
                    widget.movieTitle,
                    style: GoogleFonts.ubuntu(
                      color: Colors.yellow,
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(5),
                  color: Colors.grey,
                  child: Image.network(widget.moviePoster),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Card(
                          color: const Color.fromRGBO(224, 224, 224, 1.0),
                          child: ListTile(
                            leading: const Icon(Icons.movie),
                            title: const Text(
                              'Year',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            subtitle: Text(
                              widget.movieYear,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Card(
                          color: const Color.fromRGBO(224, 224, 224, 1.0),
                          child: ListTile(
                            leading: const Icon(Icons.watch_later_outlined),
                            title: const Text(
                              'Runtime',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            subtitle: Text(
                              widget.movieRuntime,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  color: const Color.fromRGBO(224, 224, 224, 1.0),
                  child: ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text(
                      'Director',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    subtitle: Text(
                      widget.movieAddOn.director,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Card(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  color: const Color.fromRGBO(224, 224, 224, 1.0),
                  child: ListTile(
                    leading: const Icon(Icons.wc),
                    title: const Text(
                      'Stars',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    subtitle: Text(
                      genStars() ?? '',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  padding:
                      const EdgeInsets.only(left: 30, right: 30, bottom: 10),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    color: Color.fromRGBO(224, 224, 224, 1.0),
                  ),
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          Text(
                            'Streaming Platform',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (widget.movieAddOn.isSupportDisney)
                              GestureDetector(
                                  onTap: () {
                                    openUrl(widget.movieAddOn.disneyUrl);
                                  },
                                  child: Image.asset('assets/Icon.jpeg')),
                            const SizedBox(width: 20),
                            if (widget.movieAddOn.isSupportNetflix)
                              GestureDetector(
                                  onTap: () {
                                    openUrl(widget.movieAddOn.netflixUrl);
                                  },
                                  child: Image.asset('assets/netflix.png')),
                            const SizedBox(width: 20),
                            if (widget.movieAddOn.isSupportHbo)
                              GestureDetector(
                                  onTap: () {
                                    openUrl(widget.movieAddOn.hboUrl);
                                  },
                                  child: Image.asset('assets/hbo.png')),
                            const SizedBox(width: 20),
                            if (widget.movieAddOn.isSupportPrime)
                              GestureDetector(
                                onTap: () {
                                  openUrl(widget.movieAddOn.primeUrl);
                                },
                                child: SizedBox(
                                  height: 100,
                                  child: Container(
                                    padding: const EdgeInsets.all(3),
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                    ),
                                    child: Image.asset(
                                        'assets/icons8-amazon-prime-192.png'),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
