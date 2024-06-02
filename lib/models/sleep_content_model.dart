class SleepContent {
  final String category;
  final String name;
  final String description;
  final int duration;
  final String audioUrl;

  SleepContent({
    required this.category,
    required this.name,
    required this.description,
    required this.duration,
    required this.audioUrl,
  });

  factory SleepContent.fromJson(Map<String, dynamic> json) {
    return SleepContent(
      category: json['category'],
      name: json['name'],
      description: json['description'],
      duration: json['duration'],
      audioUrl: json['audio_url'],
    );
  }

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
