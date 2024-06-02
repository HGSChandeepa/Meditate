class MindfulnessExercise {
  final String category;
  final String name;
  final String description;
  final List<String> instructions;
  final int duration;
  final String instructionsUrl;

  MindfulnessExercise({
    required this.category,
    required this.name,
    required this.description,
    required this.instructions,
    required this.duration,
    required this.instructionsUrl,
  });

  factory MindfulnessExercise.fromJson(Map<String, dynamic> json) {
    return MindfulnessExercise(
      category: json['category'],
      name: json['name'],
      description: json['description'],
      instructions: List<String>.from(json['instructions']),
      duration: json['duration'],
      instructionsUrl: json['instructions_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'name': name,
      'description': description,
      'instructions': instructions,
      'duration': duration,
      'instructions_url': instructionsUrl,
    };
  }
}
