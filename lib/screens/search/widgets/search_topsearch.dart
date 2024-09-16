import 'package:cloned_netflix/constant/apiKey.dart';
import 'package:cloned_netflix/model/movie_model.dart';
import 'package:cloned_netflix/screens/details/details_screen.dart';
import 'package:flutter/material.dart';

class TopSearch extends StatelessWidget {
  final List<Movie>? movies;
  const TopSearch({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 30,
        ),
        const Text('Top Searches',
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(
          height: 20,
        ),
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: movies?.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final movie = movies![index];

              return InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MovieDetail(id: movie.id))),
                child: Container(
                  height: 150,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Image.network('$imageurl${movie.posterPath}'),
                      const SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        width: 260,
                        child: Text(
                          movie.title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      )
                    ],
                  ),
                ),
              );
            })
      ],
    );
  }
}
