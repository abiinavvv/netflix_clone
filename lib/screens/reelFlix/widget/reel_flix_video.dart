import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:cloned_netflix/model/reels.dart';

class ReelFlixVideo extends StatefulWidget {
  final Reel reel;

  const ReelFlixVideo({super.key, required this.reel});

  @override
  State<ReelFlixVideo> createState() => _ReelFlixVideoState();
}

class _ReelFlixVideoState extends State<ReelFlixVideo> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.reel.videoUrl)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
    _controller.setLooping(true); // Loop the video
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        // Video Display
        if (_controller.value.isInitialized)
          FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: _controller.value.size.width,
              height: _controller.value.size.height,
              child: VideoPlayer(_controller),
            ),
          )
        else
          const Center(child: CircularProgressIndicator()),

        // Overlay for Video Details and Buttons
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title and Description
              Text(
                widget.reel.title,
                style: const TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
              ),
              Text(
                widget.reel.description,
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 16),

              // Buttons (Like, Comment, Share)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          // Handle Like Action
                        },
                        icon: const Icon(Icons.favorite, color: Colors.red, size: 30),
                      ),
                      Text(
                        '${widget.reel.likes} Likes',
                        style: const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          // Handle Comment Action
                        },
                        icon: const Icon(Icons.comment, color: Colors.white, size: 30),
                      ),
                      Text(
                        '${widget.reel.comments} Comments',
                        style: const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      // Handle Share Action
                    },
                    icon: const Icon(Icons.share, color: Colors.white, size: 30),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
