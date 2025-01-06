import 'dart:async';
import 'dart:developer';

import 'package:cloned_netflix/api/api.dart';
import 'package:cloned_netflix/constant/apiKey.dart';
import 'package:cloned_netflix/model/movie_model.dart';
import 'package:cloned_netflix/screens/details/details_screen.dart';
import 'package:cloned_netflix/screens/search/widgets/search_topsearch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController controller = TextEditingController();
  late Future<List<Movie>> search;
  late Future<List<Movie>> topSearch;
  List<Movie>? movie;
  Timer? _debounce;

  void searching(String query) {
    // Cancel the previous timer if it is still active
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    // Start a new debounce timer
    _debounce = Timer(const Duration(milliseconds: 1000), () {
      Api().getSearch(query).then((value) {
        setState(() {
          log(value.toString());
          movie = value;
        });
      }).catchError((error) {
        log('Error during search: $error');
      });
    });
  }

  @override
  void initState() {
    super.initState();
    topSearch = Api().getTopRated();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CupertinoSearchTextField(
              padding: const EdgeInsets.all(10),
              controller: controller,
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.grey,
              ),
              style: const TextStyle(color: Colors.white),
              backgroundColor: Colors.grey.withOpacity(0.3),
              onChanged: (value) {
                if (value.isEmpty) {
                } else {
                  searching(controller.text);
                }
              },
            ),
            controller.text.isEmpty
                ? FutureBuilder(
                    future: topSearch,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        );
                      } else if (!snapshot.hasData ||
                          snapshot.data == null ||
                          snapshot.data!.isEmpty) {
                        return const Text('No Movies');
                      }
                      return TopSearch(
                        movies: snapshot.data,
                      );
                    })
                : movie == null
                    ? const SizedBox.shrink()
                    : GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: movie?.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 15,
                                crossAxisSpacing: 5,
                                childAspectRatio: 1.2 / 2),
                        itemBuilder: ((context, index) {
                          return InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        MovieDetail(id: movie![index].id))),
                            child: SizedBox(
                              height: 50,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 70,
                                    child: movie![index].backdropPath.isEmpty
                                        ? Image.asset(
                                            'assets/logo.png',
                                            height: 50,
                                          )
                                        : Image.network(
                                            '$imageurl${movie?[index].backdropPath}',
                                            height: 170,
                                          ),
                                  ),
                                  SizedBox(
                                    width: 100,
                                    child: Text(
                                      movie![index].title,
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }))
          ],
        ),
      ),
    ));
  }
}
