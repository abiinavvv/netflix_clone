import 'package:cloned_netflix/api/api.dart';
import 'package:cloned_netflix/model/reels.dart';
import 'package:cloned_netflix/screens/reelFlix/widget/reel_flix_video.dart';
import 'package:flutter/material.dart';

class FastLaugh extends StatefulWidget {
  const FastLaugh({super.key});

  @override
  State<FastLaugh> createState() => _FastLaughState();
}

class _FastLaughState extends State<FastLaugh> {
  late Future<List<Reel>> fastLaugh;

  @override
  void initState() {
    super.initState();
    fastLaugh = Api().getReels();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<List<Reel>>(
          future: fastLaugh,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error loading reels.'));
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return PageView.builder(
                itemCount: snapshot.data!.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  final reel = snapshot.data![index];
                  return ReelFlixVideo(reel: reel);
                },
              );
            } else {
              return const Center(child: Text('No videos available.'));
            }
          },
        ),
      ),
    );
  }
}
