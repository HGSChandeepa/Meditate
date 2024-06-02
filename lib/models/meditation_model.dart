class MeditationContent {
  final String category;
  final String name;
  final String description;
  final int duration;
  final String audioUrl;

  MeditationContent({
    required this.category,
    required this.name,
    required this.description,
    required this.duration,
    required this.audioUrl,
  });

  // This method is used to convert the JSON data from the API into a Dart object.

  factory MeditationContent.fromJson(Map<String, dynamic> json) {
    return MeditationContent(
      category: json['category'],
      name: json['name'],
      description: json['description'],
      duration: json['duration'],
      audioUrl: json['audio_url'],
    );
  }

  // This method is used to convert the Dart object into a JSON object that can be sent to the API.

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'name': name,
      'description': description,
      'duration': duration,
      'audio_url': audioUrl,
    };
  }
}
