import 'dart:developer';

import 'package:cloned_netflix/screens/fastlaugh/widget/fast_laugh_column.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoList extends StatefulWidget {
  final String video;
  const VideoList({super.key, required this.video});

  @override
  State<VideoList> createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  late VideoPlayerController controller;
  bool isPlay = true;
  @override
  void initState() {
    super.initState();
    try {
      log('Video URL: ${widget.video}');



      controller = VideoPlayerController.networkUrl(Uri.parse(widget.video))
        ..initialize().then((_) {
          setState(() {
            controller.play();
            
          });
        }).catchError((error) {
          
          log('Error initializing video: $error');
        });
    } catch (e) {
      log('Exception during initState: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          controller.value.isInitialized
              ? VideoPlayer(controller)
              : const Center(child: CircularProgressIndicator(color: Colors.white,)),
          Align(
            alignment: Alignment.bottomLeft,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: CircleAvatar(
                    backgroundColor: const Color.fromARGB(139, 0, 0, 0),
                    foregroundColor: Colors.white,
                    radius: 30,
                    child: IconButton(
                        onPressed: () {}, icon: const Icon(Icons.volume_off)),
                  ),
                ),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CircleAvatar(),
                    IconColumn(icon: Icons.emoji_emotions, text: 'LOL'),
                    IconColumn(icon: Icons.add, text: 'My List'),
                    IconColumn(icon: Icons.share, text: 'Share'),
                    IconColumn(icon: Icons.play_arrow, text: 'Play')
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
