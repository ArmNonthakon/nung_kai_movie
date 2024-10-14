import 'package:final_mobile_project/ui/favorite_movie_screen.dart';
import 'package:final_mobile_project/ui/login_screen.dart';
import 'package:final_mobile_project/ui/movie_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'model/moive.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.green),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<MovieAddOn> movieAddon = [
    MovieAddOn(
        title: 'The Lion King',
        director: 'Jon Favreau',
        stars: ['Donald Glover', 'Beyoncé', 'Seth Rogen'],
        isSupportDisney: true,
        isSupportHbo: false,
        isSupportNetflix: false,
        isSupportPrime: true,
        netflixUrl: '',
        hboUrl: '',
        disneyUrl:
            'https://www.hotstar.com/th/movies/the-lion-king/1260014782/watch?gclsrc=aw.ds,aw.ds?gclsrc=aw.ds,aw.ds',
        primeUrl:
            'https://www.primevideo.com/detail/The-Lion-King/0STC3IHET5HVC3DAUFRGXAEERS'),
    MovieAddOn(
      title: 'Mowgli: Legend of the Jungle',
      director: 'Andy Serkis',
      stars: ['Christian Bale', 'Cate Blanchett', 'Benedict Cumberbatch'],
      isSupportDisney: false,
      isSupportHbo: false,
      isSupportNetflix: true,
      isSupportPrime: false,
      netflixUrl: 'https://www.netflix.com/th-en/title/80993105',
      hboUrl: '',
      disneyUrl: '',
      primeUrl: '',
    ),
    MovieAddOn(
      title: 'Doctor Strange',
      director: 'Scott Derrickson',
      stars: ['Benedict Cumberbatch', 'Chiwetel Ejiofor', 'Rachel McAdams'],
      isSupportDisney: true,
      isSupportHbo: false,
      isSupportNetflix: false,
      isSupportPrime: true,
      netflixUrl: '',
      hboUrl: '',
      disneyUrl:
          'https://www.disneyplus.com/movies/doctor-strange-in-the-multiverse-of-madness/27EiqSW4jIyH',
      primeUrl:
          'https://www.primevideo.com/-/th/detail/Marvel-Studios-Doctor-Strange/0HONI8MG6WWYXHPBHZ6HMT3T60',
    ),
    MovieAddOn(
      title: 'John Wick',
      director: 'Derek Kolstad',
      stars: ['Keanu Reeves', 'Michael Nyqvist', 'Alfie Allen'],
      isSupportDisney: false,
      isSupportHbo: false,
      isSupportNetflix: true,
      isSupportPrime: true,
      netflixUrl: 'https://www.netflix.com/th/title/80013762',
      hboUrl: '',
      disneyUrl: '',
      primeUrl:
          'https://www.primevideo.com/-/th/detail/John-Wick/0TVPCYD0O72PWBN6RPOLSNKTNG',
    ),
  ];
  late List<Widget> destinationScreen;
  List<String> favoriteMovie = [];
  int currentScreen = 0;
  String user = '';
  bool isLogin = false;
  bool addFavorite(String title) {
    try {
      setState(() {
        favoriteMovie.add(title);
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  bool removeFavorite(String title) {
    try {
      setState(() {
        favoriteMovie.removeWhere((element) => element == title);
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );

    if (!context.mounted) return;
    setState(() {
      user = result;
      isLogin = true;
    });
  }

  @override
  void initState() {
    destinationScreen = [
      MovieScreen(
        inputMovieAddOn: movieAddon,
        inputFavoriteMovie: favoriteMovie,
        addFavorite: addFavorite,
        removeFavorite: removeFavorite,
      ),
      FavoriteScreen(
        inputMovieAddOn: movieAddon,
        inputFavoriteMovie: favoriteMovie,
        addFavorite: addFavorite,
        removeFavorite: removeFavorite,
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          actions: [
            Text(
              isLogin == true ? user : 'Please login',
              style: GoogleFonts.ubuntu(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            IconButton(
                onPressed: () {
                  if (isLogin) {
                    setState(() {
                      isLogin = false;
                      user = '';
                    });
                  } else {
                    _navigateAndDisplaySelection(context);
                  }
                },
                icon: Icon(
                  isLogin == true ? Icons.login : Icons.logout,
                  color: isLogin == true ? Colors.red : Colors.yellow,
                )),
            const Text('   ')
          ],
        ),
        body: destinationScreen[currentScreen],
        bottomNavigationBar: NavigationBar(
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          height: 60,
          shadowColor: Colors.black,
          indicatorColor: Colors.black,
          backgroundColor: const Color.fromRGBO(9, 54, 114, 1),
          surfaceTintColor: Colors.black,
          onDestinationSelected: (index) {
            setState(() {
              currentScreen = index;
            });
          },
          selectedIndex: currentScreen,
          destinations: const [
            NavigationDestination(
                icon: Icon(
                  Icons.movie,
                  size: 28,
                  color: Colors.white,
                ),
                label: 'Movie'),
            NavigationDestination(
                icon: Icon(
                  Icons.bookmark_add,
                  size: 28,
                  color: Colors.white,
                ),
                label: 'Favorite')
          ],
        ),
      ),
    );
  }
}
