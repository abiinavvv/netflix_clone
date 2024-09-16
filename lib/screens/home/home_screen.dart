import 'package:cloned_netflix/api/api.dart';
import 'package:cloned_netflix/model/movie_model.dart';
import 'package:cloned_netflix/screens/home/widget/home_carousel.dart';
import 'package:cloned_netflix/screens/home/widget/home_movie_card.dart';
import 'package:cloned_netflix/screens/search/search_screen.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<Movie>> upcoming;
  late Future<List<Movie>> nowPlaying;
  late Future<List<Movie>> topRated;

  @override
  void initState() {
    super.initState();
    upcoming = Api().getUpcomingMovie();
    nowPlaying = Api().getNowPlaying();
    topRated = Api().getTopRated();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.asset(
          'assets/netflix.png',
          height: 80,
          width: 120,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => const Search()));
              },
              child: const Icon(
                Icons.search,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Container(
              color: Colors.blue,
              height: 27,
              width: 27,
            ),
          ),
          //sbw20
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
                future: topRated,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else if (snapshot.hasData) {
                    return Carousel(
                      data: snapshot.data!,
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                }),
            SizedBox(
              height: 220,
              child:
                  MovieCard(movie: nowPlaying, headline: 'Now Playing Movies'),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 220,
              child: MovieCard(movie: upcoming, headline: 'Upcoming Movies'),
            )
          ],
        ),
      ),
    );
  }
}
