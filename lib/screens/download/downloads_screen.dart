import 'dart:math';
import 'package:cloned_netflix/api/api.dart';
import 'package:cloned_netflix/constant/space.dart';
import 'package:cloned_netflix/model/movie_model.dart';
import 'package:cloned_netflix/screens/download/widgets/download_image.dart';
import 'package:cloned_netflix/screens/download/widgets/download_tile.dart';
import 'package:flutter/material.dart';

class Downloads extends StatefulWidget {
  const Downloads({super.key});

  @override
  State<Downloads> createState() => _DownloadsState();
}

class _DownloadsState extends State<Downloads> {
  late Future<List<Movie>> trending;

  @override
  void initState() {
    super.initState();
    trending = Api().getTrendingMovies();
  }

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        title: const Text(
          'Downloads',
          style: TextStyle(color: Colors.white),
        ),
        actions: const [
          Icon(
            Icons.cast,
            color: Colors.white,
          ),
          SizedBox(
            width: 20,
          ),
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(6),
          //   child: Container(
          //     color: Colors.blue,
          //     height: 27,
          //     width: 27,
          //   ),
          // ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            const DownloadTitle(),
            smallHeight,
            const Text(
              'Introducing Downloads for you',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            smallHeight,
            const Text(
              textAlign: TextAlign.center,
              "We will downloads a personalised selections of\nmovies and shows for you, so there's\nalways something to watch on your device.",
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            SizedBox(
                width: width * 0.85,
                height: width * 0.85,
                child: FutureBuilder(
                    future: trending,
                    builder: ((context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      } else if (snapshot.hasData) {
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            CircleAvatar(
                              radius: width * 0.4,
                              backgroundColor:
                                  const Color.fromARGB(255, 99, 99, 99)
                                      .withOpacity(0.5),
                            ),
                            DownloadsImages(
                              data: snapshot.data![0].posterPath,
                              angle: 20 * pi / 180,
                              margin: const EdgeInsets.only(left: 130),
                            ),
                            DownloadsImages(
                              data: snapshot.data![1].posterPath,
                              angle: -20 * pi / 180,
                              margin: const EdgeInsets.only(right: 130),
                            ),
                            DownloadsImages(
                              data: snapshot.data![2].posterPath,
                              margin: const EdgeInsets.all(0),
                            )
                          ],
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }))),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                onPressed: () {},
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                color: Colors.blue,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Set up',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                onPressed: () {},
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                color: Colors.white,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'See what you can download',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
