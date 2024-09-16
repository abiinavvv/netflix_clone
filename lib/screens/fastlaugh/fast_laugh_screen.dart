import 'package:cloned_netflix/api/api.dart';
import 'package:cloned_netflix/screens/fastlaugh/widget/fast_laugh_video.dart';
import 'package:flutter/material.dart';

class FastLaugh extends StatefulWidget {
  const FastLaugh({super.key});

  @override
  State<FastLaugh> createState() => _FastLaughState();
}

class _FastLaughState extends State<FastLaugh> {
  late Future<List<String>> fastLaugh;

  @override
  void initState() {
    super.initState();
    fastLaugh = Api().getFastLaught();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: FutureBuilder(
              future: fastLaugh,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator(color: Colors.white,));
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else if (snapshot.hasData) {
                  return PageView.builder(
                      itemCount: snapshot.data!.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        // log(snapshot.data![index]);
                        var videos = snapshot.data as List<String>;
                        return VideoList(
                          video: videos[index],
                        );
                      });
                } else {
                  return const Text('nothing to show');
                }
              })),
    );
  }
}
