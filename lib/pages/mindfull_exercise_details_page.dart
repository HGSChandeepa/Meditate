import 'package:flutter/material.dart';
import 'package:meditation/models/mindfull_exercise_model.dart';
import 'package:url_launcher/url_launcher.dart';

class MidfullExerciseDetailsPage extends StatelessWidget {
  final MindfulnessExercise mindfullExercise;
  const MidfullExerciseDetailsPage({
    super.key,
    required this.mindfullExercise,
  });

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mindful Exercise Details'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mindfullExercise.name,
                ),
                const SizedBox(height: 10),
                Text(
                  mindfullExercise.category,
                ),
                const SizedBox(height: 20),
                Text(
                  mindfullExercise.description,
                ),
                const SizedBox(height: 20),
                Text(
                  'Instructions',
                ),
                const SizedBox(height: 10),
                ...mindfullExercise.instructions.map(
                  (instruction) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.circle, size: 8),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            instruction,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Icon(Icons.timer, color: Colors.grey),
                    const SizedBox(width: 8),
                    Text(
                      '${mindfullExercise.duration} minutes',
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    // Handle navigation to instructions URL
                    await _launchURL(mindfullExercise.instructionsUrl);
                  },
                  child: const Text('View Detailed Instructions'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
