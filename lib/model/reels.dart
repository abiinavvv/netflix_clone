class Reel {
  final int id;
  final String title;
  final String description;
  final String videoUrl;
  final String duration;
  final int likes;
  final int comments;

  Reel({
    required this.id,
    required this.title,
    required this.description,
    required this.videoUrl,
    required this.duration,
    required this.likes,
    required this.comments,
  });

  factory Reel.fromJson(Map<String, dynamic> json) {
    return Reel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      videoUrl: json['videoUrl'],
      duration: json['duration'],
      likes: json['likes'],
      comments: json['comments'],
    );
  }
}
