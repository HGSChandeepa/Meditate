import 'package:flutter/material.dart';
import 'package:meditation/models/mindfull_exercise_model.dart';

class MindFullExerciseTimer extends StatelessWidget {
  final MindfulnessExercise mindfullExercise;

  const MindFullExerciseTimer({
    super.key,
    required this.mindfullExercise,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(mindfullExercise.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              mindfullExercise.category,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              mindfullExercise.name,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Duration: ${mindfullExercise.duration} minutes',
              style: const TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              mindfullExercise.description,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Instructions:',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ...mindfullExercise.instructions.map((instruction) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(
                    '- $instruction',
                    style: const TextStyle(fontSize: 18),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
