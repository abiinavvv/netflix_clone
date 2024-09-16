import 'package:cloned_netflix/api/api.dart';
import 'package:cloned_netflix/model/movie_model.dart';
import 'package:cloned_netflix/screens/newnhot/widget/newnhot_coming_soon.dart';
import 'package:flutter/material.dart';

class NewnHot extends StatefulWidget {
  const NewnHot({super.key});

  @override
  State<NewnHot> createState() => _NewnHotState();
}

class _NewnHotState extends State<NewnHot> {
  late Future<List<Movie>> upcoming;

  @override
  void initState() {
    super.initState();
    upcoming = Api().getUpcomingMovie();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: SafeArea(
            child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.black,
            title: const Text(
              'New & Hot',
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              const Icon(
                Icons.cast,
                color: Colors.white,
              ),
              const SizedBox(
                width: 20,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  color: Colors.blue,
                  height: 27,
                  width: 27,
                ),
              ),
              const SizedBox(
                width: 20,
              )
            ],
            bottom: TabBar(
                dividerColor: Colors.black,
                isScrollable: false,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                labelColor: Colors.black,
                labelStyle:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                unselectedLabelColor: Colors.white,
                tabs: const [
                  Tab(
                    text: '     🍿 Coming Soon     ',
                  ),
                  Tab(
                    text: "     🎥 Everyone's watching     ",
                  )
                ]),
          ),
          body: FutureBuilder(
            future: upcoming,
            builder: ((context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.only(top: 15, right: 10),
                  child: TabBarView(children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          ComingSoon(
                            title: snapshot.data![0].title,
                            posterPath: snapshot.data![0].backdropPath,
                            overView: snapshot.data![0].overview,
                            date: snapshot.data![0].releaseDate,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ComingSoon(
                            title: snapshot.data![1].title,
                            posterPath: snapshot.data![1].backdropPath,
                            overView: snapshot.data![1].overview,
                            date: snapshot.data![1].releaseDate,
                          ),
                        ],
                      ),
                    ),
                    ComingSoon(
                      title: snapshot.data![2].title,
                      posterPath: snapshot.data![2].backdropPath,
                      overView: snapshot.data![2].overview,
                      date: snapshot.data![2].releaseDate,
                    ),
                  ]),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
          ),
        )));
  }
}
